import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/shared/time_select.dart';
import 'package:todo_app/shared/validated_field.dart';
import 'package:todo_app/shared/custom_text.dart';
import 'package:todo_app/utils/database_helper.dart';

import '../../utils/type_conv_helper.dart';
import 'error_validation.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails(
      {super.key,
      required this.task,
      required this.appBarTitle,
      required this.actionTitle,
      required this.databaseHelper,
      required this.updateTaskList});

  final Task task;
  final String appBarTitle;
  final String actionTitle;
  final DatabaseHelper databaseHelper;
  final StreamController updateTaskList;

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();

  StreamController<String?> titleErrorStream = StreamController();
  StreamController<String?> descErrorStream = StreamController();
  StreamController<String?> timeErrorStream = StreamController();

  String formError = "";

  @override
  void initState() {
    super.initState();
    titleCtrl.text = widget.task.title;
    descCtrl.text = widget.task.description;
    selectedDate = stringToDateTime(widget.task.date);
    startTime = stringToTimeOfDay(widget.task.startTime);
    endTime = stringToTimeOfDay(widget.task.endTime);
  }

  void selectDate() {
    showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    ).then((value) {
      setState(() {
        selectedDate = value!;
      });
    });
  }

  void selectTime(bool isStart) {
    showTimePicker(
      context: context,
      initialTime: isStart ? startTime : endTime,
    ).then((value) {
      setState(() {
        if (isStart) {
          startTime = value!;
        } else {
          endTime = value!;
        }
      });
    });
  }

  void handleAction() {
    final Future<Database> dbFuture =
        widget.databaseHelper.initializeDatabase();
    dbFuture.then((db) {
      if (widget.actionTitle == "Update") {
        Future<int> update = widget.databaseHelper.updateTask(widget.task);
        return update;
      }

      Future<int> add = widget.databaseHelper.insertTask(widget.task);
      return add;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: Color.fromARGB(255, 24, 59, 109)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: CustomText(
          text: widget.appBarTitle,
          size: 20,
          weight: FontWeight.w600,
          color: const Color.fromARGB(255, 24, 59, 109),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TITLE
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Title",
                    size: 20,
                    weight: FontWeight.w600,
                    color: const Color.fromARGB(255, 24, 59, 109),
                  ),
                  StreamBuilder<String?>(
                      stream: titleErrorStream.stream,
                      builder: (context, snapshot) {
                        String? data = snapshot.hasData ? snapshot.data : null;

                        return ValidatedField(
                          ln: 1,
                          ctrl: titleCtrl,
                          onValueChange: (val) =>
                              titleValidate(val, titleErrorStream),
                          error: data,
                        );
                      }),
                ],
              ),

              const SizedBox(height: 10),

              // DATE AND TIME
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Date & Time",
                    size: 20,
                    weight: FontWeight.w600,
                    color: const Color.fromARGB(255, 24, 59, 109),
                  ),
                  Card(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color.fromARGB(255, 164, 164, 164),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
                      child: ListTile(
                        hoverColor: Colors.white,
                        focusColor: Colors.white,
                        onTap: () => selectDate(),
                        title: CustomText(
                          text: dateTimeToString(selectedDate),
                          size: 16,
                          weight: FontWeight.w500,
                          color: const Color.fromARGB(255, 24, 59, 109),
                        ),
                        trailing: const Icon(Icons.calendar_month_rounded),
                      ),
                    ),
                  ),
                  StreamBuilder<String?>(
                      stream: timeErrorStream.stream,
                      builder: (context, snapshot) {
                        bool timeError =
                            snapshot.hasData ? snapshot.data != null : false;

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TimeSelect(
                                  title: "Start Time",
                                  timeError: timeError,
                                  selectTime: () => selectTime(true),
                                  time: startTime),
                              TimeSelect(
                                  title: "End Time",
                                  timeError: timeError,
                                  selectTime: () => selectTime(false),
                                  time: endTime),
                            ],
                          ),
                        );
                      }),
                ],
              ),

              const SizedBox(height: 10),

              // DESCRIPTION
              CustomText(
                text: "Description",
                size: 20,
                weight: FontWeight.w600,
                color: const Color.fromARGB(255, 24, 59, 109),
              ),

              StreamBuilder<String?>(
                  stream: descErrorStream.stream,
                  builder: (context, snapshot) {
                    String? data = snapshot.hasData ? snapshot.data : null;

                    return ValidatedField(
                      ln: 2,
                      ctrl: descCtrl,
                      onValueChange: (val) {
                        bool err = descValidate(val, descErrorStream);
                        if (err) setState(() {});
                      },
                      error: data,
                    );
                  }),

              const SizedBox(height: 20),

              // CREATE
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    bool titleErr =
                        titleValidate(titleCtrl.text, titleErrorStream);
                    bool descErr = descValidate(descCtrl.text, descErrorStream);
                    bool timeErr =
                        timeValidate(timeErrorStream, startTime, endTime);

                    if (!(titleErr || descErr || timeErr)) {
                      widget.task.title = titleCtrl.text;
                      widget.task.description = descCtrl.text;
                      widget.task.date = dateTimeToString(selectedDate);
                      widget.task.startTime =
                          timeOfDayToString(startTime, context);
                      widget.task.endTime = timeOfDayToString(endTime, context);

                      handleAction();
                      widget.updateTaskList.add(true);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                    child: CustomText(
                      text: widget.actionTitle,
                      size: 15,
                      weight: FontWeight.w400,
                      color: const Color.fromARGB(255, 238, 245, 255),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

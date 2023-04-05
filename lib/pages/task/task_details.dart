import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/shared/time_select.dart';
import 'package:todo_app/shared/validated_field.dart';
import 'package:todo_app/shared/custom_text.dart';
import 'package:todo_app/utils/database_helper.dart';

import '../../models/task_status.dart';
import '../../utils/type_conv_helper.dart';
import 'error_validation.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails(
      {super.key, required this.id, required this.updateTaskList});

  final int? id;
  final StreamController updateTaskList;

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class TaskWithStatus {
  TaskWithStatus(this.task, this.taskStatus);
  final Task task;
  final List<TaskStatus> taskStatus;
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

  StreamController<int> statusStream = StreamController();
  StreamController<DateTime> dateValueStream = StreamController();
  StreamController<TimeOfDay> startTimeValueStream = StreamController();
  StreamController<TimeOfDay> endTimeValueStream = StreamController();

  List<Map<String, dynamic>> statusList = [];

  String formError = "";

  DatabaseHelper databaseHelper = DatabaseHelper();
  String actionTitle = '';
  String appBarTitle = '';

  Task task = Task(null, '', '', '', '', '', 1);
  int statusVal = 0;

  void selectDate() {
    showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    ).then((value) {
      selectedDate = value!;
      dateValueStream.add(selectedDate);
    });
  }

  void selectTime(bool isStart) {
    showTimePicker(
      context: context,
      initialTime: isStart ? startTime : endTime,
    ).then((value) {
      if (isStart) {
        startTime = value!;
        startTimeValueStream.add(startTime);
      } else {
        endTime = value!;
        endTimeValueStream.add(endTime);
      }
    });
  }

  void handleUpdateOrCreate() {
    bool titleErr = titleValidate(titleCtrl.text, titleErrorStream);
    bool descErr = descValidate(descCtrl.text, descErrorStream);
    bool timeErr = timeValidate(timeErrorStream, startTime, endTime);

    if (!(titleErr || descErr || timeErr)) {
      task.title = titleCtrl.text;
      task.description = descCtrl.text;
      task.date = dateTimeToString(selectedDate);
      task.startTime = timeOfDayToString(startTime, context);
      task.endTime = timeOfDayToString(endTime, context);
      task.statusId = statusVal;

      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((db) {
        Future<int> addOrUpdate = actionTitle == "Update"
            ? databaseHelper.updateTask(task)
            : databaseHelper.insertTask(task);
        return addOrUpdate;
      });

      widget.updateTaskList.add(true);
      Navigator.of(context).pop();
    }
  }

  Future<TaskWithStatus> fetchData() async {
    var a = TaskWithStatus(await databaseHelper.getTaskWithId(widget.id!),
        await databaseHelper.getTaskStatusList());
    return a;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.id != null
            ? fetchData()
            : Future(
                () async {
                  return TaskWithStatus(Task(null, '', '', '', '', '', 1),
                      await databaseHelper.getTaskStatusList());
                },
              ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            task = snapshot.data!.task;
            statusVal = task.statusId;
            titleCtrl.text = task.title;
            descCtrl.text = task.description;
            selectedDate = stringToDateTime(task.date);
            startTime = stringToTimeOfDay(task.startTime);
            endTime = stringToTimeOfDay(task.endTime);

            TaskWithStatus obj = snapshot.data!;
            task = snapshot.hasData ? obj.task : task;
            for (var status in obj.taskStatus) {
              statusList.add({"id": status.id, "title": status.title});
            }

            if (startTime == endTime) {
              endTime =
                  TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute);
            }

            actionTitle = widget.id != null ? "Update" : "Create";
            appBarTitle = widget.id != null ? "Update Task" : "Add Task";
            List<DropdownMenuItem<int>> dropDownItems = [];

            for (var item in statusList) {
              dropDownItems.add(DropdownMenuItem<int>(
                value: item["id"],
                child: CustomText(
                  text: item["title"],
                  size: 15,
                  weight: FontWeight.w400,
                  color: const Color.fromARGB(255, 24, 59, 109),
                ),
              ));
            }

            Map<String, dynamic> getItemByID(int id) {
              for (var item in statusList) {
                if (item["id"] == id) return item;
              }

              return statusList[0];
            }

            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded,
                      color: Color.fromARGB(255, 24, 59, 109)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: CustomText(
                  text: appBarTitle,
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
                                String? error =
                                    snapshot.hasData ? snapshot.data : null;

                                return ValidatedField(
                                  ln: 1,
                                  ctrl: titleCtrl,
                                  onValueChange: (val) =>
                                      titleValidate(val, titleErrorStream),
                                  error: error,
                                );
                              }),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Status",
                            size: 20,
                            weight: FontWeight.w600,
                            color: const Color.fromARGB(255, 24, 59, 109),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blueGrey,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(8)),
                            child: StreamBuilder<int?>(
                                stream: statusStream.stream,
                                builder: (context, snapshot) {
                                  return DropdownButton<int>(
                                    onChanged: (_) {
                                      statusVal = _ as int;
                                      statusStream.add(statusVal);
                                    },
                                    isExpanded: true,
                                    borderRadius: BorderRadius.circular(5.0),
                                    items: dropDownItems,
                                    value: getItemByID(
                                        snapshot.data ?? statusVal)["id"],
                                  );
                                }),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),

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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
                              child: ListTile(
                                hoverColor: Colors.white,
                                focusColor: Colors.white,
                                onTap: () => selectDate(),
                                title: StreamBuilder<DateTime>(
                                    stream: dateValueStream.stream,
                                    initialData: selectedDate,
                                    builder: (context, snapshot) {
                                      return CustomText(
                                        text: dateTimeToString(snapshot.data!),
                                        size: 16,
                                        weight: FontWeight.w500,
                                        color: const Color.fromARGB(
                                            255, 24, 59, 109),
                                      );
                                    }),
                                trailing:
                                    const Icon(Icons.calendar_month_rounded),
                              ),
                            ),
                          ),
                          StreamBuilder<String?>(
                              stream: timeErrorStream.stream,
                              builder: (context, snapshot) {
                                bool timeError = snapshot.data != null;

                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TimeSelect(
                                          title: "Start Time",
                                          timeError: timeError,
                                          selectTime: () => selectTime(true),
                                          time: startTimeValueStream),
                                      TimeSelect(
                                          title: "End Time",
                                          timeError: timeError,
                                          selectTime: () => selectTime(false),
                                          time: endTimeValueStream),
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
                            String? data = snapshot.data;

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
                          onPressed: handleUpdateOrCreate,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                50.0, 10.0, 50.0, 10.0),
                            child: CustomText(
                              text: actionTitle,
                              size: 15,
                              weight: FontWeight.w400,
                              color: const Color.fromARGB(255, 238, 245, 255),
                            ),
                          ),
                        ),
                      ),

                      // DELETE
                      actionTitle == "Update"
                          ? Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: () {
                                  databaseHelper.deleteTask(task);
                                  widget.updateTaskList.add(true);
                                  Navigator.of(context).pop();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      55.0, 10.0, 55.0, 10.0),
                                  child: CustomText(
                                    text: "Delete",
                                    size: 15,
                                    weight: FontWeight.w400,
                                    color: const Color.fromARGB(
                                        255, 238, 245, 255),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(
                              height: 20,
                            ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: const CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

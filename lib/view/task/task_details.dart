import "dart:async";
import "package:flutter/material.dart";
import "package:todo_app/model/task_status.dart";
import "package:todo_app/services/remote_service.dart";
import "package:todo_app/theme.dart";
import "package:todo_app/view/home/home.dart";
import "package:todo_app/view/task/date_and_time.dart";
import "package:todo_app/view/task/dropdown.dart";
import "package:todo_app/view/task/error_validation.dart";
import "package:todo_app/view/task/input.dart";
import "../../model/task.dart";
import "../../shared/text.dart";
import "../../utils/type_conv_helper.dart";
import "appbar.dart";

// ignore: must_be_immutable
class TaskDetails extends StatefulWidget {
  TaskDetails({super.key, required this.task});
  Task? task;

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  DateTime date = DateTime.now();
  int statusVal = 1;

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  // TITLE
  TextEditingController titleCtrl = TextEditingController();
  StreamController<String?> titleErrStream = StreamController<String?>();

  // DESCRIPTION
  TextEditingController descCtrl = TextEditingController();
  StreamController<String?> descErrStream = StreamController<String?>();

  // DATE TIME
  StreamController<String?> timeErrStream = StreamController<String?>();

  StreamController<DateTime> dateValueStream = StreamController();
  StreamController<TimeOfDay> startTimeValueStream = StreamController();
  StreamController<TimeOfDay> endTimeValueStream = StreamController();

  String actionTitle = '';
  String appBarTitle = '';

  void handleDelete() {
    RemoteService.deleteTask(widget.task!.id!);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePage(),
        ))
        .then((value) => setState(() {}));
  }

  void handleUpdateOrCreate() {
    bool titleErr = titleValidate(titleCtrl.text, titleErrStream);
    bool descErr = descValidate(descCtrl.text, descErrStream);
    bool timeErr =
        timeValidate(timeErrStream, widget.startTime, widget.endTime);

    if (!(titleErr || descErr || timeErr)) {
      widget.task = Task(
        widget.task != null
            ? widget.task!.id
            : 0, // ID 0 TRIGGERS AUTOINCREMENT ON SERVER
        titleCtrl.text,
        descCtrl.text,
        dateTimeToString(widget.date),
        timeOfDayToString(widget.startTime, context),
        timeOfDayToString(widget.endTime, context),
        widget.statusVal,
      );

      if (actionTitle == "Update") {
        RemoteService.putTask(widget.task!.toMap());
      } else {
        RemoteService.postTask(widget.task!.toMap());
      }
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(
            builder: (context) => const HomePage(),
          ))
          .then((value) => setState(() {}));
    }
  }

  @override
  Widget build(BuildContext context) {
    actionTitle = widget.task != null ? "Update" : "Create";
    appBarTitle = widget.task != null ? "Update Task" : "Add Task";

    if (widget.task != null) {
      titleCtrl.text = widget.task!.title!;
      descCtrl.text = widget.task!.description!;

      dateValueStream.add(stringToDateTime(widget.task!.date!));
      startTimeValueStream.add(stringToTimeOfDay(widget.task!.startTime!));
      endTimeValueStream.add(stringToTimeOfDay(widget.task!.endTime!));

      widget.date = stringToDateTime(widget.task!.date!);
      widget.startTime = stringToTimeOfDay(widget.task!.startTime!);
      widget.endTime = stringToTimeOfDay(widget.task!.endTime!);

      widget.statusVal = widget.task!.statusId;
    }

    return Scaffold(
      appBar: TaskAppBar(
        title: appBarTitle,
      ).build(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              InputField(
                lable: "Title",
                ctrl: titleCtrl,
                errorStream: titleErrStream.stream,
                ln: 1,
                onValueChange: (val) => titleValidate(val, titleErrStream),
              ),
              AppTheme.verticalSpacer,
              FutureBuilder(
                future: RemoteService.getStatus(),
                initialData: const <TaskStatus>[],
                builder: (context, snapshot) {
                  return Dropdown(
                    statusList: snapshot.data as List<TaskStatus>,
                    statusVal: widget.task?.statusId ?? 1,
                    setStatus: (int val) => widget.statusVal = val,
                  );
                },
              ),
              AppTheme.verticalSpacer,
              DateAndTime(
                dateValueStream: dateValueStream,
                startTimeValueStream: startTimeValueStream,
                endTimeValueStream: endTimeValueStream,
                timeErrorStream: timeErrStream,
                setStartTime: (TimeOfDay time) => widget.startTime = time,
                setEndTime: (TimeOfDay time) => widget.endTime = time,
                setDate: (DateTime date) => widget.date = date,
              ),
              AppTheme.verticalSpacer,
              InputField(
                lable: "Description",
                ctrl: descCtrl,
                errorStream: descErrStream.stream,
                ln: 3,
                onValueChange: (val) => descValidate(val, descErrStream),
              ),
              AppTheme.verticalSpacer,
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: handleUpdateOrCreate,
                      child: Padding(
                        padding: AppTheme.buttonPadding,
                        child: CustomText(
                          text: actionTitle,
                          size: AppTheme.sizeSmall,
                          weight: AppTheme.medium,
                          color: AppTheme.colorWhite,
                        ),
                      ),
                    ),
                    if (actionTitle == "Update")
                      Row(
                        children: [
                          AppTheme.horizontalSpacer,
                          ElevatedButton(
                            onPressed: handleDelete,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.colorDanger),
                            child: Padding(
                              padding: AppTheme.buttonPadding,
                              child: CustomText(
                                text: "Delete",
                                size: AppTheme.sizeSmall,
                                weight: AppTheme.medium,
                                color: AppTheme.colorWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import "dart:async";

import "package:flutter/material.dart";
import "package:todo_app/theme.dart";

import "../../shared/text.dart";
import "../../shared/time_select.dart";
import "../../utils/type_conv_helper.dart";

// ignore: must_be_immutable
class DateAndTime extends StatefulWidget {
  DateAndTime(
      {super.key,
      required this.dateValueStream,
      required this.startTimeValueStream,
      required this.endTimeValueStream,
      required this.timeErrorStream,
      required this.setStartTime,
      required this.setEndTime,
      required this.setDate});

  StreamController<DateTime>? dateValueStream;
  StreamController<TimeOfDay>? startTimeValueStream;
  StreamController<TimeOfDay>? endTimeValueStream;
  StreamController<String?> timeErrorStream;

  Function(TimeOfDay time) setStartTime;
  Function(TimeOfDay time) setEndTime;
  Function(DateTime date) setDate;

  @override
  State<DateAndTime> createState() => _DateAndTimeState();
}

class _DateAndTimeState extends State<DateAndTime> {

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();

  void selectDate(DateTime date) {
    showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    ).then((value) {
      if (value == null) return;

      widget.setDate(value);
      widget.dateValueStream!.add(selectedDate);
    });
  }

  void selectTime(bool isStart, TimeOfDay time) {
    showTimePicker(
      context: context,
      initialTime: time,
    ).then((value) {
      if (value == null) return;

      if (isStart) {
        widget.setStartTime(value);
        startTime = value;
        widget.startTimeValueStream!.add(startTime);
      } else {
        widget.setEndTime(value);
        endTime = value;
        widget.endTimeValueStream!.add(endTime);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            child: StreamBuilder<DateTime>(
                stream: widget.dateValueStream!.stream,
                initialData: DateTime.now(),
                builder: (context, snapshot) {
                  return ListTile(
                    hoverColor: AppTheme.colorWhite,
                    focusColor: AppTheme.colorWhite,
                    onTap: () => selectDate(snapshot.data!),
                    title: CustomText(
                      text: dateTimeToString(snapshot.data!),
                      size: 16,
                      weight: FontWeight.w500,
                      color: const Color.fromARGB(255, 24, 59, 109),
                    ),
                    trailing: const Icon(Icons.calendar_month_rounded),
                  );
                }),
          ),
        ),
        StreamBuilder<String?>(
            stream: widget.timeErrorStream.stream,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TimeSelect(
                      title: "Start Time",
                      timeError: snapshot.data != null,
                      selectTime: (val) => selectTime(true, val),
                      time: widget.startTimeValueStream!,
                    ),
                    TimeSelect(
                      title: "End Time",
                      timeError: snapshot.data != null,
                      selectTime: (val) => selectTime(false, val),
                      time: widget.endTimeValueStream!,
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/type_conv_helper.dart';
import 'text.dart';

class TimeSelect extends StatefulWidget {
  const TimeSelect({
    super.key,
    required this.timeError,
    required this.selectTime,
    required this.time,
    required this.title,
  });

  final bool timeError;
  final Function selectTime;
  final StreamController<TimeOfDay> time;
  final String title;

  @override
  State<TimeSelect> createState() => _TimeSelectState();
}

class _TimeSelectState extends State<TimeSelect> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: widget.title,
          size: 20,
          weight: FontWeight.w600,
          color: const Color.fromARGB(255, 24, 59, 109),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 - 50,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: !widget.timeError
                    ? const Color.fromARGB(255, 164, 164, 164)
                    : Colors.red,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
              child: StreamBuilder<TimeOfDay>(
                  stream: widget.time.stream,
                  initialData: TimeOfDay.now(),
                  builder: (context, snapshot) {
                    return ListTile(
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      onTap: () => widget.selectTime(snapshot.data),
                      title: CustomText(
                        text: timeOfDayToString(snapshot.data!, context),
                        size: 15,
                        weight: FontWeight.w500,
                        color: const Color.fromARGB(255, 24, 59, 109),
                      ),
                      trailing: const Icon(Icons.calendar_month_rounded),
                    );
                  }),
            ),
          ),
        ),
        CustomText(
          text: widget.timeError ? "Invalid time" : "",
          size: 12,
          weight: FontWeight.w500,
          color: Colors.redAccent,
        ),
      ],
    );
  }
}

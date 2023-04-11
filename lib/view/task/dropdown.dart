import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/model/task_status.dart';
import 'package:todo_app/theme.dart';

import '../../shared/text.dart';

// ignore: must_be_immutable
class Dropdown extends StatefulWidget {
  Dropdown({
    super.key,
    required this.statusList,
    required this.statusVal,
    required this.setStatus,
  });

  final List<TaskStatus> statusList;
  int statusVal;

  final Function(int val) setStatus;

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  StreamController<int?> statusStream = StreamController();

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<int>> dropDownItems = [];

    for (var item in widget.statusList) {
      dropDownItems.add(DropdownMenuItem<int>(
        value: item.id,
        child: CustomText(
          text: item.title,
          size: 15,
          weight: FontWeight.w400,
          color: const Color.fromARGB(255, 24, 59, 109),
        ),
      ));
    }

    TaskStatus? getItemByID(int id) {
      for (var item in widget.statusList) {
        if (item.id == id) return item;
      }

      return widget.statusList.isNotEmpty ? widget.statusList[0] : null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Status",
          size: 20,
          weight: FontWeight.w600,
          color: const Color.fromARGB(255, 24, 59, 109),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: AppTheme.colorWhite,
            border: Border.all(
              color: Colors.blueGrey,
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: StreamBuilder<int?>(
            stream: statusStream.stream,
            builder: (context, snapshot) {
              return DropdownButton<int>(
                onChanged: (_) {
                  widget.statusVal = _ as int;
                  widget.setStatus(_);
                  statusStream.add(widget.statusVal);
                },
                isExpanded: true,
                borderRadius: BorderRadius.circular(5.0),
                items: dropDownItems,
                value: getItemByID(snapshot.data ?? widget.statusVal)?.id,
              );
            },
          ),
        )
      ],
    );
  }
}

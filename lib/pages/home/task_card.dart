import 'dart:async';

import 'package:flutter/material.dart';
import '../../shared/custom_text.dart';
import '../../utils/navigation_helper.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(
      {super.key,
      required this.taskId,
      required this.taskTitle,
      required this.taskTime,
      required this.updateTaskList});

  final int taskId;
  final String taskTitle;
  final String taskTime;
  final StreamController updateTaskList;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
              color: Color.fromARGB(19, 166, 167, 177),
              blurRadius: 5.0,
              offset: Offset(0.0, 5.0))
        ]),
        child: Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Color.fromARGB(255, 223, 226, 243),
            ),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            splashColor: const Color.fromARGB(255, 30, 94, 146).withAlpha(30),
            onTap: () => navigateToTaskPage(taskId, context, updateTaskList),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                    leading: const Icon(
                      Icons.local_activity,
                      color: Color.fromARGB(255, 130, 197, 236),
                    ),
                    title: CustomText(
                      text: taskTitle,
                      size: 16,
                      weight: FontWeight.w500,
                      color: const Color.fromARGB(255, 24, 59, 109),
                    ),
                    subtitle: CustomText(
                      text: taskTime,
                      size: 12,
                      weight: FontWeight.w400,
                      color: const Color.fromARGB(255, 118, 148, 190),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded,
                        color: Color.fromARGB(255, 130, 197, 236)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

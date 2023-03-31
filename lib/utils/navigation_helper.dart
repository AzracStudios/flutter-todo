import 'dart:async';

import 'package:flutter/material.dart';
import '../pages/task/task_details.dart';

void navigateToTaskPage(
    int? id, BuildContext context, StreamController updateTaskList) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => TaskDetails(
        id: id,
        updateTaskList: updateTaskList,
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:todo_app/utils/database_helper.dart';

import '../models/task.dart';
import '../pages/task/task_details.dart';

void navigateToTaskPage(Task task, BuildContext context, DatabaseHelper databaseHelper) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => TaskDetails(
        task: task,
        appBarTitle: task.title.isEmpty ? "Add Task" : "Update Task",
        actionTitle: task.title.isEmpty ? "Create" : "Update",
        databaseHelper: databaseHelper
      ),
    ),
  );
}

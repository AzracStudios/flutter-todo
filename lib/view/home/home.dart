import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/task_status.dart';
import 'package:todo_app/services/remote_service.dart';
import 'package:todo_app/shared/text.dart';
import 'package:todo_app/theme.dart';
import 'package:todo_app/view/home/appbar.dart';
import 'package:todo_app/view/home/progress.dart';
import 'package:todo_app/view/home/task_card.dart';
import 'package:todo_app/view/task/task_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task>? tasks;
  List<TaskStatus>? status;
  var isLoaded = false;
  List<TaskCard> taskList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    tasks = await RemoteService.getTasks();
    status = await RemoteService.getStatus();

    if (tasks != null && status != null) {
      for (var task in tasks!) {
        taskList.add(
          TaskCard(
              task: task,
              status: TaskStatus.findStatus(status!, task.statusId).title),
        );
      }

      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar().build(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TaskDetails(task: null),
        )),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: [
            const Progress(),
            // ignore: prefer_is_empty
            if (((tasks ?? []).length) <= 0)
              Center(
                heightFactor: 2,
                child: CustomText(
                    text: "No Tasks!",
                    size: AppTheme.sizeXLarge,
                    weight: AppTheme.bold,
                    color: AppTheme.colorPrimary),
              ),
            AppTheme.verticalSpacer,
            ...taskList,
          ],
        ),
      ),
    );
  }
}

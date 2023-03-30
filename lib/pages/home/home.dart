import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/pages/home/task_card.dart';
import 'package:todo_app/shared/progress.dart';
import 'package:todo_app/utils/database_helper.dart';

import '../../shared/custom_text.dart';
import '../../utils/navigation_helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamController<List<Task>?> taskStream = StreamController();

  DatabaseHelper databaseHelper = DatabaseHelper();

  List<Task> tasks = [];

  void updateTasks() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((db) {
      Future<List<Task>> taskListFuture = databaseHelper.getTaskList();
      taskListFuture.then((taskList) {
        taskStream.add(taskList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.dashboard_outlined,
            color: Color.fromARGB(255, 48, 55, 133),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              color: Color.fromARGB(255, 48, 55, 133),
            ),
          ),
        ],
        title: CustomText(
          text: "Home page",
          size: 20,
          weight: FontWeight.w600,
          color: const Color.fromARGB(255, 24, 59, 109),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                color: Colors.black38,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month_rounded,
                color: Colors.black38,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_bubble_rounded,
                color: Colors.black38,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.black38,
              ),
              label: "")
        ],
      ),
      body: StreamBuilder<List<Task>?>(
          stream: taskStream.stream,
          builder: (context, snapshot) {
            List<TaskCard> taskCards = [];

            if (snapshot.hasData) {
              for (var i = 0; i < snapshot.data!.length; i++) {
                Task task = snapshot.data![i];

                taskCards.add(TaskCard(
                    index: i,
                    title: task.title,
                    time: '${task.startTime} - ${task.endTime}'));
              }
            }

            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const Progress(),
                  const SizedBox(height: 20),
                  taskCards.isEmpty
                      ? CustomText(
                          text: "No Tasks!",
                          size: 25,
                          weight: FontWeight.bold,
                          color: const Color.fromARGB(255, 24, 59, 109),
                          center: true,
                        )
                      : const SizedBox(height: 1),
                  ...taskCards
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToTaskPage(
            Task('', '', '', '', ''), context, databaseHelper),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

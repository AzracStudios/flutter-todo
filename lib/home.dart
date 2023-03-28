import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/progress.dart';

import 'add_task.dart';
import 'custom_text.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
          color: Color.fromARGB(255, 24, 59, 109),
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
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: const [
            Progress(),
            SizedBox(height: 20),
            TaskCard(title: "UI Design", time: "9:00 AM - 12:50 PM"),
            TaskCard(title: "UI Design", time: "9:00 AM - 12:50 PM")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddTask()))
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.title, required this.time});
  final String title;
  final String time;

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
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                    leading: const Icon(
                      Icons.local_activity,
                      color: Color.fromARGB(255, 130, 197, 236),
                    ),
                    title: CustomText(
                      text: title,
                      size: 16,
                      weight: FontWeight.w500,
                      color: Color.fromARGB(255, 24, 59, 109),
                    ),
                    subtitle: CustomText(
                      text: time,
                      size: 12,
                      weight: FontWeight.w400,
                      color: Color.fromARGB(255, 118, 148, 190),
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

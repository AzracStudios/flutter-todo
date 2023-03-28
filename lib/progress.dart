import 'package:flutter/material.dart';
import 'package:todo_app/progress_slider.dart';
import 'package:todo_app/task_details.dart';
import 'custom_text.dart';
import 'landing.dart';

class Progress extends StatelessWidget {
  const Progress({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const TaskDetails()));
        },
        child: Container(
          height: 150,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Colors.blue[200]!, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CustomText(
                text: "Today's Progress Summary",
                size: 15,
                weight: FontWeight.w400,
                color: Colors.white,
              ),
              CustomText(
                text: "15 Tasks",
                size: 14,
                weight: FontWeight.w300,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              ProgressSlider(percentage: 20.0, dark: false),
            ],
          ),
        ),
      ),
    );
  }
}

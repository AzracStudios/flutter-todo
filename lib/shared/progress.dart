import 'package:flutter/material.dart';
import 'package:todo_app/shared/progress_slider.dart';
import 'package:todo_app/pages/task/task_summary.dart';
import 'custom_text.dart';

class Progress extends StatelessWidget {
  const Progress({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const TaskSummary()));
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
            children: [
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
              const SizedBox(height: 10),
              const ProgressSlider(percentage: 20.0, dark: false),
            ],
          ),
        ),
      ),
    );
  }
}

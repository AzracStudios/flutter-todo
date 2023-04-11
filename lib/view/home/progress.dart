import 'package:flutter/material.dart';
import 'package:todo_app/theme.dart';
import 'package:todo_app/view/home/task_summary.dart';
import '../../shared/text.dart';
import './progress_slider.dart';

class Progress extends StatelessWidget {
  const Progress({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const TaskSummary())),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            gradient: AppTheme.progressGradient,
            borderRadius: AppTheme.borderRadius,
          ),
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Today's Progress Summary",
                size: AppTheme.sizeSmall,
                weight: AppTheme.medium,
                color: AppTheme.colorWhite,
              ),
              CustomText(
                text: "15 Tasks",
                size: AppTheme.sizeSmall,
                weight: AppTheme.regular,
                color: AppTheme.colorWhite,
              ),
              AppTheme.verticalSpacer,
              const ProgressSlider(
                percentage: 20.0,
                dark: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

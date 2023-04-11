import 'package:flutter/material.dart';
import 'package:todo_app/theme.dart';
import 'package:todo_app/view/home/progress_slider.dart';
import '../../shared/text.dart';

class TaskSummary extends StatelessWidget {
  const TaskSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: AppTheme.colorPrimary,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: CustomText(
              text: "Task Summary",
              size: AppTheme.sizeMedium,
              weight: AppTheme.bold,
              color: AppTheme.colorPrimary),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Web Development",
                size: AppTheme.sizeMedium,
                weight: AppTheme.bold,
                color: AppTheme.colorPrimary,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: AppTheme.colorPrimary,
                  ),
                  AppTheme.horizontalSpacer,
                  CustomText(
                    text: "04 April, at 11:30 AM",
                    size: AppTheme.sizeSmall,
                    weight: AppTheme.medium,
                    color: AppTheme.colorPrimary,
                  )
                ],
              ),
              AppTheme.verticalSpacer,
              const ProgressSlider(
                percentage: 80,
                dark: true,
              ),
              AppTheme.verticalSpacer,
              CustomText(
                text: "Overview",
                size: AppTheme.sizeMedium,
                weight: AppTheme.bold,
                color: AppTheme.colorPrimary,
              ),
              Flexible(
                child: CustomText(
                  text:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu dapibus turpis, eu tincidunt augue. Nunc vehicula dictum augue, quis ullamcorper purus eleifend at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse aliquam blandit tellus, ac porttitor nunc faucibus vitae. Etiam non aliquam magna, ac volutpat quam. Donec sed fringilla elit. Curabitur ac congue nisl. Mauris consectetur a turpis sit amet lobortis. Vestibulum finibus tincidunt ex, sit amet congue odio viverra vitae. Sed consequat et elit eu sodales. Nunc consectetur mi arcu, convallis accumsan metus luctus ut. Suspendisse vitae libero ac nisl porttitor interdum. Duis ut odio vel nisl cursus ultricies. Donec tempus aliquam cursus. Nullam vulputate nibh ac consectetur auctor. Sed quis volutpat mi, nec aliquet nunc. Etiam hendrerit varius ultrices. Donec non aliquam quam. Nunc a tempor libero. Nulla eleifend commodo rutrum. Vivamus consectetur nulla vel diam mollis dictum. Cras scelerisque auctor venenatis.",
                  size: AppTheme.sizeSmall,
                  weight: AppTheme.medium,
                  color: AppTheme.colorPrimary,
                ),
              )
            ],
          ),
        ));
  }
}

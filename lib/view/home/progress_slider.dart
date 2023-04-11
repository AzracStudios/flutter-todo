import 'package:flutter/material.dart';
import 'package:todo_app/theme.dart';
import '../../shared/text.dart';

// ignore: must_be_immutable
class ProgressSlider extends StatelessWidget {
  const ProgressSlider(
      {super.key, required this.percentage, required this.dark});

  final double percentage;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Progress 40%",
          size: AppTheme.sizeSmall,
          weight: FontWeight.w500,
          color: dark ? AppTheme.colorPrimary : AppTheme.colorWhite,
        ),
        ClipRRect(
          borderRadius: AppTheme.borderRadius,
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: dark
                ? AppTheme.colorPrimaryTransparent
                : AppTheme.colorWhiteTransparent,
            color: dark ? AppTheme.colorPrimary : AppTheme.colorWhite,
            minHeight: 10,
          ),
        ),
      ],
    );
  }
}

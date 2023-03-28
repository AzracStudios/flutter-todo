import 'package:flutter/material.dart';
import 'package:todo_app/shared/custom_text.dart';

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
          size: 14,
          weight: FontWeight.w500,
          color: !dark ? Colors.white : const Color.fromARGB(255, 24, 59, 109),
        ),
        const SizedBox(
          height: 5,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: !dark
                ? Color.fromARGB(122, 255, 255, 255)
                : Color.fromARGB(36, 24, 59, 109),
            color:
                !dark ? Colors.white : const Color.fromARGB(255, 24, 59, 109),
            minHeight: 10,
          ),
        ),
      ],
    );
  }
}

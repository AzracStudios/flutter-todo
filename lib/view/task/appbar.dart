import 'package:flutter/material.dart';

import '../../shared/text.dart';
import '../../theme.dart';

class TaskAppBar extends StatelessWidget {
  const TaskAppBar({super.key, required this.title});
  final String title;
  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: AppTheme.colorPrimary,
        ),
      ),
      title: CustomText(
        text: title,
        size: 20,
        weight: AppTheme.bold,
        color: AppTheme.colorPrimary,
      ),
      backgroundColor: AppTheme.colorWhite,
      elevation: 0.0,
    );
  }
}

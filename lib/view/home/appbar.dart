import 'package:flutter/material.dart';

import '../../shared/text.dart';
import '../../theme.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.dashboard_outlined,
          color: AppTheme.colorPrimary,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppTheme.colorPrimary,
          ),
        ),
      ],
      title: CustomText(
        text: "Home page",
        size: AppTheme.sizeMedium,
        weight: AppTheme.bold,
        color: AppTheme.colorPrimary,
      ),
      backgroundColor: AppTheme.colorWhite,
      elevation: 0.0,
    );
  }
}

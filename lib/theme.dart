import 'package:flutter/material.dart';

abstract class AppTheme {
  static const Color colorPrimary = Color.fromARGB(255, 48, 55, 133);
  static const Color colorPrimaryTransparent = Color.fromARGB(120, 48, 55, 133);
  static const Color colorDanger = Color.fromARGB(255, 206, 48, 48);
  static const Color colorWhite = Color.fromARGB(255, 255, 255, 255);
  static const Color colorWhiteTransparent = Color.fromARGB(120, 255, 255, 255);

  static BorderRadius borderRadius = BorderRadius.circular(8.0);
  static EdgeInsets buttonPadding =
      const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0);

  static List<Color> landingGradient = const <Color>[
    Color.fromARGB(255, 55, 135, 235),
    Color.fromARGB(255, 211, 229, 252),
    Color.fromARGB(255, 255, 255, 255)
  ];

  static FontWeight regular = FontWeight.normal;
  static FontWeight medium = FontWeight.w400;
  static FontWeight bold = FontWeight.w600;

  static double sizeSmall = 15.0;
  static double sizeMedium = 20.0;
  static double sizeLarge = 25.0;
  static double sizeXLarge = 30.0;

  static Widget verticalSpacer = const SizedBox(height: 20);
  static Widget horizontalSpacer = const SizedBox(width: 20);

  static LinearGradient progressGradient = LinearGradient(
    colors: <Color>[Colors.blue[200]!, Colors.blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

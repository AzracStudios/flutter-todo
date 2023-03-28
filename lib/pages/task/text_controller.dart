import 'package:flutter/material.dart';

class TextController {
  TextController();

  static String? validate(int min, int max, TextEditingController ctrl) {
    if (ctrl.text.length < min) {
      return 'Input needs atleast $min characters';
    } else if (ctrl.text.length > max) {
      return 'Input should be no longer than $max characters';
    }

    return null;
  }
}

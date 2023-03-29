import 'package:flutter/material.dart';

class TextController {
  TextController();

  static int validate(int min, int max, TextEditingController ctrl) {
    if (ctrl.text.length < min) {
      return 0;
    } else if (ctrl.text.length > max) {
      return 1;
    }

    return -1;
  }

  static String? validatedString(int min, int max, TextEditingController ctrl) {
    int status = validate(min, max, ctrl);

    if (status == 0) {
      return 'Input needs atleast $min characters';
    } else if (status == 1) {
      return 'Input should be no longer than $max characters';
    }

    return null;
  }
}

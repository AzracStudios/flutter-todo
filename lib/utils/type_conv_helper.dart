import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

TimeOfDay stringToTimeOfDay(String timeString) {
  final format = DateFormat.jm();
  return timeString.isNotEmpty
      ? TimeOfDay.fromDateTime(format.parse(timeString))
      : TimeOfDay.now();
}

DateTime stringToDateTime(String dateString) {
  return dateString.isNotEmpty ? DateTime.parse(dateString) : DateTime.now();
}

String timeOfDayToString(TimeOfDay timeOfDay, BuildContext context) {
  return timeOfDay.format(context).toString();
}

String dateTimeToString(DateTime dateTime) {
  return dateTime.toString().split(" ")[0];
}

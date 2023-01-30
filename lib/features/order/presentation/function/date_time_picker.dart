import 'package:flutter/material.dart';

Future<DateTime?> showDateAndTime(BuildContext context, bool isYearMode) {
  return showDatePicker(
    initialDatePickerMode:
        isYearMode ? DatePickerMode.year : DatePickerMode.day,
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2030),
  );
}

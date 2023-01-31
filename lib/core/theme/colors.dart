import 'dart:math';

import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static Color borderColor = const Color(0xFF707070);
  static Color bgColor = const Color(0xFFF7F7F7);
  static Color orange = const Color(0xFFFF9017);
  static Color green = Colors.green;
  static Color primaryColor = const Color(0xFF0919F7);
  static Color captionColor = const Color(0xFF676870);
  static Color labelColor = const Color(0xFF272833);
  static Color red = const Color.fromRGBO(229, 10, 25, 1);
  static const Color black = Colors.black;
  static const Color blue = Colors.blue;
  static Color white = Colors.white;
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.5),
    100: tintColor(color, 0.4),
    200: tintColor(color, 0.3),
    300: tintColor(color, 0.2),
    400: tintColor(color, 0.1),
    500: tintColor(color, 0),
    600: tintColor(color, -0.1),
    700: tintColor(color, -0.2),
    800: tintColor(color, -0.3),
    900: tintColor(color, -0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

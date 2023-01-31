import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData themeData = ThemeData(
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: AppColor.captionColor,
    ),
    actionsIconTheme: IconThemeData(
      color: AppColor.white,
    ),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontSize: 15,
      color: AppColor.captionColor,
      fontWeight: FontWeight.w500,
    ),
  ),
  primarySwatch: generateMaterialColor(AppColor.primaryColor),
  fontFamily: 'Avenir',
  textTheme: TextTheme(
    headline1: const TextStyle(
      fontSize: 40.0,
      color: AppColor.black,
      fontWeight: FontWeight.w800,
    ),
    headline2: const TextStyle(
      fontSize: 30.0,
      color: AppColor.black,
      fontWeight: FontWeight.w800,
    ),
    headline3: const TextStyle(
      fontSize: 24.0,
      color: AppColor.black,
      fontWeight: FontWeight.w800,
    ),
    headline4: const TextStyle(
      fontSize: 20.0,
      color: AppColor.black,
      fontWeight: FontWeight.w800,
    ),
    bodyText1: const TextStyle(
      fontSize: 15.0,
      color: AppColor.black,
    ),
    bodyText2: const TextStyle(
      fontSize: 13.0,
      color: AppColor.black,
      fontWeight: FontWeight.w300,
    ),
    caption: TextStyle(
      fontSize: 14.0,
      color: AppColor.captionColor,
    ),
    button: TextStyle(
      fontSize: 15.0,
      color: AppColor.white,
      fontWeight: FontWeight.w400,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      side: MaterialStateProperty.all(BorderSide(color: AppColor.borderColor)),
      elevation: MaterialStateProperty.all(0.0),
      shape: MaterialStateProperty.all(const StadiumBorder()),
      fixedSize: MaterialStateProperty.all(const Size(240, 44)),
      enableFeedback: true,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return AppColor.primaryColor.withOpacity(0.5);
          } else if (states.contains(MaterialState.disabled)) {
            return AppColor.primaryColor.withOpacity(0.5);
          }
          return AppColor.primaryColor;
        },
      ),
      elevation: MaterialStateProperty.all(0.0),
      shape: MaterialStateProperty.all(const StadiumBorder()),
      fixedSize: MaterialStateProperty.all(const Size(240, 44)),
      enableFeedback: true,
    ),
  ),
  iconTheme: IconThemeData(
    color: AppColor.primaryColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(fontSize: 15, color: AppColor.captionColor),
    errorStyle: TextStyle(fontSize: 13, color: AppColor.red),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColor.red),
    ),
    hintStyle: TextStyle(
      fontSize: 14,
      color: AppColor.borderColor.withOpacity(0.7),
    ),
    contentPadding: const EdgeInsets.all(10),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.5,
        color: AppColor.borderColor.withOpacity(0.5),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.5,
        color: AppColor.borderColor.withOpacity(0.5),
      ),
    ),
  ),
);

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'material_color.dart';

class AppTheme {
  AppTheme._();
  static Color borderColor = const Color(0xFF707070);
  static Color primaryColor = const Color(0xFF0919F7);
  static Color captionColor = const Color(0xFF676870);
  static Color labelColor = const Color(0xFF272833);
  static Color red = const Color.fromRGBO(229, 10, 25, 1);
  static const Color black = Colors.black;
  static const Color blue = Colors.blue;
  static Color white = Colors.white;

  static ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: black,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: white,
      ),
      actionsIconTheme: IconThemeData(
        color: white,
      ),
      backgroundColor: black,
      centerTitle: true,
      elevation: 0.0,
      titleTextStyle:
          TextStyle(fontSize: 15.sp, color: white, fontWeight: FontWeight.w500),
    ),
    primarySwatch: generateMaterialColor(primaryColor),
    fontFamily: 'Avenir',
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 40.0.sp,
        color: black,
        fontWeight: FontWeight.w400,
      ),
      headline2: TextStyle(
        fontSize: 30.0.sp,
        color: black,
        fontWeight: FontWeight.w400,
      ),
      headline3: TextStyle(
        fontSize: 24.0.sp,
        color: black,
        fontWeight: FontWeight.w400,
      ),
      headline4: TextStyle(
        fontSize: 20.0.sp,
        color: black,
        fontWeight: FontWeight.w400,
      ),
      bodyText1: TextStyle(
        fontSize: 15.0.sp,
        color: black,
      ),
      bodyText2: TextStyle(
        fontSize: 13.0.sp,
        color: black,
        fontWeight: FontWeight.w300,
      ),
      caption: TextStyle(
        fontSize: 14.0.sp,
        color: captionColor,
      ),
      button: TextStyle(
        fontSize: 15.0.sp,
        color: white,
        fontWeight: FontWeight.w400,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(color: borderColor)),
        elevation: MaterialStateProperty.all(0.0),
        shape: MaterialStateProperty.all(const StadiumBorder()),
        fixedSize: MaterialStateProperty.all(Size(240.w, 44.h)),
        enableFeedback: true,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return primaryColor.withOpacity(0.5);
            } else if (states.contains(MaterialState.disabled)) {
              return primaryColor.withOpacity(0.5);
            }
            return primaryColor;
          },
        ),
        elevation: MaterialStateProperty.all(0.0),
        shape: MaterialStateProperty.all(const StadiumBorder()),
        fixedSize: MaterialStateProperty.all(Size(240.w, 44.h)),
        enableFeedback: true,
      ),
    ),
    iconTheme: IconThemeData(
      color: primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(fontSize: 16.sp, color: black),
      floatingLabelStyle: TextStyle(fontSize: 12.sp, color: labelColor),
      errorStyle: TextStyle(fontSize: 13.sp, color: red),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: 1, color: red),
      ),
      hintStyle: TextStyle(fontSize: 14.sp, color: borderColor),
      contentPadding: const EdgeInsets.all(8),
      border: UnderlineInputBorder(
        borderSide: BorderSide(width: 0.5, color: borderColor),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: 0.5, color: borderColor),
      ),
    ),
  );
}

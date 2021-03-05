import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData buildTodoTheme() {
  final ThemeData tdLight = ThemeData.light();
  return tdLight.copyWith(
    accentColor: todoAmber,
    primaryColor: todoPurpleDark,
    highlightColor: todoAmberLight,
    scaffoldBackgroundColor: todoBackgroundWhite,
    cardColor: todoBackgroundWhite,
    errorColor: errorRed,
    primaryTextTheme: TextTheme(
      subtitle1: TextStyle(
          color: todoBlack, fontFamily: 'Rubik', fontWeight: FontWeight.w300, fontSize: 25),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
          color: todoBlack, fontFamily: 'Rubik', fontWeight: FontWeight.w300, fontSize: 25),
      headline2: TextStyle(
          color: todoWhite, fontFamily: 'Rubik', fontWeight: FontWeight.w300, fontSize: 25),
      headline6: TextStyle(
          color: Colors.white, fontFamily: 'Rubik', fontWeight: FontWeight.w600, fontSize: 25),
      subtitle1: TextStyle(
          color: todoBlack, fontFamily: 'Rubik', fontWeight: FontWeight.w200, fontSize: 20),
      subtitle2: TextStyle(
          color: todoWhite, fontFamily: 'Rubik', fontWeight: FontWeight.w200, fontSize: 20),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(color: todoWhite),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

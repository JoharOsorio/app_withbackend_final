import 'package:flutter/material.dart';

class MyTheme {
  static const Color primaryLight = Color.fromRGBO(0, 102, 255, 0.8);
  static const Color primary = Color.fromRGBO(0, 102, 255, 1);

  static final ThemeData myTheme = ThemeData(
      primaryColor: primary,
      brightness: Brightness.light,
      fontFamily: 'Releway',
      appBarTheme: const AppBarTheme(
        color: primary,
        elevation: 10,
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: primary)),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: primary));
}

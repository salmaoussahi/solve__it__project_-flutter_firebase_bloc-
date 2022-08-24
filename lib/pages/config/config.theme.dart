import 'package:flutter/material.dart';
import 'package:flutterfirebase/pages/config/config.palette.dart';

class MyTheme {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey[900],
      colorScheme: ColorScheme.dark(),
      brightness: Brightness.dark,
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2.0),
        ),
      ),
      appBarTheme: AppBarTheme(
        color: const Color(0xFF151026),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: Palette.yellow)));
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(),
      brightness: Brightness.light,
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2.0),
        ),
      ),
      appBarTheme: AppBarTheme(
        color: const Color(0xFF151026),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: Palette.blue)));
}

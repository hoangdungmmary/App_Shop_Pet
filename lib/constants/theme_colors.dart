import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Color(0xFF1E88E5),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style:OutlinedButton.styleFrom(
      shadowColor: Colors.white,
      foregroundColor: Colors.red,
      side: const BorderSide(
          color: Colors.red,
          width: 1.3),
      disabledForegroundColor:
      Colors.white,
    ),
  ),
  inputDecorationTheme:  InputDecorationTheme(
    border: outlineInputBorder,
    errorBorder: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    prefixIconColor:  Color(0xFF64B5F6),
    suffixIconColor: Color(0xFF64B5F6),
    focusedErrorBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Color(0xFF64B5F6),
      textStyle: const TextStyle(
        fontSize: 20,
      ),
      disabledBackgroundColor: Colors.grey,
    )
  ),
  primarySwatch: Colors.red,
  canvasColor: Colors.red,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    toolbarTextStyle: TextStyle(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  )
);

OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
      borderSide: BorderSide(
      color: Color(0xFF64B5F6),
      ),

);
ThemeData lightMode  = ThemeData(
    brightness:  Brightness.light,
    colorScheme: ColorScheme.light(
      background: Colors.grey.shade400,
      primary: Colors.grey.shade300,
      secondary: Colors.grey.shade200,
    )
);
ThemeData darkMode  = ThemeData(
    brightness:  Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      primary: Colors.grey.shade800,
      secondary: Colors.grey.shade700,
    )
);
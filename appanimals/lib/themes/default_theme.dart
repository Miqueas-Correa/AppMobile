import 'package:flutter/material.dart';

class DefaultTheme {
  static const Color primary = Color(0x00008A23);
  static const Color secondary = Color(0x0052C458);
  static const primaryHolder = Color(0x0098FF96);

  static final ThemeData lightTheme =ThemeData.light().copyWith(
    primaryColor: const Color(0x0098FF96),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0x00A2E67C),
      foregroundColor: Colors.white
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: primary, foregroundColor: Colors.white)
      ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: secondary, foregroundColor: Colors.white)
      ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.white,
    ),
    listTileTheme: const ListTileThemeData(iconColor: primary),

    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: const TextStyle(color: primary),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primary),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      )
    ), 
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor:const Color(0x00003400),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0x00009929),
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.white,
    ),
    
  );
}

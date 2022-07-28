import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      tabBarTheme: const TabBarTheme(
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey),
      appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.black),
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.white)),
      primarySwatch: Colors.teal,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(
          left: 20,
          right: 8,
        ),
        fillColor: Colors.grey.shade50,
        filled: true,
        hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.2),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.2),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.2),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(10)),
      ),
      checkboxTheme: const CheckboxThemeData(
          side: BorderSide(color: Colors.deepOrange, width: 2)));
  static ThemeData darkTheme = ThemeData();
  static List<Color> colors = [
    Colors.green.shade700,
    Colors.red.shade500,
    Colors.orange,
    Colors.blue.shade600,
    Colors.deepPurple
  ];
}

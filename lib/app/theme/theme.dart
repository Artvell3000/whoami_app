import 'package:flutter/material.dart';
import 'package:whoami_app/app/theme/colors.dart';

final whoAmIAppTheme = ThemeData(
  colorScheme: whoAmIAppLightColorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all<double>(0),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFFF2796B)),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      alignment: Alignment.center,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: InputBorder.none,
    contentPadding: const EdgeInsets.symmetric(horizontal: 11),
    hintStyle: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.normal,
      color: Color(0xFF545151),
    ),
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.normal,
      color: Color(0xFF545151),
    ),
  ),
);

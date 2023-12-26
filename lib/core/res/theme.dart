import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/core/res/fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static final currentTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: Colours.backgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: AppFonts.textTheme,
    colorScheme: ColorScheme.fromSeed(seedColor: Colours.primaryColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colours.primaryColor,
      ),
    ),
  );
}

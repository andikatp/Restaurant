import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/core/res/fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static final currentTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: Colours.backgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: AppFonts.textTheme,
    primaryColor: Colours.primaryColor,
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: Colours.primaryColor,
          secondary: Colours.secondaryColor,
        ),
  );
}

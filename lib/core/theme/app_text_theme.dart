import 'package:flutter/material.dart';

const TextTheme textTheme = TextTheme(
  displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, height: 1.05),
  displayMedium: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, height: 1.1),
  displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, height: 1.15),
  headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, height: 1.3),
  headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, height: 1.3),
  headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, height: 1.3),
  titleLarge: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, height: 1.4),
  titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, height: 1.4),
  titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.4),
  bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5),
  bodyMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, height: 1.5),
  bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, height: 1.5),
  labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 1.5),
  labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 1.5),
  labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, height: 1.5),
);

class AppTextTheme {
  static TextTheme englishTextTheme = textTheme.apply(
    fontFamily: 'Intro',
  );
  static TextTheme arabicTextTheme = textTheme.apply(
    fontFamily: 'Cairo',
  );
}

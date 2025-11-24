import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppText {
  static TextStyle displayLarge(BuildContext context) => Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 57.sp);

  static TextStyle displayMedium(BuildContext context) => Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 42.sp);

  static TextStyle displaySmall(BuildContext context) => Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 36.sp);

  static TextStyle headlineLarge(BuildContext context) => Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 32.sp);

  static TextStyle headlineMedium(BuildContext context) => Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 28.sp);

  static TextStyle headlineSmall(BuildContext context) => Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 24.sp);

  static TextStyle titleLarge(BuildContext context) => Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 21.sp);

  static TextStyle titleMedium(BuildContext context) => Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 18.sp);

  static TextStyle titleSmall(BuildContext context) => Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 16.sp);

  static TextStyle bodyLarge(BuildContext context) => Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16.sp);

  static TextStyle bodyMedium(BuildContext context) => Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15.sp);

  static TextStyle bodySmall(BuildContext context) => Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13.sp);

  static TextStyle labelLarge(BuildContext context) => Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 14.sp);

  static TextStyle labelMedium(BuildContext context) => Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 12.sp);

  static TextStyle labelSmall(BuildContext context) => Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 11.sp);
}

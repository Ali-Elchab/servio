import 'package:flutter/material.dart';
import 'package:invygo/core/theme/app_colors.dart';
import '/core/localization/app_localizations.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  TextDirection get textDirection => Directionality.of(this);
  AppThemeColors get colors => AppColors.of(this);
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  String tr(String key) {
    return AppLocalizations.of(this).translate(key);
  }
}

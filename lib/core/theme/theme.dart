import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';
import 'app_text_theme.dart';

ThemeData buildAppTheme({required bool isDark}) {
  final b = isDark ? Brightness.dark : Brightness.light;
  final t = AppColors.colorsFor(isDark);

  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: b,
    primary: AppColors.primary,
    onSurface: t.text,
    error: AppColors.error,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: b,
    colorScheme: scheme,

    // Surfaces
    scaffoldBackgroundColor: t.scaffold,
    canvasColor: t.surface,
    cardColor: t.surface,

    // Typography
    textTheme: textTheme.apply(bodyColor: t.text, displayColor: t.text),

    // AppBar
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(t.buttonBg),
        foregroundColor: WidgetStatePropertyAll(t.buttonFg),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: t.buttonBg,
      foregroundColor: t.buttonFg,
      elevation: 4,
    ),

    // Cards
    cardTheme: CardThemeData(
      color: t.surface,
      elevation: 2,
      shadowColor: isDark ? Colors.white24 : Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? Colors.white12 : Colors.black12,
          width: 1,
        ),
      ),
    ),

    // Tabs
    tabBarTheme: TabBarThemeData(
      dividerColor: Colors.transparent,
      labelColor: scheme.primary,
      unselectedLabelColor: t.tabUnselected,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 3, color: scheme.primary),
      ),
    ),

    // Bottom sheet / nav
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: t.surface,
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: t.surface,
      selectedItemColor: scheme.primary,
      unselectedItemColor: t.tabUnselected,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    // Checkbox / Icons
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: const BorderSide(color: Colors.grey, width: 1.5),
      visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
      checkColor: const WidgetStatePropertyAll(Colors.white),
    ),
    iconTheme: IconThemeData(color: t.text),

    // Inputs
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: t.surface2,
      prefixIconColor: isDark ? Colors.white54 : const Color(0xFF595959),
      hintStyle: textTheme.bodySmall!.copyWith(color: scheme.primary.withAlpha(130)),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: t.borderIdle, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: t.borderFocused, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: t.borderError, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: t.borderFocused, width: 1),
      ),
      errorStyle: const TextStyle(height: 0, fontSize: 0),
    ),
  );
}

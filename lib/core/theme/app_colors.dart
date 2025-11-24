import 'package:flutter/material.dart';

class AppColors {
  // ===== Base Palette (unchanged) =====
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF5F5F5);
  static const Color offOffWhite = Color(0xFFEEEEEE);
  static const Color black = Color(0xFF000000);
  static const Color gray300 = Color(0xFFE6E6E6);
  static const Color bgDark = Color(0xFF121212);
  static const Color bg2Dark = Color(0xFF1A1A1A);
  static const Color bg2Light = Color(0xFFF9F9F9);
  static const Color error = Color(0xFFFF6961);

  static const Color primary = Color(0xFF1976D2);
  static const Color ultraLightBlue = Color(0xFFE3F2FD);
  static const Color softSkyBlue = Color(0xFFBBDEFB);
  static const Color lightestBlue = Color(0xFF90CAF9);
  static const Color lighterBlue = Color(0xFF64B5F6);
  static const Color lightBlue = Color(0xFF42A5F5);
  static const Color darkBlue = Color(0xFF0D47A1);
  static const Color darkestBlue = Color(0xFF082567);

  // ===== Added Semantic Colors (top-level constants only; no changes to above) =====
  static const Color success = Color(0xFF2E7D32); // green 800
  static const Color warning = Color(0xFFF57C00); // orange 800
  static const Color info = Color(0xFF0288D1); // light blue 700

  // ===== State/Utility Tokens (const ARGB for stable opacity) =====
  static const Color overlayDark = Color(0x99000000); // 60% black
  static const Color overlayLight = Color(0x66FFFFFF); // 40% white
  static const Color focusPrimary = Color(0x661976D2); // 40% primary
  static const Color shadowColor = Color(0x33000000); // 20% black

  static const Color dividerLight = Color(0x1F000000); // 12% black
  static const Color dividerDark = Color(0x1FFFFFFF); // 12% white

  // ===== Feature Palettes =====
  static const FeaturePalette brandPalette = FeaturePalette(
    primary: primary,
    primaryAccent: lightBlue,
    light: softSkyBlue,
    chipBackground: ultraLightBlue,
    dark: darkBlue,
    sidebar: darkBlue,
    primaryForeground: white,
  );

  static const FeaturePalette purchasePalette = FeaturePalette(
    primary: Color(0xFF2E7D32),
    primaryAccent: Color(0xFF66BB6A),
    light: Color(0xFFA5D6A7),
    chipBackground: Color(0xFFE8F5E9),
    dark: Color(0xFF1B5E20),
    sidebar: Color(0xFF0F3A1D),
    primaryForeground: white,
  );

  static const FeaturePalette salesPalette = FeaturePalette(
    primary: Color(0xFF8E24AA),
    primaryAccent: Color(0xFFBA68C8),
    light: Color(0xFFD1C4E9),
    chipBackground: Color(0xFFF3E5F5),
    dark: Color(0xFF4A148C),
    sidebar: Color(0xFF2E0854),
    primaryForeground: white,
  );

  // ===== Themes =====
  static const AppThemeColors light = AppThemeColors(
    scaffold: white,
    surface: white,
    surface2: bg2Light,
    text: Colors.black87,
    borderIdle: gray300,
    borderFocused: primary,
    borderError: error,
    buttonBg: primary,
    buttonFg: white,
    tabUnselected: Color(0xFF6C757D),
    darkBlue: darkBlue,
    icons: Colors.white,

    // New (overrides of defaults where needed)
    primary: primary,
    error: error,
    success: success,
    warning: warning,
    info: info,

    card: white,
    chipBg: offOffWhite,
    disabledBg: offOffWhite,
    disabledFg: Colors.black38,
    divider: dividerLight,
    overlay: overlayDark, // used over content (dialogs, sheets scrim)
    focusRing: focusPrimary,
    link: primary,
    hintText: Colors.black38,
    mutedText: Colors.black54,
  );

  static const AppThemeColors dark = AppThemeColors(
    scaffold: bgDark,
    surface: bg2Dark,
    surface2: Color(0xFF2C2C2C),
    text: white,
    borderIdle: Colors.white24,
    borderFocused: primary,
    borderError: error,
    buttonBg: primary,
    buttonFg: white,
    tabUnselected: Colors.white70,
    darkBlue: darkBlue,
    icons: Colors.white70,

    // New (overrides of defaults where needed)
    primary: primary,
    error: error,
    success: success,
    warning: warning,
    info: info,

    card: Color(0xFF1E1E1E),
    chipBg: Color(0xFF2A2A2A),
    disabledBg: Color(0xFF2A2A2A),
    disabledFg: Colors.white38,
    divider: dividerDark,
    overlay: overlayLight, // lighter overlay over dark
    focusRing: focusPrimary,
    link: lightBlue,
    hintText: Colors.white38,
    mutedText: Colors.white70,
  );

  static AppThemeColors colorsFor(bool isDark) => isDark ? dark : light;

  static AppThemeColors of(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? dark : light;

  static FeaturePalette featurePaletteFor(String sectionKey) {
    final root = sectionKey.split(':').first.toLowerCase();
    switch (root) {
      case 'purchase':
        return purchasePalette;
      default:
        return brandPalette;
    }
  }

}

class AppThemeColors {
  // Core
  final Color scaffold, surface, surface2, text;
  final Color borderIdle, borderFocused, borderError;
  final Color buttonBg, buttonFg, darkBlue, icons, tabUnselected;

  // Added semantic tokens (optional with defaults)
  final Color primary; // brand primary
  final Color error; // main error (not only border)
  final Color success; // success states
  final Color warning; // warnings
  final Color info; // informational accents

  // Surfaces & states
  final Color card; // cards/dialogs
  final Color chipBg; // chips/pills background
  final Color disabledBg; // disabled background
  final Color disabledFg; // disabled foreground/text/icon
  final Color divider; // dividers/separators
  final Color overlay; // scrim/overlay for modals
  final Color focusRing; // focus outline/ring

  // Text utilities
  final Color link; // hyperlink color
  final Color hintText; // placeholders/hints
  final Color mutedText; // secondary/tertiary labels

  const AppThemeColors({
    // required (existing)
    required this.scaffold,
    required this.surface,
    required this.surface2,
    required this.text,
    required this.borderIdle,
    required this.borderFocused,
    required this.borderError,
    required this.buttonBg,
    required this.buttonFg,
    required this.tabUnselected,
    required this.icons,
    this.darkBlue = AppColors.darkBlue,

    // optional (new) — safe defaults
    this.primary = AppColors.primary,
    this.error = AppColors.error,
    this.success = AppColors.success,
    this.warning = AppColors.warning,
    this.info = AppColors.info,
    this.card = AppColors.white,
    this.chipBg = AppColors.offOffWhite,
    this.disabledBg = AppColors.offOffWhite,
    this.disabledFg = Colors.black38,
    this.divider = AppColors.dividerLight,
    this.overlay = AppColors.overlayDark,
    this.focusRing = AppColors.focusPrimary,
    this.link = AppColors.primary,
    this.hintText = Colors.black38,
    this.mutedText = Colors.black54,
  });
}

class FeaturePalette {
  final Color primary;
  final Color primaryAccent;
  final Color light;
  final Color chipBackground;
  final Color dark;
  final Color sidebar;
  final Color primaryForeground;

  const FeaturePalette({
    required this.primary,
    required this.primaryAccent,
    required this.light,
    required this.chipBackground,
    required this.dark,
    required this.sidebar,
    this.primaryForeground = Colors.white,
  });
}

// sugar
extension AppCx on BuildContext {
  AppThemeColors get colors => AppColors.of(this);
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}



  // // Blues
  // static const Color hintOfBlue = Color(0xFFF5FAFF); // Almost white
  // static const Color ultraLightBlue = Color(0xFFF0F8FF); // Alice Blue
  // static const Color softSkyBlue = Color(0xFFEAF6FF); // Custom soft blue
  // static const Color lightestBlue = Color(0xFFE3F2FD); // Very light blue
  // static const Color lighterBlue = Color(0xFFBBDEFB); // Soft pastel blue
  // static const Color lightBlue = Color(0xFF64B5F6); // Light sky blue
  // static const Color primary = Color(0xFF2196F3); // Standard blue
  // static const Color darkBlue = Color(0xFF1976D2); // Deep blue
  // static const Color darkestBlue = Color(0xFF0D47A1); // Navy blue

  // static const Color ultraLightBlue = Color(0xFFFFEAEA); // Very light bordo
  // static const Color softSkyBlue = Color(0xFFFFD6D6); // Custom soft red
  // static const Color lightestBlue = Color(0xFFFFCFCF); // Very light red
  // static const Color lighterBlue = Color(0xFFFF9999); // Soft pastel red
  // static const Color lightBlue = Color(0xFFFF6666); // Light red
  // static const Color primary = Color(0xFFCC3333); // Standard bordo red
  // static const Color darkBlue = Color(0xFF990000); // Deep red
  // static const Color darkestBlue = Color(0xFF660000); // Very dark bordo

  // static const Color white = Color(0xFFFFF5E6); // Vanilla cream
  // static const Color White = Color(0xFFFFF5E6); // Vanilla cream

  // static const offWhite = Color(0xFFFFE3CC); // Darker vanilla cream
  // static const offOffWhite = Color(0xFFFFCCAA); // Even deeper cream

  // Reds (main theme)
  // static const Color ultraLightBlue = Color(
  //   0xFFFFF1F2,
  // ); // Soft blush (lightest background red tint)
  // static const Color softSkyBlue = Color(0xFFFFE4E6); // Gentle pastel red/pink
  // static const Color lightestBlue = Color(0xFFFFCDD2); // Light rose red
  // static const Color lighterBlue = Color(0xFFEF9A9A); // Soft coral red
  // static const Color lightBlue = Color(0xFFE57373); // Pleasant light red
  // static const Color primary = Color(
  //   0xFFD32F2F,
  // ); // Primary red (Material guideline red)
  // static const Color darkBlue = Color(0xFFB71C1C); // Strong dark red
  // static const Color darkestBlue = Color(0xFF7F0000); // Deep bordo red

  // // Neutrals (backgrounds & surfaces)
  // static const Color white = Color(0xFFFFFFFF); // Pure white
  // static const Color White = Color(0xFFFFFFFF); // Same as above

  // static const Color offWhite = Color(
  //   0xFFF5F5F5,
  // ); // Light grey (cards, surfaces)
  // static const Color offOffWhite = Color(
  //   0xFFEEEEEE,
  // ); // Slightly darker grey (secondary surfaces)

  // // Neutrals (backgrounds & surfaces)
  // static const Color white = Color(0xFFFFFFFF); // Pure white
  // static const Color White = Color(0xFFFFFFFF); // Same as above

  // static const Color offWhite = Color(0xFFF5F5F5); // Light neutral grey
  // static const Color offOffWhite = Color(
  //   0xFFEEEEEE,
  // ); // Slightly darker neutral grey

  // Greens (main theme)
  // static const Color ultraLightBlue = Color(
  //   0xFFE8F5E9,
  // ); // Very light mint green
  // static const Color softSkyBlue = Color(0xFFC8E6C9); // Soft pastel green
  // static const Color lightestBlue = Color(0xFFA5D6A7); // Light fresh green
  // static const Color lighterBlue = Color(0xFF81C784); // Bright leafy green
  // static const Color lightBlue = Color(0xFF66BB6A); // Pleasant medium green
  // static const Color primary = Color(0xFF388E3C); // Strong primary green
  // static const Color darkBlue = Color(0xFF2E7D32); // Deep forest green
  // static const Color darkestBlue = Color(0xFF1B5E20); // Very dark green

  // // Neutrals (backgrounds & surfaces)
  // static const Color white = Color(0xFFFFFFFF); // Pure white
  // static const Color White = Color(0xFFFFFFFF); // Same as above

  // static const Color offWhite = Color(0xFFF5F5F5); // Light grey for surfaces
  // static const Color offOffWhite = Color(0xFFEEEEEE); // Slightly darker grey

  // Purples (main theme)
  // static const Color ultraLightBlue = Color(0xFFF3E5F5); // Very light lavender
  // static const Color softSkyBlue = Color(0xFFE1BEE7); // Soft pastel purple
  // static const Color lightestBlue = Color(0xFFCE93D8); // Light lavender purple
  // static const Color lighterBlue = Color(0xFFBA68C8); // Bright lilac
  // static const Color lightBlue = Color(0xFFAB47BC); // Medium orchid purple
  // static const Color primary = Color(0xFF8E24AA); // Strong primary purple
  // static const Color darkBlue = Color(0xFF6A1B9A); // Deep royal purple
  // static const Color darkestBlue = Color(0xFF4A148C); // Very dark purple

  // // Purples (refined theme)
  // static const Color ultraLightBlue = Color(
  //   0xFFF8F5FF,
  // ); // Almost white lavender
  // static const Color softSkyBlue = Color(0xFFEDE7F6); // Soft pastel lavender
  // static const Color lightestBlue = Color(0xFFD1C4E9); // Gentle light purple
  // static const Color lighterBlue = Color(0xFFB39DDB); // Smooth lilac
  // static const Color lightBlue = Color(0xFF9575CD); // Medium violet
  // static const Color primary = Color(
  //   0xFF7E57C2,
  // ); // Strong purple (primary brand color)
  // static const Color darkBlue = Color(0xFF5E35B1); // Deep purple
  // static const Color darkestBlue = Color(0xFF4527A0); // Dark royal purple

  // // Neutrals (backgrounds & surfaces)
  // static const Color white = Color(0xFFFFFFFF); // Pure white
  // static const Color White = Color(0xFFFFFFFF); // Same as above

  // static const Color offWhite = Color(0xFFF5F5F5); // Light neutral grey
  // static const Color offOffWhite = Color(0xFFE0E0E0); // Medium-light grey

  // Earthy Neutrals (modern theme)
  // static const Color ultraLightBlue = Color(0xFFFFF8F2); // Very light ivory
  // static const Color softSkyBlue = Color(0xFFFDEBD0); // Soft peach-beige
  // static const Color lightestBlue = Color(0xFFFAD7A0); // Light sand
  // static const Color lighterBlue = Color(0xFFF5B041); // Warm amber
  // static const Color lightBlue = Color(0xFFE67E22); // Medium orange-brown
  // static const Color primary = Color(0xFFCA6F1E); // Burnt orange (primary)
  // static const Color darkBlue = Color(0xFF935116); // Deep earthy brown
  // static const Color darkestBlue = Color(0xFF5D2E0F); // Very dark brown

  // // Neutrals (backgrounds & surfaces)
  // static const Color white = Color(0xFFFFF3E0); // Warm cream (instead of white)
  // static const Color White = Color(0xFFFFF3E0); // Same as above

  // static const Color offWhite = Color(0xFFF2E1C1); // Beige neutral
  // static const Color offOffWhite = Color(
  //   0xFFE0C097,
  // ); // Deeper beige/coffee cream

  // Neutrals
  // static const Color white = Color(0xFFFFFFFF);
  // static const White = Colors.white;

 

//  // Greens
//   static const Color green = Color(0xFFA3D39C);
//   static const Color lightGreen = Color(0xFFC7E8A9);
//   static const Color darkGreen = Color(0xFF2C5F2D);

//   // Purples
//   static const Color purple = Color(0xFFB39CD0);
//   static const Color lightPurple = Color(0xFFD6CADD);
//   static const Color darkPurple = Color(0xFF4A3F55);

//   // Neutrals
//   static const Color white = Color(0xFFFFFFFF);
//   static const Color black = Color(0xFF000000);
//   static const Color lightGray = Color(0xFFF5F5F5);
//   static const Color darkGray = Color(0xFF4A4A4A);

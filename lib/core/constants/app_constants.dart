import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../localization/app_localizations.dart';

class AppConstants {
  // API details
  static const String baseUrl = "http://192.168.50.94:8000/api";
  static const String apiVersion = "v1";
  static const String servioKey = "123456";
  // Application name
  static const String appName = "Servio";

  // Localizations
  static const List<LocalizationsDelegate> localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  // Supported languages
  static const List<Locale> supportedLocales = [Locale('en', 'US'), Locale('ar', 'LB'), Locale('fr', 'FR')];
  static const String defaultLang = 'en';

  static Locale localeResolutionCallback(Locale? locale, Iterable<Locale> supportedLocales) {
    return supportedLocales.firstWhere((supported) => supported.languageCode == locale?.languageCode,
        orElse: () => supportedLocales.first);
  }
}

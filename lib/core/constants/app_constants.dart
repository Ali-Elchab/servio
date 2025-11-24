import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../localization/app_localizations.dart';

class AppConstants {
  // API details
  static const String baseUrl = "https://api.servio.local";
  // static const String apiVersion = "v1";
  static const String xApiKey = "I6sNlKWoLzNlAN1nYxSTaU8FEVjrqATuP3k8OTiv";
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

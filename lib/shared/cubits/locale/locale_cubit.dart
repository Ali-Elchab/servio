import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/constants/app_constants.dart';
import '/core/di/locator.dart';
import '/shared/services/cache_manager.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : _cache = getIt<CacheManager>(), super(Locale(AppConstants.defaultLang)) {
    _initialize();
  }

  final CacheManager _cache;

  void _initialize() {
    // read from pref (via cachemangre)
    final code = _cache.currentLanguageCode;
    emit(Locale(code));
  }

  Future<void> changeLocale(Locale newLocale) async {
    //  update memory flag
    await _cache.setLanguageCode(newLocale.languageCode);
    emit(newLocale);

    // if logged in, update backend language \\ TODO
    if (_cache.hasToken) {}
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared/services/cache_manager.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this._cache) : super(const ThemeState(mode: ThemeMode.light, isDark: false)) {
    _initializeTheme();
  }
  final CacheManager _cache;

  void _initializeTheme() {
    final savedIsDark = _cache.isDark;
    // Respect system by default when nothing saved:
    // if (!pref.containsKey(CacheKey.isDark)) {
    //   emit(const ThemeState(mode: ThemeMode.system, isDark: false));
    //   return;
    // }
    emit(ThemeState(mode: savedIsDark ? ThemeMode.dark : ThemeMode.light, isDark: savedIsDark));
  }

  Future<void> toggleTheme() async {
    final nextIsDark = !(state.mode == ThemeMode.dark || state.isDark);
    await _cache.setIsDark(nextIsDark);
    emit(ThemeState(mode: nextIsDark ? ThemeMode.dark : ThemeMode.light, isDark: nextIsDark));
  }

  Future<void> setMode(ThemeMode mode) async {
    final nextIsDark = mode == ThemeMode.dark;
    await _cache.setIsDark(nextIsDark);
    emit(ThemeState(mode: mode, isDark: nextIsDark));
  }
}

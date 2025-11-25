import '/shared/models/role.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/core/constants/app_constants.dart';

class CacheKey {
  static const token = "token";
  static const role = "role";
  static const isDark = "is_dark";
  static const language = "language";
  static const userId = "user_id";
  static const isLoggedIn = "is_logged_in";
  static const hasSeenOnboarding = "has_seen_onboarding";
  static const lastSynced = "last_synced";
  static const categoriesLastSynced = "categories_last_synced";
  static const warehousesLastSynced = "warehouses_last_synced";
}

class CacheManager {
  CacheManager(this._prefs) {
    hasLanguageMem = _prefs.containsKey(CacheKey.language);
    hasSeenOnboardingMem = _prefs.getBool(CacheKey.hasSeenOnboarding) ?? false;
  }

  final SharedPreferences _prefs;

  bool hasLanguageMem = false;
  bool hasSeenOnboardingMem = false;

  Future<void> setHasSeenOnboarding(bool v) async {
    hasSeenOnboardingMem = v;
    await _prefs.setBool(CacheKey.hasSeenOnboarding, v);
  }

  bool get hasSeenOnboarding => hasSeenOnboardingMem;

  String? get token => _prefs.getString(CacheKey.token);
  bool get hasToken => (_prefs.getString(CacheKey.token) ?? '').isNotEmpty;

  Future<void> setToken(String? v) async =>
      v == null || v.isEmpty ? _prefs.remove(CacheKey.token) : _prefs.setString(CacheKey.token, v);

  int? get userId => _prefs.getInt(CacheKey.userId);
  Future<void> setUserId(int? id) async => id == null ? _prefs.remove(CacheKey.userId) : _prefs.setInt(CacheKey.userId, id);

  String get currentLanguageCode => _prefs.getString(CacheKey.language) ?? AppConstants.defaultLang;
  bool get hasLanguage => hasLanguageMem;
  Future<void> setLanguageCode(String code) async {
    hasLanguageMem = true;
    await _prefs.setString(CacheKey.language, code);
  }

  bool get isLoggedIn => _prefs.getBool(CacheKey.isLoggedIn) ?? false;
  Future<void> setIsLoggedIn(bool v) => _prefs.setBool(CacheKey.isLoggedIn, v);

  bool get isDark => _prefs.getBool(CacheKey.isDark) ?? false;
  Future<void> setIsDark(bool v) => _prefs.setBool(CacheKey.isDark, v);

  Future<void> setRole(Role? role) async {
    if (role == null) {
      await _prefs.remove(CacheKey.role);
    } else {
      await _prefs.setString(CacheKey.role, role.name);
    }
  }

  Role? get cachedRole {
    final raw = _prefs.getString(CacheKey.role);
    if (raw == 'provider') return Role.provider;
    if (raw == 'user') return Role.user;
    return null;
  }

  Future<void> clearTokenAndUser() async {
    await _prefs.remove(CacheKey.token);
    await _prefs.remove(CacheKey.userId);
    await _prefs.remove(CacheKey.isLoggedIn);
    await _prefs.remove(CacheKey.lastSynced);
  }

  String? get lastSyncedAt => _prefs.getString(CacheKey.lastSynced);
  Future<void> setLastSyncedAt(String? isoString) async {
    if (isoString == null || isoString.isEmpty) {
      await _prefs.remove(CacheKey.lastSynced);
    } else {
      await _prefs.setString(CacheKey.lastSynced, isoString);
    }
  }

  String? get categoriesLastSyncedAt => _prefs.getString(CacheKey.categoriesLastSynced);
  Future<void> setCategoriesLastSyncedAt(String? isoString) async {
    if (isoString == null || isoString.isEmpty) {
      await _prefs.remove(CacheKey.categoriesLastSynced);
    } else {
      await _prefs.setString(CacheKey.categoriesLastSynced, isoString);
    }
  }

  // Warehouses-specific TTL helpers
  String? get warehousesLastSyncedAt => _prefs.getString(CacheKey.warehousesLastSynced);
  Future<void> setWarehousesLastSyncedAt(String? isoString) async {
    if (isoString == null || isoString.isEmpty) {
      await _prefs.remove(CacheKey.warehousesLastSynced);
    } else {
      await _prefs.setString(CacheKey.warehousesLastSynced, isoString);
    }
  }
}

import 'dart:developer';

import 'package:drift/drift.dart';
import '/shared/db/app_db.dart';
import '/core/utils/result.dart';
import '/core/errors/app_exception.dart';
import '../models/user.dart';
import '../remote/auth_remote_source.dart';
import '/shared/services/cache_manager.dart';
import '/shared/db/daos/user_dao.dart';

class AuthRepository {
  final AuthRemoteSource auth;
  final CacheManager cache;
  final UserDao userDao;

  AuthRepository(this.auth, this.cache, this.userDao);

  Future<Result<User>> login(String identifier, String password) async {
    try {
      final user = await auth.login(identifier, password);

      await cache.setToken(user.token);
      await cache.setUserId(user.id);
      await cache.setIsLoggedIn(true);

      await userDao.transaction(() async {
        await userDao.upsertUser(_toUsersCompanion(user));
      });

      return Ok(user);
    } on AppException catch (e) {
      log('Login error', error: e);
      return Err(e);
    } catch (e, st) {
      log('Login error', error: e, stackTrace: st);
      return Err(UnknownException('Unexpected login error', debugMessage: e.toString(), cause: e, stackTrace: st));
    }
  }

  Future<Result<User>> register(Map<String, dynamic> payload) async {
    try {
      final user = await auth.register(payload);

      await cache.setToken(user.token);
      await cache.setUserId(user.id);
      await cache.setIsLoggedIn(true);

      await userDao.transaction(() async {
        await userDao.upsertUser(_toUsersCompanion(user));
      });

      return Ok(user);
    } on AppException catch (e) {
      return Err(e);
    } catch (e, st) {
      return Err(UnknownException('Unexpected register error', debugMessage: e.toString(), cause: e, stackTrace: st));
    }
  }

  Future<User?> loadCachedUser() async {
    final id = cache.userId;
    if (id == null) return null;

    final dbUser = await userDao.getUserById(id);
    if (dbUser == null) return null;

    return User(
      token: cache.token ?? '',
      id: dbUser.id,
      name: dbUser.name,
      email: dbUser.email,
      image: dbUser.image,
      customFields: dbUser.customFieldsJson,
    );
  }

  Future<void> logout() async {
    final id = cache.userId;
    await userDao.transaction(() async {
      if (id != null) {
        await (userDao.delete(userDao.users)..where((u) => u.id.equals(id))).go();
      }
      await cache.clearTokenAndUser();
    });
  }

  UsersCompanion _toUsersCompanion(User u) => UsersCompanion(
        id: Value(u.id),
        name: Value(u.name),
        email: Value(u.email),
        image: Value(u.image),
        customFieldsJson: Value(u.customFields),
      );

  DateTime? _parseDate(String? d) => (d == null || d.isEmpty) ? null : DateTime.tryParse(d);
}

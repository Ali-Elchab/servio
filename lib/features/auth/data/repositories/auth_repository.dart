import 'dart:developer';

import 'package:drift/drift.dart';
import '/features/auth/data/models/company.dart';
import '/shared/db/app_db.dart';
import '/core/utils/result.dart';
import '/core/errors/app_exception.dart';
import '../models/user.dart';
import '../remote/auth_remote_source.dart';
import '/shared/services/cache_manager.dart';
import '/shared/db/daos/user_dao.dart';
import '/shared/db/daos/company_dao.dart';

class AuthRepository {
  final AuthRemoteSource auth;
  final CacheManager cache;
  final UserDao userDao;
  final CompanyDao companyDao;

  AuthRepository(this.auth, this.cache, this.userDao, this.companyDao);

  Future<Result<User>> login(String identifier, String password) async {
    try {
      final user = await auth.login(identifier, password);

      await cache.setToken(user.token);
      await cache.setUserId(user.id);
      await cache.setIsLoggedIn(true);
      await cache.setCompanyId(user.companies.first.id);

      await userDao.transaction(() async {
        await userDao.upsertUser(_toUsersCompanion(user));
        if (user.companies.isNotEmpty) {
          await companyDao.upsertCompanies(
            user.companies.map(_toCompaniesCompanion).toList(),
          );
        }
        await _refreshUserPivots(user);
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
        if (user.companies.isNotEmpty) {
          await companyDao.upsertCompanies(
            user.companies.map(_toCompaniesCompanion).toList(),
          );
        }
        await _refreshUserPivots(user);
      });

      return Ok(user);
    } on AppException catch (e) {
      return Err(e);
    } catch (e, st) {
      return Err(UnknownException('Unexpected register error', debugMessage: e.toString(), cause: e, stackTrace: st));
    }
  }

  Future<void> _refreshUserPivots(User user) async {
    await (userDao.delete(userDao.userCompanies)..where((t) => t.userId.equals(user.id))).go();
    if (user.companies.isEmpty) return;
    await userDao.batch((b) {
      b.insertAll(
        userDao.userCompanies,
        user.companies.map((c) {
          final isOwner = (c.ownerEmail).toLowerCase() == user.email.toLowerCase();
          return UserCompaniesCompanion.insert(
            userId: user.id,
            companyId: c.id,
            isOwner: Value(isOwner),
          );
        }).toList(),
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  Future<User?> loadCachedUser() async {
    final id = cache.userId;
    if (id == null) return null;

    final dbUser = await userDao.getUserById(id);
    if (dbUser == null) return null;

    final dbCompanies = await companyDao.companiesForUser(id);

    return User(
      token: cache.token ?? '',
      id: dbUser.id,
      name: dbUser.name,
      email: dbUser.email,
      image: dbUser.image,
      customFields: dbUser.customFieldsJson,
      companies: dbCompanies.map(_mapDbCompany).toList(),
    );
  }

  Future<void> logout() async {
    final id = cache.userId;
    await userDao.transaction(() async {
      if (id != null) {
        await (userDao.delete(userDao.userCompanies)..where((t) => t.userId.equals(id))).go();
        await (userDao.delete(userDao.users)..where((u) => u.id.equals(id))).go();
      }
      await cache.clearTokenAndUser();
    });
  }

  Company _mapDbCompany(DbCompany c) => Company(
        id: c.id,
        uuid: c.uuid,
        name: c.name,
        logo: c.logo ?? '',
        ownerName: c.ownerName,
        ownerEmail: c.ownerEmail,
        plan: c.plan,
        subscriptionStatus: c.subscriptionStatus,
        currentCycleEnd: c.currentCycleEnd?.toIso8601String() ?? '',
      );

  UsersCompanion _toUsersCompanion(User u) => UsersCompanion(
        id: Value(u.id),
        name: Value(u.name),
        email: Value(u.email),
        image: Value(u.image),
        customFieldsJson: Value(u.customFields),
      );

  CompaniesCompanion _toCompaniesCompanion(Company c) => CompaniesCompanion(
        id: Value(c.id),
        uuid: Value(c.uuid),
        name: Value(c.name),
        logo: Value(c.logo),
        ownerName: Value(c.ownerName),
        ownerEmail: Value(c.ownerEmail),
        plan: Value(c.plan),
        subscriptionStatus: Value(c.subscriptionStatus),
        currentCycleEnd: Value(_parseDate(c.currentCycleEnd)),
      );

  DateTime? _parseDate(String? d) => (d == null || d.isEmpty) ? null : DateTime.tryParse(d);
}

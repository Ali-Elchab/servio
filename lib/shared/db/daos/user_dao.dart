// lib/shared/db/daos/user_dao.dart
import 'package:drift/drift.dart';
import '../app_db.dart';
import '../tables/users_table.dart';
import '../tables/companies_table.dart';
import '../tables/user_companies_table.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users, Companies, UserCompanies])
class UserDao extends DatabaseAccessor<AppDb> with _$UserDaoMixin {
  UserDao(super.db);

  Future<void> upsertUsers(List<UsersCompanion> rows) async => batch((b) => b.insertAllOnConflictUpdate(users, rows));

  Future<void> upsertUser(UsersCompanion row) => into(users).insertOnConflictUpdate(row);

  Future<List<DbUser>> getUsers() => select(users).get();

  Future<DbUser?> getUserById(int id) => (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();

  Future<int> deleteUser(int id) => (delete(users)..where((u) => u.id.equals(id))).go();
}

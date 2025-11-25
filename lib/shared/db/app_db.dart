import 'dart:io';

import 'package:drift/drift.dart';
import '/shared/db/db_converters.dart';
import 'package:drift/native.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// import table files
import 'tables/users_table.dart';
import 'tables/providers_table.dart';
import 'tables/categories_table.dart';

// import dao files
import 'daos/user_dao.dart';
import 'daos/providers_dao.dart';
import 'daos/categories_dao.dart';

part 'app_db.g.dart';

@DriftDatabase(
  tables: [
    Users,
    Providers,
    Categories,
  ],
  daos: [
    UserDao,
    ProvidersDao,
    CategoriesDao,
  ],
)
class AppDb extends _$AppDb {
  AppDb(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
      );

  static Future<AppDb> make() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'Servio.db'));
    final exec = NativeDatabase(file);
    final db = AppDb(exec);
    // PRAGMAs
    await db.customStatement('PRAGMA foreign_keys = ON;');
    await db.customStatement('PRAGMA journal_mode = WAL;');
    return db;
  }
}

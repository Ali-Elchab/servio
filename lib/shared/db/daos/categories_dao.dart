import 'package:drift/drift.dart';
import '/shared/db/app_db.dart';
import '/shared/db/tables/categories_table.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoriesDao extends DatabaseAccessor<AppDb> with _$CategoriesDaoMixin {
  CategoriesDao(AppDb db) : super(db);

  Future<void> replaceAll(List<CategoriesCompanion> rows) async {
    await transaction(() async {
      await delete(categories).go();
      if (rows.isEmpty) return;
      await batch((b) {
        b.insertAll(
          categories,
          rows,
          mode: InsertMode.insertOrReplace,
        );
      });
    });
  }

  Stream<List<DbCategory>> watchRoots({bool includeInactive = false}) {
    final query = select(categories)
      ..where((c) => c.parentId.isNull() & (includeInactive ? const Constant<bool>(true) : c.isActive.equals(true)))
      ..orderBy([(c) => OrderingTerm(expression: c.priority)]);
    return query.watch();
  }

  Stream<List<DbCategory>> watchChildren(int parentId, {bool includeInactive = false}) {
    final query = select(categories)
      ..where((c) => c.parentId.equals(parentId) & (includeInactive ? const Constant<bool>(true) : c.isActive.equals(true)))
      ..orderBy([(c) => OrderingTerm(expression: c.priority)]);
    return query.watch();
  }

  Future<List<DbCategory>> getAll() => select(categories).get();

  Future<void> clearAll() => delete(categories).go();
}

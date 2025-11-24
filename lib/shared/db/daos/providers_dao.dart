import 'package:drift/drift.dart';
import '/shared/db/app_db.dart';
import '/shared/db/tables/providers_table.dart';

part 'providers_dao.g.dart';

@DriftAccessor(tables: [Providers])
class ProvidersDao extends DatabaseAccessor<AppDb> with _$ProvidersDaoMixin {
  ProvidersDao(AppDb db) : super(db);

  Future<void> upsertMany(List<ProvidersCompanion> rows) async {
    if (rows.isEmpty) return;
    await batch((b) {
      for (final row in rows) {
        b.insert(
          providers,
          row,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Stream<List<DbProvider>> watch({String? search, int? categoryId}) {
    final query = select(providers)
      ..where((p) => p.isDeleted.equals(false));

    if (search != null && search.trim().isNotEmpty) {
      final q = '%${search.trim()}%';
      query.where((p) => p.name.like(q));
    }
    if (categoryId != null) {
      query.where((p) => p.categoryId.equals(categoryId));
    }
    query.orderBy([(p) => OrderingTerm(expression: p.name)]);
    return query.watch();
  }

  Future<int> count() async {
    final res = await (selectOnly(providers)..addColumns([providers.id.count()])).map((r) => r.read(providers.id.count()) ?? 0).getSingle();
    return res;
  }

  Future<DbProvider?> getById(int id) => (select(providers)..where((p) => p.id.equals(id))).getSingleOrNull();

  Future<void> softDeleteByIds(Iterable<int> ids) async {
    if (ids.isEmpty) return;
    await (update(providers)..where((p) => p.id.isIn(ids.toList()))).write(const ProvidersCompanion(isDeleted: Value(true)));
  }

  Future<void> clearAll() => delete(providers).go();
}

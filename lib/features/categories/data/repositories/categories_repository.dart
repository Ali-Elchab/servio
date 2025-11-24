import 'package:flutter/foundation.dart';
import '/shared/db/daos/categories_dao.dart';
import '/shared/services/cache_manager.dart';
import '../models/category.dart' as category;
import '../models/category_mappers.dart';
import '../remote/categories_remote_source.dart';

class CategoriesRepository {
  final CategoriesDao categoriesDao;
  final CategoriesRemoteSource remote;
  final CacheManager cache;

  CategoriesRepository({
    required this.categoriesDao,
    required this.remote,
    required this.cache,
  });

  Stream<List<category.Category>> watchRoots({bool includeInactive = false}) =>
      categoriesDao.watchRoots(includeInactive: includeInactive).map((rows) => rows.map(dbCategoryToDomain).toList());

  Stream<List<category.Category>> watchChildren(int parentId, {bool includeInactive = false}) => categoriesDao
      .watchChildren(parentId, includeInactive: includeInactive)
      .map((rows) => rows.map(dbCategoryToDomain).toList());

  Future<List<category.Category>> getAll() async {
    final rows = await categoriesDao.getAll();
    return rows.map(dbCategoryToDomain).toList();
  }

  Future<void> sync({bool force = false}) async {
    final fetched = await remote.fetchAll();
    await categoriesDao.replaceAll(fetched.map(domainToCategoryCompanion).toList());
    final now = DateTime.now().toUtc().toIso8601String();
    await cache.setCategoriesLastSyncedAt(now);
    debugPrint('[Sync] Categories synced up to $now');
  }

  Future<void> clearLocal() => categoriesDao.clearAll();
}

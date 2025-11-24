import 'package:flutter/foundation.dart';
import '/shared/db/daos/providers_dao.dart';
import '/shared/services/cache_manager.dart';
import '../models/provider.dart';
import '../models/provider_mappers.dart';
import '../remote/providers_remote_source.dart';
import 'package:dio/dio.dart';

class ProvidersRepository {
  final ProvidersDao providersDao;
  final ProvidersRemoteSource remote;
  final CacheManager cache;

  ProvidersRepository({
    required this.providersDao,
    required this.remote,
    required this.cache,
  });

  Stream<List<Provider>> watch({String? search, int? categoryId}) =>
      providersDao.watch(search: search, categoryId: categoryId).map((rows) => rows.map(dbProviderToDomain).toList());

  Future<void> sync({bool force = false}) async {
    final String? baseline = force ? null : cache.lastSyncedAt;
    String? latestSeen;

    int page = 1;
    while (true) {
      final chunk = await remote.sync(lastSynced: baseline, page: page);
      if (chunk.rows.isNotEmpty) {
        await providersDao.upsertMany(chunk.rows.map(domainToProviderCompanion).toList());
      }
      if (chunk.deletedIds.isNotEmpty) await providersDao.softDeleteByIds(chunk.deletedIds);
      latestSeen = _maxString(latestSeen, chunk.maxUpdatedAt);
      if (!chunk.hasNext) break;
      page++;
    }

    final next = latestSeen ?? DateTime.now().toUtc().toIso8601String();
    await cache.setLastSyncedAt(next);
    debugPrint('[Sync] Providers synced up to $next');
  }

  Future<void> clearLocal() => providersDao.clearAll();

  Future<Provider?> getLocalById(int id) async {
    final row = await providersDao.getById(id);
    return row == null ? null : dbProviderToDomain(row);
  }

  Future<void> registerProvider({
    required Map<String, dynamic> payload,
    List<MultipartFile>? workImages,
    MultipartFile? profileImage,
    MultipartFile? portfolioFile,
  }) =>
      remote.registerProvider(
        payload: payload,
        workImages: workImages,
        profileImage: profileImage,
        portfolioFile: portfolioFile,
      );

  String? _maxString(String? current, String? candidate) {
    if (candidate == null) return current;
    if (current == null || candidate.compareTo(current) > 0) return candidate;
    return current;
  }
}

import 'package:dio/dio.dart';
import '/shared/services/api_service.dart';
import '/core/constants/api_endpoints.dart';
import '/core/errors/app_exception.dart';
import '../models/provider.dart';

class ProvidersRemoteSource {
  final ApiService api;
  ProvidersRemoteSource(this.api);

  Future<List<Provider>> fetchAll({String? search, int? categoryId, int? parentCategoryId}) async {
    final qp = <String, dynamic>{
      if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
      if (categoryId != null) 'category_id': categoryId,
      if (parentCategoryId != null) 'parent_category_id': parentCategoryId,
    };

    final res = await api.get(ApiEndPoints.providers, query: qp);
    final body = res.data;
    final data = body is Map ? body['data'] ?? body : body;
    final list = (data is Map ? data['data'] : data) ?? data;
    if (list is! List) {
      throw ServerException('Invalid providers response', debugMessage: '$body');
    }

    return list
        .whereType<Map>()
        .map((row) => Provider.fromMap(Map<String, dynamic>.from(row)))
        .toList(growable: false);
  }

  Future<void> registerProvider({
    required Map<String, dynamic> payload,
    List<MultipartFile>? workImages,
    MultipartFile? profileImage,
    MultipartFile? portfolioFile,
  }) async {
    final data = FormData.fromMap({
      ...payload,
      if (profileImage != null) 'profile_image': profileImage,
      if (portfolioFile != null) 'portfolio_file': portfolioFile,
      if (workImages != null && workImages.isNotEmpty) 'work_images[]': workImages,
    });

    try {
      await api.postFormData(ApiEndPoints.providers, data: data);
    } on AppException {
      rethrow;
    }
  }

  Future<ProvidersDeltaResult> sync({String? lastSynced, int page = 1, int perPage = 200}) async {
    final qp = <String, dynamic>{
      'page': page,
      'per_page': perPage,
      if (lastSynced != null) 'last_synced': lastSynced,
      'include_deleted': 1,
    };

    final res = await api.get(ApiEndPoints.providers, query: qp);
    final body = res.data;
    if (body is! Map) throw ServerException('Invalid providers delta response', debugMessage: '$body');

    final data = body['data'];
    final meta = (body['meta'] as Map?) ?? body;
    final deleted = body['deleted_ids'] ?? body['deleted'] ?? body['tombstones'];

    final rowsList = data is List
        ? data
        : (data is Map && data['data'] is List)
            ? data['data'] as List
            : const [];

    String? maxUpdatedAt;
    final rows = <Map<String, dynamic>>[];
    for (final entry in rowsList) {
      if (entry is Map<String, dynamic>) {
        rows.add(entry);
        final u = entry['updated_at'];
        if (u is String && (maxUpdatedAt == null || u.compareTo(maxUpdatedAt) > 0)) {
          maxUpdatedAt = u;
        }
      } else if (entry is Map) {
        final map = Map<String, dynamic>.from(entry);
        rows.add(map);
        final u = map['updated_at'];
        if (u is String && (maxUpdatedAt == null || u.compareTo(maxUpdatedAt) > 0)) {
          maxUpdatedAt = u;
        }
      }
    }

    final deletedIds = _extractDeleted(deleted);
    final bool hasNext = (meta['has_next'] as bool?) ?? (meta['next_page'] != null);

    return ProvidersDeltaResult(
      rows: rows.map((e) => Provider.fromMap(e)).toList(growable: false),
      deletedIds: deletedIds,
      hasNext: hasNext,
      maxUpdatedAt: maxUpdatedAt,
    );
  }

  List<int> _extractDeleted(dynamic source) {
    if (source is! List) return const [];
    return source
        .map((entry) {
          if (entry is int) return entry;
          if (entry is num) return entry.toInt();
          if (entry is Map && entry['id'] != null) {
            final raw = entry['id'];
            if (raw is int) return raw;
            if (raw is num) return raw.toInt();
          }
          return null;
        })
        .whereType<int>()
        .toList();
  }
}

class ProvidersDeltaResult {
  final List<Provider> rows;
  final List<int> deletedIds;
  final bool hasNext;
  final String? maxUpdatedAt;

  ProvidersDeltaResult({
    required this.rows,
    required this.deletedIds,
    required this.hasNext,
    required this.maxUpdatedAt,
  });
}

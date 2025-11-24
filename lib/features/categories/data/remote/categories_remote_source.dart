import '/shared/services/api_service.dart';
import '/core/constants/api_endpoints.dart';
import '/core/errors/app_exception.dart';
import 'package:collection/collection.dart';
import '../models/category.dart';

class CategoriesRemoteSource {
  final ApiService api;
  CategoriesRemoteSource(this.api);

  Future<List<Category>> fetchAll({bool includeInactive = false}) async {
    final res = await api.get(ApiEndPoints.categories, query: {
      'include_children': 1,
      if (includeInactive) 'include_inactive': 1,
    });

    final body = res.data;
    final data = body is Map ? body['data'] ?? body : body;
    final list = (data is Map ? data['data'] : data) ?? data;
    if (list is! List) {
      throw ServerException('Invalid categories response', debugMessage: '$body');
    }

    final result = <Category>[];
    for (final entry in list.whereType<Map>()) {
      final cat = Category.fromMap(Map<String, dynamic>.from(entry));
      result.add(cat);

      final children = entry['children'];
      if (children is List) {
        for (final child in children.whereType<Map>()) {
          result.add(Category.fromMap(Map<String, dynamic>.from(child), parentIdOverride: cat.id));
        }
      }
    }

    // Keep stable ordering by priority then id
    return result.sorted(
      (a, b) => a.priority != b.priority ? a.priority.compareTo(b.priority) : a.id.compareTo(b.id),
    );
  }
}

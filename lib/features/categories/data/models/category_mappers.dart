import 'package:drift/drift.dart' show Value;
import '/shared/db/app_db.dart';
import 'category.dart';

Category dbCategoryToDomain(DbCategory row) => Category(
      id: row.id,
      parentId: row.parentId,
      name: row.name,
      slug: row.slug,
      imageUrl: row.imageUrl,
      priority: row.priority,
      isActive: row.isActive,
      isDeleted: row.isDeleted,
      updatedAt: row.updatedAt,
    );

CategoriesCompanion domainToCategoryCompanion(Category c) => CategoriesCompanion(
      id: Value(c.id),
      parentId: Value(c.parentId),
      name: Value(c.name),
      slug: Value(c.slug),
      imageUrl: Value(c.imageUrl),
      priority: Value(c.priority),
      isActive: Value(c.isActive),
      isDeleted: Value(c.isDeleted),
      updatedAt: Value(c.updatedAt),
    );

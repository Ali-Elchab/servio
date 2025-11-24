import 'package:drift/drift.dart' show Value;
import '/shared/db/app_db.dart';
import 'provider.dart';

Provider dbProviderToDomain(DbProvider row) => Provider(
      id: row.id,
      uuid: row.uuid,
      name: row.name,
      categoryId: row.categoryId,
      parentCategoryId: row.parentCategoryId,
      categoryName: row.category,
      image: row.image,
      phone: row.phone,
      description: row.description,
      customFields: row.customFieldsJson,
      isDeleted: row.isDeleted,
      updatedAt: row.updatedAt,
      companyId: row.companyId,
    );

ProvidersCompanion domainToProviderCompanion(Provider p) => ProvidersCompanion(
      id: Value(p.id),
      uuid: Value(p.uuid),
      name: Value(p.name),
      categoryId: Value(p.categoryId),
      parentCategoryId: Value(p.parentCategoryId),
      category: Value(p.categoryName),
      image: Value(p.image),
      phone: Value(p.phone),
      description: Value(p.description),
      customFieldsJson: Value(p.customFields),
      updatedAt: Value(p.updatedAt),
      companyId: Value(p.companyId),
      isDeleted: Value(p.isDeleted),
    );

class Provider {
  final int id;
  final String? uuid;
  final String name;
  final int? categoryId;
  final int? parentCategoryId;
  final String? categoryName;
  final String? image;
  final String? phone;
  final String? description;
  final Map<String, dynamic>? customFields;
  final bool isDeleted;
  final String? updatedAt;
  final int? companyId;

  const Provider({
    required this.id,
    required this.name,
    this.uuid,
    this.categoryId,
    this.parentCategoryId,
    this.categoryName,
    this.image,
    this.phone,
    this.description,
    this.customFields,
    this.isDeleted = false,
    this.updatedAt,
    this.companyId,
  });

  Provider copyWith({
    int? id,
    String? uuid,
    String? name,
    int? categoryId,
    int? parentCategoryId,
    String? categoryName,
    String? image,
    String? phone,
    String? description,
    Map<String, dynamic>? customFields,
    bool? isDeleted,
    String? updatedAt,
    int? companyId,
  }) {
    return Provider(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      parentCategoryId: parentCategoryId ?? this.parentCategoryId,
      categoryName: categoryName ?? this.categoryName,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      description: description ?? this.description,
      customFields: customFields ?? this.customFields,
      isDeleted: isDeleted ?? this.isDeleted,
      updatedAt: updatedAt ?? this.updatedAt,
      companyId: companyId ?? this.companyId,
    );
  }

  factory Provider.fromMap(Map<String, dynamic> map) {
    return Provider(
      id: (map['id'] as num).toInt(),
      uuid: map['uuid'] as String?,
      name: (map['name'] ?? map['full_name'] ?? map['title'] ?? '').toString(),
      categoryId: _readCategoryId(map),
      parentCategoryId: _readParentCategoryId(map),
      categoryName: _readCategoryName(map),
      image: map['image'] as String? ?? map['avatar'] as String?,
      phone: map['phone'] as String? ?? map['mobile'] as String?,
      description: map['description'] as String?,
      customFields: map['custom_fields'] is Map ? Map<String, dynamic>.from(map['custom_fields'] as Map) : null,
      isDeleted: (map['is_deleted'] as bool?) ?? false,
      updatedAt: map['updated_at'] as String?,
      companyId: (map['company_id'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uuid': uuid,
        'name': name,
        'category_id': categoryId,
        'parent_category_id': parentCategoryId,
        'category': categoryName,
        'image': image,
        'phone': phone,
        'description': description,
        'custom_fields': customFields,
        'is_deleted': isDeleted,
        'updated_at': updatedAt,
        'company_id': companyId,
      };

  static int? _readCategoryId(Map<String, dynamic> map) {
    if (map['category_id'] is num) return (map['category_id'] as num).toInt();
    if (map['category'] is Map && (map['category'] as Map)['id'] is num) {
      return ((map['category'] as Map)['id'] as num).toInt();
    }
    return null;
  }

  static int? _readParentCategoryId(Map<String, dynamic> map) {
    if (map['parent_category_id'] is num) return (map['parent_category_id'] as num).toInt();
    if (map['category'] is Map && (map['category'] as Map)['parent_id'] is num) {
      return ((map['category'] as Map)['parent_id'] as num).toInt();
    }
    return null;
  }

  static String? _readCategoryName(Map<String, dynamic> map) {
    if (map['category_name'] is String) return map['category_name'] as String;
    if (map['category'] is Map && (map['category'] as Map)['name'] is String) {
      return (map['category'] as Map)['name'] as String;
    }
    if (map['category'] is String) return map['category'] as String;
    return null;
  }
}

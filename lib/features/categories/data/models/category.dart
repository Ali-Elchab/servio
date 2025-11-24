class Category {
  final int id;
  final int? parentId;
  final String name;
  final String? slug;
  final String? imageUrl;
  final int priority;
  final bool isActive;
  final bool isDeleted;
  final String? updatedAt;

  const Category({
    required this.id,
    required this.name,
    this.parentId,
    this.slug,
    this.imageUrl,
    this.priority = 0,
    this.isActive = true,
    this.isDeleted = false,
    this.updatedAt,
  });

  factory Category.fromMap(Map<String, dynamic> map, {int? parentIdOverride}) {
    final children = map['children'];
    return Category(
      id: (map['id'] as num).toInt(),
      parentId: parentIdOverride ?? (map['parent_id'] as num?)?.toInt(),
      name: (map['name'] ?? map['name_en'] ?? map['name_ar'] ?? '').toString(),
      slug: map['slug'] as String?,
      imageUrl: map['image_url'] as String? ?? map['image'] as String?,
      priority: (map['priority'] as num?)?.toInt() ?? 0,
      isActive: (map['is_active'] as bool?) ?? true,
      isDeleted: (map['is_deleted'] as bool?) ?? false,
      updatedAt: map['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'parent_id': parentId,
        'name': name,
        'slug': slug,
        'image_url': imageUrl,
        'priority': priority,
        'is_active': isActive,
        'is_deleted': isDeleted,
        'updated_at': updatedAt,
      };
}

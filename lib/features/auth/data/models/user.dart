import 'dart:convert';
import 'package:collection/collection.dart';
import 'company.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String? image;
  final Map<String, dynamic>? customFields;
  final UnmodifiableListView<Company> companies;
  final String? token;

  static const _mapEq = DeepCollectionEquality.unordered();

  User({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    this.customFields,
    required List<Company> companies,
    this.token,
  }) : companies = UnmodifiableListView(companies);

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? image,
    Map<String, dynamic>? customFields, // pass {} to clear
    List<Company>? companies,
    String? token, // pass '' to clear if you want
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      customFields: customFields ?? this.customFields,
      companies: companies ?? this.companies,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap({bool includeToken = false}) {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'custom_fields': customFields,
      'companies': companies.map((c) => c.toMap()).toList(),
      if (includeToken) 'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    final companiesRaw = (map["user"]['companies'] as List?) ?? const [];
    return User(
      id: (map["user"]['id'] as int),
      name: (map["user"]['name'] as String?) ?? '',
      email: (map["user"]['email'] as String?) ?? '',
      image: (map["user"]['image'] as String?),
      customFields: (map["user"]['custom_fields'] is Map) ? Map<String, dynamic>.from(map["user"]['custom_fields'] as Map) : null,
      companies: companiesRaw.whereType<Map>().map((e) => Company.fromMap(Map<String, dynamic>.from(e))).toList(),
      token: map['token'] as String?,
    );
  }

  String toJson({bool includeToken = false}) => json.encode(toMap(includeToken: includeToken));
  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(id: $id, name: $name, email: $email, companies: ${companies.length}, customFields: ${customFields?.keys.toList()})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.image == image &&
        other.token == token &&
        _mapEq.equals(other.customFields, customFields) &&
        const ListEquality<Company>().equals(other.companies, companies);
  }

  @override
  int get hashCode {
    return Object.hashAll([
      id,
      name,
      email,
      image,
      token,
      _mapEq.hash(customFields),
      const ListEquality<Company>().hash(companies),
    ]);
  }

  // Optional helpers:
  Company? get primaryCompany => companies.isNotEmpty ? companies.first : null;
}

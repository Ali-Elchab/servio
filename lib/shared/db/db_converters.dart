import 'dart:convert';

import 'package:drift/drift.dart';

class JsonMapNullableConverter extends TypeConverter<Map<String, dynamic>?, String?> {
  const JsonMapNullableConverter();
  @override
  Map<String, dynamic>? fromSql(String? fromDb) =>
      (fromDb == null || fromDb.isEmpty) ? null : Map<String, dynamic>.from(jsonDecode(fromDb) as Map);
  @override
  String? toSql(Map<String, dynamic>? value) => value == null ? null : jsonEncode(value);
}

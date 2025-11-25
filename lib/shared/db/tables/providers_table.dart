import 'package:drift/drift.dart';
import '/shared/db/db_converters.dart';

@DataClassName('DbProvider')
class Providers extends Table {
  IntColumn get id => integer()();
  TextColumn get uuid => text().nullable()();
  TextColumn get name => text()();
  IntColumn get categoryId => integer().nullable()();
  IntColumn get parentCategoryId => integer().nullable()();
  TextColumn get category => text().nullable()();
  TextColumn get image => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get description => text().nullable()();

  TextColumn get customFieldsJson => text().map(const JsonMapNullableConverter()).nullable()();
  TextColumn get updatedAt => text().nullable()();

  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

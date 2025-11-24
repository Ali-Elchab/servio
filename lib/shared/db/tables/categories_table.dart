import 'package:drift/drift.dart';

@DataClassName('DbCategory')
class Categories extends Table {
  IntColumn get id => integer()();
  IntColumn get parentId => integer().nullable()();

  TextColumn get name => text()();
  TextColumn get slug => text().nullable()();
  TextColumn get imageUrl => text().nullable()();

  IntColumn get priority => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  TextColumn get updatedAt => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

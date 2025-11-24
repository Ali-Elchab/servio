import 'package:drift/drift.dart';
import '/shared/db/db_converters.dart';

@DataClassName('DbUser')
class Users extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get image => text().nullable()();
  // Store raw JSON so we don't lose keys we don't model yet
  TextColumn get customFieldsJson => text().map(const JsonMapNullableConverter()).nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

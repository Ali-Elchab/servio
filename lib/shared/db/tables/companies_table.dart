import 'package:drift/drift.dart';

@DataClassName('DbCompany')
class Companies extends Table {
  IntColumn get id => integer()();
  TextColumn get uuid => text()();
  TextColumn get name => text()();
  TextColumn get logo => text().nullable()();
  TextColumn get ownerName => text()();
  TextColumn get ownerEmail => text()();
  TextColumn get plan => text()();
  TextColumn get subscriptionStatus => text()();
  DateTimeColumn get currentCycleEnd => dateTime().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

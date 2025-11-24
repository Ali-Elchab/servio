import 'package:drift/drift.dart';
import '/shared/db/tables/companies_table.dart';
import '/shared/db/tables/users_table.dart';

@DataClassName('DbUserCompany')
class UserCompanies extends Table {
  IntColumn get userId => integer().references(Users, #id, onDelete: KeyAction.cascade)();
  IntColumn get companyId => integer().references(Companies, #id, onDelete: KeyAction.cascade)();
  BoolColumn get isOwner => boolean().withDefault(const Constant(false))();
  @override
  Set<Column> get primaryKey => {userId, companyId};
}

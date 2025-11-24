import 'package:drift/drift.dart';
import '../app_db.dart';
import '../tables/users_table.dart';
import '../tables/companies_table.dart';
import '../tables/user_companies_table.dart';
part 'company_dao.g.dart';

@DriftAccessor(tables: [Companies, Users, UserCompanies])
class CompanyDao extends DatabaseAccessor<AppDb> with _$CompanyDaoMixin {
  CompanyDao(super.db);

  // ===== Companies basic =====
  Future<void> upsertCompanies(List<CompaniesCompanion> rows) async {
    await batch((b) => b.insertAllOnConflictUpdate(companies, rows));
  }

  Future<void> upsertCompany(CompaniesCompanion row) => into(companies).insertOnConflictUpdate(row);

  Future<DbCompany?> getCompanyById(int id) => (select(companies)..where((c) => c.id.equals(id))).getSingleOrNull();

  Future<int> deleteCompany(int id) => (delete(companies)..where((c) => c.id.equals(id))).go();

  // ===== Listings by user =====
  Future<List<DbCompany>> companiesForUser(int userId) {
    final q = select(companies).join([
      innerJoin(userCompanies, userCompanies.companyId.equalsExp(companies.id)),
    ])
      ..where(userCompanies.userId.equals(userId));
    return q.map((row) => row.readTable(companies)).get();
  }

  Stream<List<DbCompany>> watchCompaniesForUser(int userId) {
    final q = select(companies).join([
      innerJoin(userCompanies, userCompanies.companyId.equalsExp(companies.id)),
    ])
      ..where(userCompanies.userId.equals(userId));
    return q.watch().map((rows) => rows.map((r) => r.readTable(companies)).toList());
  }
}

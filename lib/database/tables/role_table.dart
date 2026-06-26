import 'package:drift/drift.dart';

@DataClassName('Role')
class RoleTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get roleName => text().unique()();
}

import 'package:drift/drift.dart';

@DataClassName('RolePermission')
class RolePermissionTable extends Table {
  IntColumn get roleId => integer()();
  IntColumn get permissionId => integer()();

  @override
  Set<Column> get primaryKey => {roleId, permissionId};
}

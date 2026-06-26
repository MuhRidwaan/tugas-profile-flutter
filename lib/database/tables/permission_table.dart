import 'package:drift/drift.dart';

@DataClassName('Permission')
class PermissionTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get permissionName => text().unique()();
}

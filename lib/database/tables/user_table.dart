import 'package:drift/drift.dart';

@DataClassName('User')
class UserTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().unique()();
  TextColumn get password => text()();
  IntColumn get roleId => integer().nullable()();
}

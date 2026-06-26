import 'package:drift/drift.dart';
import '../database/app_database.dart';

class UserRepository {
  final AppDatabase _db;

  UserRepository(this._db);

  Future<List<User>> getAllUsers() async {
    return await _db.select(_db.userTable).get();
  }

  Future<int> createUser(String username, String password, int? roleId) async {
    return await _db.into(_db.userTable).insert(
      UserTableCompanion.insert(
        username: username,
        password: password,
        roleId: Value(roleId),
      ),
    );
  }

  Future<void> updateUserRole(int userId, int? roleId) async {
    await (_db.update(_db.userTable)..where((u) => u.id.equals(userId))).write(
      UserTableCompanion(roleId: Value(roleId)),
    );
  }

  Future<void> deleteUser(int userId) async {
    await (_db.delete(_db.userTable)..where((u) => u.id.equals(userId))).go();
  }
}

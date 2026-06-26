import 'package:drift/drift.dart';
import '../database/app_database.dart';

class AuthRepository {
  final AppDatabase _db;

  AuthRepository(this._db);

  // Returns userId if successful, else null
  Future<int?> login(String username, String password) async {
    final query = _db.select(_db.userTable)
      ..where((u) => u.username.equals(username))
      ..where((u) => u.password.equals(password));
    
    final user = await query.getSingleOrNull();
    return user?.id;
  }

  // Returns User object
  Future<User?> getUser(int userId) async {
    final query = _db.select(_db.userTable)
      ..where((u) => u.id.equals(userId));
    return await query.getSingleOrNull();
  }

  // Returns list of permission names for a user
  Future<List<String>> getUserPermissions(int userId) async {
    final user = await getUser(userId);
    if (user == null || user.roleId == null) {
      return [];
    }

    final query = _db.select(_db.rolePermissionTable).join([
      innerJoin(
        _db.permissionTable,
        _db.permissionTable.id.equalsExp(_db.rolePermissionTable.permissionId),
      )
    ])..where(_db.rolePermissionTable.roleId.equals(user.roleId!));

    final result = await query.get();
    return result.map((row) => row.readTable(_db.permissionTable).permissionName).toList();
  }
}

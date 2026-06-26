import 'package:drift/drift.dart';
import '../database/app_database.dart';

class RoleRepository {
  final AppDatabase _db;

  RoleRepository(this._db);

  Future<List<Role>> getAllRoles() async {
    return await _db.select(_db.roleTable).get();
  }

  Future<int> createRole(String roleName) async {
    return await _db.into(_db.roleTable).insert(
      RoleTableCompanion.insert(roleName: roleName),
    );
  }

  Future<void> deleteRole(int roleId) async {
    await (_db.delete(_db.rolePermissionTable)..where((rp) => rp.roleId.equals(roleId))).go();
    await (_db.delete(_db.roleTable)..where((r) => r.id.equals(roleId))).go();
  }

  Future<List<Permission>> getAllPermissions() async {
    return await _db.select(_db.permissionTable).get();
  }

  Future<List<int>> getRolePermissionIds(int roleId) async {
    final query = _db.select(_db.rolePermissionTable)
      ..where((rp) => rp.roleId.equals(roleId));
    final results = await query.get();
    return results.map((e) => e.permissionId).toList();
  }

  Future<void> updateRolePermissions(int roleId, List<int> permissionIds) async {
    await _db.transaction(() async {
      // Delete existing
      await (_db.delete(_db.rolePermissionTable)..where((rp) => rp.roleId.equals(roleId))).go();
      
      // Insert new
      for (final pId in permissionIds) {
        await _db.into(_db.rolePermissionTable).insert(
          RolePermissionTableCompanion.insert(roleId: roleId, permissionId: pId),
        );
      }
    });
  }
}

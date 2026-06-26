import 'package:flutter/foundation.dart';
import '../repositories/role_repository.dart';
import '../database/app_database.dart';

class RoleProvider extends ChangeNotifier {
  final RoleRepository _repository;

  List<Role> _roles = [];
  List<Permission> _allPermissions = [];
  bool _isLoading = false;

  RoleProvider(this._repository);

  List<Role> get roles => _roles;
  List<Permission> get allPermissions => _allPermissions;
  bool get isLoading => _isLoading;

  Future<void> fetchRolesAndPermissions() async {
    _isLoading = true;
    notifyListeners();

    _roles = await _repository.getAllRoles();
    _allPermissions = await _repository.getAllPermissions();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createRole(String roleName) async {
    await _repository.createRole(roleName);
    await fetchRolesAndPermissions();
  }

  Future<void> deleteRole(int roleId) async {
    await _repository.deleteRole(roleId);
    await fetchRolesAndPermissions();
  }

  Future<List<int>> getRolePermissionIds(int roleId) async {
    return await _repository.getRolePermissionIds(roleId);
  }

  Future<void> updateRolePermissions(int roleId, List<int> permissionIds) async {
    await _repository.updateRolePermissions(roleId, permissionIds);
    // Refresh if needed, but not strictly required unless showing them immediately
  }
}

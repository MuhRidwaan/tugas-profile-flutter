import 'package:flutter/foundation.dart';
import '../repositories/user_repository.dart';
import '../database/app_database.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _repository;

  List<User> _users = [];
  bool _isLoading = false;

  UserProvider(this._repository);

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    _users = await _repository.getAllUsers();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createUser(String username, String password, int? roleId) async {
    await _repository.createUser(username, password, roleId);
    await fetchUsers();
  }

  Future<void> updateUserRole(int userId, int? roleId) async {
    await _repository.updateUserRole(userId, roleId);
    await fetchUsers();
  }

  Future<void> deleteUser(int userId) async {
    await _repository.deleteUser(userId);
    await fetchUsers();
  }
}

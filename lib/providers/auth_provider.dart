import 'package:flutter/foundation.dart';
import '../repositories/auth_repository.dart';
import '../database/app_database.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository;
  
  User? _currentUser;
  List<String> _userPermissions = [];
  bool _isLoading = false;
  String? _errorMessage;

  AuthProvider(this._repository);

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool hasPermission(String permission) {
    if (_currentUser == null) return false;
    return _userPermissions.contains(permission);
  }

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userId = await _repository.login(username, password);
      if (userId != null) {
        _currentUser = await _repository.getUser(userId);
        _userPermissions = await _repository.getUserPermissions(userId);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Username atau password salah';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    _userPermissions = [];
    notifyListeners();
  }
}

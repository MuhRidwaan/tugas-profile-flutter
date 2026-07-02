import 'package:flutter/foundation.dart';
import 'dart:math' as _math;
import '../repositories/class_poll_repository.dart';
import '../database/app_database.dart';

class ClassPollProvider extends ChangeNotifier {
  final ClassPollRepository _repository;

  bool _isLoading = false;
  List<ClassPoll> _allData = [];
  ClassPoll? _currentUserData;

  ClassPollProvider(this._repository);

  bool get isLoading => _isLoading;
  List<ClassPoll> get allData => _allData;
  ClassPoll? get currentUserData => _currentUserData;

  Future<void> loadAllData() async {
    _isLoading = true;
    notifyListeners();
    try {
      _allData = []; // Bersihkan data agar selalu memakai data random tiap dipanggil
      final rand = _math.Random();
      final sizes = ['S', 'M', 'L', 'XL', 'XXL'];
      
      for (int i = 1; i <= 30; i++) {
        _allData.add(
          ClassPoll(
            id: i,
            userId: i, 
            weight: 45.0 + rand.nextInt(40), 
            height: 150.0 + rand.nextInt(35), 
            shirtSize: sizes[rand.nextInt(sizes.length)],
            shoeSize: 37 + rand.nextInt(8), 
            age: 17 + rand.nextInt(8), 
            createdAt: DateTime.now().subtract(Duration(days: rand.nextInt(30))),
          ),
        );
      }
    } catch (e) {
      debugPrint("Error loading poll data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadUserPoll(int userId) async {
    _currentUserData = await _repository.getUserPoll(userId);
    notifyListeners();
  }

  Future<void> submitPoll({
    required int userId,
    required double weight,
    required double height,
    required String shirtSize,
    required int shoeSize,
    required int age,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.submitPollData(
        userId,
        weight,
        height,
        shirtSize,
        shoeSize,
        age,
      );
      await loadAllData();
      await loadUserPoll(userId);
    } catch (e) {
      debugPrint("Error submitting poll data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

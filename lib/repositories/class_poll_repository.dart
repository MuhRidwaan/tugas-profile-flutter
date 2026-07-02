import '../database/app_database.dart';
import 'package:drift/drift.dart';

class ClassPollRepository {
  final AppDatabase _db;

  ClassPollRepository(this._db);

  Future<void> submitPollData(
    int userId,
    double weight,
    double height,
    String shirtSize,
    int shoeSize,
    int age,
  ) async {
    // Check if user already submitted
    final query = _db.select(_db.classPollTable)
      ..where((t) => t.userId.equals(userId));
    final existing = await query.getSingleOrNull();

    if (existing != null) {
      // Update
      await _db.update(_db.classPollTable).replace(
            existing.copyWith(
              weight: weight,
              height: height,
              shirtSize: shirtSize,
              shoeSize: shoeSize,
              age: age,
            ),
          );
    } else {
      // Insert
      await _db.into(_db.classPollTable).insert(
            ClassPollTableCompanion.insert(
              userId: userId,
              weight: weight,
              height: height,
              shirtSize: shirtSize,
              shoeSize: shoeSize,
              age: age,
            ),
          );
    }
  }

  Future<ClassPoll?> getUserPoll(int userId) async {
    final query = _db.select(_db.classPollTable)
      ..where((t) => t.userId.equals(userId));
    return await query.getSingleOrNull();
  }

  Future<List<ClassPoll>> getAllPollData() async {
    return await _db.select(_db.classPollTable).get();
  }
}

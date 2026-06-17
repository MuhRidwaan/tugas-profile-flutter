import 'package:drift/drift.dart';
import '../database/app_database.dart';
import 'date_calculator.dart';
import '../validators/input_validator.dart';

class ZodiacService {
  final AppDatabase _database;
  final DateCalculator _dateCalculator = DateCalculator();
  final InputValidator _validator = InputValidator();

  List<ZodiacData>? _cachedZodiacs;
  DateTime? _cacheTime;
  static const _cacheDuration = Duration(hours: 1);

  ZodiacService(this._database);

  // Helper to run query safely with automatic retry on failure
  Future<ZodiacData?> _runSafely(Future<ZodiacData?> Function() query) async {
    try {
      return await query();
    } catch (e) {
      print('Query failed: $e. Attempting database recovery...');
      try {
        await reinitializeDatabase();
        return await query(); // Retry once after re-initialization
      } catch (recoveryError) {
        print('Database recovery failed: $recoveryError');
        throw Exception('Gagal mengakses database zodiak setelah upaya pemulihan.');
      }
    }
  }

  Future<ZodiacData?> getZodiacByName(String name) async {
    return _runSafely(() async {
      final sanitized = _validator.sanitizeInput(name);
      if (sanitized.isEmpty) return null;

      final query = _database.select(_database.zodiacTable)
        ..where((tbl) => tbl.namaZodiac.lower().equals(sanitized.toLowerCase()));

      return await query.getSingleOrNull();
    });
  }

  Future<ZodiacData?> getZodiacByDate(int day, int month) async {
    return _runSafely(() async {
      if (!_dateCalculator.isValidDate(day, month)) return null;

      final zodiacName = _dateCalculator.determineZodiacSign(day, month);
      if (zodiacName == null) return null;

      // Leverage case-insensitive query by name which uses unique index
      final query = _database.select(_database.zodiacTable)
        ..where((tbl) => tbl.namaZodiac.lower().equals(zodiacName.toLowerCase()));

      return await query.getSingleOrNull();
    });
  }

  Future<List<ZodiacData>> getAllZodiacs() async {
    if (_cachedZodiacs != null &&
        _cacheTime != null &&
        DateTime.now().difference(_cacheTime!) < _cacheDuration) {
      return _cachedZodiacs!;
    }

    try {
      final results = await _database.select(_database.zodiacTable).get();
      _cachedZodiacs = results;
      _cacheTime = DateTime.now();
      return results;
    } catch (e) {
      print('Failed to get all zodiacs, trying recovery: $e');
      try {
        await reinitializeDatabase();
        final results = await _database.select(_database.zodiacTable).get();
        _cachedZodiacs = results;
        _cacheTime = DateTime.now();
        return results;
      } catch (err) {
        throw Exception('Gagal memuat semua data zodiak setelah pemulihan.');
      }
    }
  }

  Future<bool> isDatabaseInitialized() async {
    try {
      final countExpr = _database.zodiacTable.id.count();
      final query = _database.selectOnly(_database.zodiacTable)..addColumns([countExpr]);
      final row = await query.getSingle();
      final count = row.read(countExpr);
      return count == 12;
    } catch (e) {
      return false;
    }
  }

  Future<void> reinitializeDatabase() async {
    _cachedZodiacs = null;
    _cacheTime = null;
    await _database.deleteDatabaseFile();
    // Reopen database by forcing a query
    await _database.select(_database.zodiacTable).get();
  }
}

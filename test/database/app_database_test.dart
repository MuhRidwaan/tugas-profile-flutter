import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/database/app_database.dart';

void main() {
  group('AppDatabase - Property Tests', () {
    // Feature: sqlite-drift-integration, Property 3: Database Initialization Idempotence
    test('Property 3: Database Initialization Idempotence - multiple database instances always yield exactly 12 records', () async {
      for (int i = 0; i < 5; i++) {
        final database = AppDatabase.forTesting(NativeDatabase.memory());
        
        final results = await database.select(database.zodiacTable).get();
        expect(results.length, 12, reason: 'Iteration $i: Database should contain exactly 12 records');

        // Check columns to verify schema integrity
        for (final row in results) {
          expect(row.id, isNotNull);
          expect(row.namaZodiac.isNotEmpty, isTrue);
          expect(row.tanggalAwal, isNotNull);
          expect(row.tanggalAkhir, isNotNull);
          expect(row.deskripsiAsmara.isNotEmpty, isTrue);
          expect(row.deskripsiKarir.isNotEmpty, isTrue);
        }

        await database.close();
      }
    });

    test('Verification of UNIQUE constraint on namaZodiac', () async {
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      
      // Attempt to insert duplicate name should throw exception
      expect(
        () => database.into(database.zodiacTable).insert(
              ZodiacTableCompanion.insert(
                namaZodiac: 'Aries', // Duplicate name
                tanggalAwal: DateTime(2024, 3, 21),
                tanggalAkhir: DateTime(2024, 4, 19),
                deskripsiAsmara: 'test',
                deskripsiKarir: 'test',
              ),
            ),
        throwsA(isA<Exception>()),
      );

      await database.close();
    });
  });
}

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/database/app_database.dart';
import 'package:profile_tugas/services/zodiac_service.dart';

void main() {
  late AppDatabase database;
  late ZodiacService service;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    service = ZodiacService(database);
    // Drift automatically triggers onCreate when first query runs, populating the database
  });

  tearDown(() async {
    await database.close();
  });

  group('ZodiacService - Property Tests', () {
    // Feature: sqlite-drift-integration, Property 2: Case-Insensitive Name Query Correctness
    test('Property 2: Case-Insensitive Name Query Correctness - queries with different casing return the same zodiac', () async {
      final zodiacs = [
        'Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo',
        'Libra', 'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
      ];

      for (final name in zodiacs) {
        // Query with original casing
        final originalResult = await service.getZodiacByName(name);
        expect(originalResult, isNotNull, reason: 'Failed to retrieve $name with original case');
        expect(originalResult!.namaZodiac, name);

        // Generate casing permutations (e.g. lowercase, uppercase, mixed)
        final permutations = [
          name.toLowerCase(),
          name.toUpperCase(),
          name[0].toLowerCase() + name.substring(1).toUpperCase(),
          ' ' + name + ' ', // with spacing
        ];

        for (final perm in permutations) {
          final result = await service.getZodiacByName(perm);
          expect(result, isNotNull, reason: 'Failed to retrieve $name with case permutation: "$perm"');
          expect(result!.id, originalResult.id, reason: 'IDs differ for case variation "$perm" of $name');
          expect(result.namaZodiac, originalResult.namaZodiac);
          expect(result.deskripsiAsmara, originalResult.deskripsiAsmara);
          expect(result.deskripsiKarir, originalResult.deskripsiKarir);
        }
      }
    });

    test('Query by date returns correct zodiac sign details', () async {
      // Test some standard date queries
      final result1 = await service.getZodiacByDate(25, 12); // Capricorn
      expect(result1, isNotNull);
      expect(result1!.namaZodiac, 'Capricorn');

      final result2 = await service.getZodiacByDate(15, 8); // Leo
      expect(result2, isNotNull);
      expect(result2!.namaZodiac, 'Leo');
    });

    test('Query with non-existent zodiac name returns null', () async {
      final result = await service.getZodiacByName('Ophiuchus');
      expect(result, isNull);
    });

    test('Query with empty or invalid name returns null', () async {
      expect(await service.getZodiacByName(''), isNull);
      expect(await service.getZodiacByName('1234'), isNull);
    });
  });
}

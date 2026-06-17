import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/services/date_calculator.dart';

void main() {
  final calculator = DateCalculator();

  group('DateCalculator - Property Tests', () {
    // Feature: sqlite-drift-integration, Property 4: Date Range Completeness
    test('Property 4: Date Range Completeness - every day of year maps to exactly one zodiac', () {
      final months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
      int totalDaysTested = 0;

      for (final month in months) {
        final daysInMonth = calculator.getDaysInMonth(month);
        for (int day = 1; day <= daysInMonth; day++) {
          final zodiacName = calculator.determineZodiacSign(day, month);
          expect(zodiacName, isNotNull, reason: 'No zodiac found for $day/$month');
          totalDaysTested++;
        }
      }

      expect(totalDaysTested, 366); // 365 + 1 (Leap year Feb 29)
    });

    // Feature: sqlite-drift-integration, Property 1: Date Range Zodiac Determination Correctness
    test('Property 1: Date Range Zodiac Determination Correctness - determined zodiac contains the input date', () {
      // Custom mapping to check bounds manually
      final bounds = {
        'Aries': {'startMonth': 3, 'startDay': 21, 'endMonth': 4, 'endDay': 19},
        'Taurus': {'startMonth': 4, 'startDay': 20, 'endMonth': 5, 'endDay': 20},
        'Gemini': {'startMonth': 5, 'startDay': 21, 'endMonth': 6, 'endDay': 20},
        'Cancer': {'startMonth': 6, 'startDay': 21, 'endMonth': 7, 'endDay': 22},
        'Leo': {'startMonth': 7, 'startDay': 23, 'endMonth': 8, 'endDay': 22},
        'Virgo': {'startMonth': 8, 'startDay': 23, 'endMonth': 9, 'endDay': 22},
        'Libra': {'startMonth': 9, 'startDay': 23, 'endMonth': 10, 'endDay': 22},
        'Scorpio': {'startMonth': 10, 'startDay': 23, 'endMonth': 11, 'endDay': 21},
        'Sagittarius': {'startMonth': 11, 'startDay': 22, 'endMonth': 12, 'endDay': 21},
        'Capricorn': {'startMonth': 12, 'startDay': 22, 'endMonth': 1, 'endDay': 19},
        'Aquarius': {'startMonth': 1, 'startDay': 20, 'endMonth': 2, 'endDay': 18},
        'Pisces': {'startMonth': 2, 'startDay': 19, 'endMonth': 3, 'endDay': 20},
      };

      // Test a generated sample of 100+ random dates
      final testDates = <Map<String, int>>[];
      for (int m = 1; m <= 12; m++) {
        final days = calculator.getDaysInMonth(m);
        // Add start, mid, end, and boundaries
        testDates.add({'day': 1, 'month': m});
        testDates.add({'day': days, 'month': m});
        testDates.add({'day': days ~/ 2, 'month': m});
        testDates.add({'day': 18, 'month': m});
        testDates.add({'day': 19, 'month': m});
        testDates.add({'day': 20, 'month': m});
        testDates.add({'day': 21, 'month': m});
        testDates.add({'day': 22, 'month': m});
        testDates.add({'day': 23, 'month': m});
      }

      expect(testDates.length, greaterThanOrEqualTo(100));

      for (final date in testDates) {
        final day = date['day']!;
        final month = date['month']!;

        final zodiac = calculator.determineZodiacSign(day, month);
        expect(zodiac, isNotNull);

        final limit = bounds[zodiac!];
        expect(limit, isNotNull);

        final startMonth = limit!['startMonth']!;
        final startDay = limit['startDay']!;
        final endMonth = limit['endMonth']!;
        final endDay = limit['endDay']!;

        final inRange = calculator.isDateInRangeStatic(day, month, startMonth, startDay, endMonth, endDay);
        expect(inRange, isTrue, reason: '$day/$month should be in range of $zodiac ($startDay/$startMonth - $endDay/$endMonth)');
      }
    });

    test('DateCalculator - Boundary validations', () {
      expect(calculator.isValidDate(0, 5), isFalse);
      expect(calculator.isValidDate(32, 5), isFalse);
      expect(calculator.isValidDate(30, 2), isFalse);
      expect(calculator.isValidDate(29, 2), isTrue); // Leap Day
      expect(calculator.isValidDate(15, 13), isFalse);
    });
  group('DateCalculator - Specific Zodiac boundary tests', () {
    test('Capricorn boundary transition (Dec 22 - Jan 19)', () {
      expect(calculator.determineZodiacSign(21, 12), 'Sagittarius');
      expect(calculator.determineZodiacSign(22, 12), 'Capricorn');
      expect(calculator.determineZodiacSign(19, 1), 'Capricorn');
      expect(calculator.determineZodiacSign(20, 1), 'Aquarius');
    });

    test('Aries boundary transition (Mar 21 - Apr 19)', () {
      expect(calculator.determineZodiacSign(20, 3), 'Pisces');
      expect(calculator.determineZodiacSign(21, 3), 'Aries');
      expect(calculator.determineZodiacSign(19, 4), 'Aries');
      expect(calculator.determineZodiacSign(20, 4), 'Taurus');
    });
  });
  });
}

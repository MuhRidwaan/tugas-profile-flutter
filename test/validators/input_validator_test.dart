import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/validators/input_validator.dart';

void main() {
  final validator = InputValidator();

  group('InputValidator - Property Tests', () {
    // Feature: sqlite-drift-integration, Property 5: Input Sanitization SQL Injection Prevention
    test('Property 5: Input Sanitization SQL Injection Prevention - SQL special characters are escaped or removed', () {
      final payloads = [
        "Aries' OR '1'='1",
        "'; DROP TABLE zodiac_table; --",
        "Taurus' /* comment */",
        "Leo; SELECT * FROM zodiac_table",
        "'; EXEC xp_cmdshell('dir'); --",
        "NormalName",
      ];

      for (final payload in payloads) {
        final sanitized = validator.sanitizeInput(payload);
        
        // Assertions:
        // 1. Single quotes should be escaped to double single quotes ''
        if (payload.contains("'")) {
          expect(sanitized.contains("''"), isTrue, reason: "Single quote not escaped in payload: $payload");
        }
        
        // 2. Semicolons should be removed
        expect(sanitized.contains(";"), isFalse, reason: "Semicolon not removed in payload: $payload");
        
        // 3. Comments `--`, `/*`, `*/` should be removed
        expect(sanitized.contains("--"), isFalse, reason: "SQL comment dashes not removed in payload: $payload");
        expect(sanitized.contains("/*"), isFalse, reason: "SQL block comment start not removed in payload: $payload");
        expect(sanitized.contains("*/"), isFalse, reason: "SQL block comment end not removed in payload: $payload");
      }
    });

    test('validateZodiacName validation rules', () {
      // Valid names
      expect(validator.validateZodiacName('Aries').isValid, isTrue);
      expect(validator.validateZodiacName('Taurus  ').isValid, isTrue); // Whitespace trimmed

      // Invalid names
      expect(validator.validateZodiacName('').isValid, isFalse);
      expect(validator.validateZodiacName('   ').isValid, isFalse);
      expect(validator.validateZodiacName('Aries123').isValid, isFalse);
      expect(validator.validateZodiacName('Aries!').isValid, isFalse);
    });

    test('validateDate validation rules', () {
      // Valid dates
      expect(validator.validateDate(15, 8).isValid, isTrue); // 15 Aug
      expect(validator.validateDate(29, 2).isValid, isTrue); // 29 Feb
      expect(validator.validateDate(30, 4).isValid, isTrue); // 30 Apr

      // Invalid dates
      expect(validator.validateDate(null, 5).isValid, isFalse);
      expect(validator.validateDate(15, null).isValid, isFalse);
      expect(validator.validateDate(31, 4).isValid, isFalse); // Apr only has 30 days
      expect(validator.validateDate(30, 2).isValid, isFalse); // Feb only has max 29 days
      expect(validator.validateDate(32, 12).isValid, isFalse);
      expect(validator.validateDate(15, 13).isValid, isFalse);
      expect(validator.validateDate(0, 5).isValid, isFalse);
    });
  });
}

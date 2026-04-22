// Feature: questionnaire-and-polling
// Property 2: Quiz Answer Serialization Round-Trip
//
// For any valid QuizAnswer object, serializing to JSON and then deserializing
// SHALL produce an equivalent QuizAnswer object with the same questionId,
// selectedOptions, isCorrect flag, and submittedAt timestamp.
//
// Validates: Requirements 7.1

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/models/quiz_answer.dart';

// ---------------------------------------------------------------------------
// Generator
// ---------------------------------------------------------------------------

class QuizAnswerGenerator {
  final Random _random;

  QuizAnswerGenerator({int? seed}) : _random = Random(seed);

  /// Generates a random valid QuizAnswer.
  QuizAnswer generate() {
    final questionId = 'q_${_random.nextInt(100)}';
    final selectedOptions = [_random.nextInt(5)];
    final isCorrect = _random.nextBool();
    // Use microsecond-precision timestamps to test full fidelity
    final submittedAt = DateTime(
      2020 + _random.nextInt(5),
      1 + _random.nextInt(12),
      1 + _random.nextInt(28),
      _random.nextInt(24),
      _random.nextInt(60),
      _random.nextInt(60),
    );

    return QuizAnswer(
      questionId: questionId,
      selectedOptions: selectedOptions,
      isCorrect: isCorrect,
      submittedAt: submittedAt,
    );
  }

  /// Generates a QuizAnswer with multiple selected options (edge case).
  QuizAnswer generateMultiSelect() {
    final count = 2 + _random.nextInt(3); // 2-4 options
    final options = <int>{};
    while (options.length < count) {
      options.add(_random.nextInt(5));
    }

    return QuizAnswer(
      questionId: 'q_multi_${_random.nextInt(50)}',
      selectedOptions: options.toList(),
      isCorrect: _random.nextBool(),
      submittedAt: DateTime.now(),
    );
  }
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  const int iterations = 100;

  group('Property 2: Quiz Answer Serialization Round-Trip', () {
    final generator = QuizAnswerGenerator(seed: 42);

    test(
      'round-trip preserves all fields for $iterations random answers',
      () {
        for (int i = 0; i < iterations; i++) {
          final original = generator.generate();
          final json = original.toJson();
          final deserialized = QuizAnswer.fromJson(json);

          expect(
            deserialized.questionId,
            equals(original.questionId),
            reason: 'Iteration $i: questionId mismatch',
          );
          expect(
            deserialized.selectedOptions,
            equals(original.selectedOptions),
            reason: 'Iteration $i: selectedOptions mismatch',
          );
          expect(
            deserialized.isCorrect,
            equals(original.isCorrect),
            reason: 'Iteration $i: isCorrect mismatch',
          );
          expect(
            deserialized.submittedAt,
            equals(original.submittedAt),
            reason: 'Iteration $i: submittedAt mismatch',
          );
        }
      },
    );

    test(
      'round-trip produces equal objects (== operator) for $iterations answers',
      () {
        for (int i = 0; i < iterations; i++) {
          final original = generator.generate();
          final deserialized = QuizAnswer.fromJson(original.toJson());

          expect(
            deserialized,
            equals(original),
            reason: 'Iteration $i: deserialized object should equal original',
          );
        }
      },
    );

    test('round-trip preserves multi-select options', () {
      for (int i = 0; i < iterations; i++) {
        final original = generator.generateMultiSelect();
        final deserialized = QuizAnswer.fromJson(original.toJson());

        expect(
          deserialized.selectedOptions,
          equals(original.selectedOptions),
          reason: 'Iteration $i: multi-select options mismatch. '
              'Original: ${original.selectedOptions}, '
              'Deserialized: ${deserialized.selectedOptions}',
        );
      }
    });

    test('JSON map contains all required keys', () {
      final answer = generator.generate();
      final json = answer.toJson();

      expect(json.containsKey('questionId'), isTrue);
      expect(json.containsKey('selectedOptions'), isTrue);
      expect(json.containsKey('isCorrect'), isTrue);
      expect(json.containsKey('submittedAt'), isTrue);
    });

    test('submittedAt is serialized as ISO 8601 string', () {
      for (int i = 0; i < iterations; i++) {
        final original = generator.generate();
        final json = original.toJson();

        expect(
          json['submittedAt'],
          isA<String>(),
          reason: 'submittedAt should be serialized as a String',
        );

        // Verify it parses back to the same DateTime
        final parsed = DateTime.parse(json['submittedAt'] as String);
        expect(
          parsed,
          equals(original.submittedAt),
          reason: 'Iteration $i: parsed DateTime should equal original',
        );
      }
    });

    test('selectedOptions is serialized as a List', () {
      final answer = generator.generate();
      final json = answer.toJson();

      expect(json['selectedOptions'], isA<List>());
    });

    test('isCorrect is serialized as a bool', () {
      for (int i = 0; i < 10; i++) {
        final answer = generator.generate();
        final json = answer.toJson();
        expect(json['isCorrect'], isA<bool>());
      }
    });
  });
}

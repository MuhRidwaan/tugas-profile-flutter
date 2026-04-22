// Feature: questionnaire-and-polling
// Property 4: Answer Validation Correctness
//
// For any QuizQuestion with defined correct answers, validating a user's
// selected options SHALL return true if and only if the selected options
// exactly match the correct answer indices (order-independent for multiple
// choice).
//
// Validates: Requirements 1.2, 2.2

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/models/quiz_question.dart';
import 'package:profile_tugas/providers/quiz_provider.dart';
import 'package:profile_tugas/repositories/quiz_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ---------------------------------------------------------------------------
// Generator
// ---------------------------------------------------------------------------

class QuizValidationGenerator {
  final Random _random;

  QuizValidationGenerator({int? seed}) : _random = Random(seed);

  /// Generates a random single-choice question.
  QuizQuestion generateSingleChoice() {
    final correctIndex = _random.nextInt(5);
    return QuizQuestion(
      id: 'q_single_${_random.nextInt(1000)}',
      questionText: 'Single choice question?',
      type: QuestionType.single,
      options: const ['A', 'B', 'C', 'D', 'E'],
      correctAnswers: [correctIndex],
    );
  }

  /// Generates a random multiple-choice question with 2-4 correct answers.
  QuizQuestion generateMultipleChoice() {
    final correctCount = 2 + _random.nextInt(3); // 2-4 correct
    final correctSet = <int>{};
    while (correctSet.length < correctCount) {
      correctSet.add(_random.nextInt(5));
    }

    return QuizQuestion(
      id: 'q_multi_${_random.nextInt(1000)}',
      questionText: 'Multiple choice question?',
      type: QuestionType.multiple,
      options: const ['A', 'B', 'C', 'D', 'E'],
      correctAnswers: correctSet.toList(),
    );
  }

  /// Returns the correct answer for a question.
  List<int> correctAnswer(QuizQuestion question) {
    return List<int>.from(question.correctAnswers);
  }

  /// Returns a wrong answer (different from correct).
  List<int> wrongAnswer(QuizQuestion question) {
    final correct = question.correctAnswers.toSet();
    // Pick a single option that is NOT in the correct set
    for (int i = 0; i < 5; i++) {
      if (!correct.contains(i)) {
        return [i];
      }
    }
    // Fallback: all options are correct — return empty (invalid but safe)
    return [];
  }

  /// Returns the correct answer in a shuffled order (for order-independence).
  List<int> shuffledCorrectAnswer(QuizQuestion question) {
    final shuffled = List<int>.from(question.correctAnswers);
    shuffled.shuffle(_random);
    return shuffled;
  }
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  const int iterations = 100;

  late QuizProvider provider;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    provider = QuizProvider(QuizRepository(prefs));
  });

  group('Property 4: Answer Validation Correctness', () {
    final generator = QuizValidationGenerator(seed: 42);

    // -------------------------------------------------------------------------
    // Single-choice questions
    // -------------------------------------------------------------------------

    test(
      'correct single-choice answer returns true for $iterations questions',
      () {
        for (int i = 0; i < iterations; i++) {
          final question = generator.generateSingleChoice();
          final selected = generator.correctAnswer(question);

          expect(
            provider.validateAnswer(question, selected),
            isTrue,
            reason: 'Iteration $i: correct answer ${question.correctAnswers} '
                'should validate as true. Selected: $selected',
          );
        }
      },
    );

    test(
      'wrong single-choice answer returns false for $iterations questions',
      () {
        for (int i = 0; i < iterations; i++) {
          final question = generator.generateSingleChoice();
          final wrong = generator.wrongAnswer(question);

          if (wrong.isEmpty) continue; // skip degenerate case

          expect(
            provider.validateAnswer(question, wrong),
            isFalse,
            reason:
                'Iteration $i: wrong answer $wrong should validate as false. '
                'Correct: ${question.correctAnswers}',
          );
        }
      },
    );

    // -------------------------------------------------------------------------
    // Multiple-choice questions
    // -------------------------------------------------------------------------

    test(
      'correct multiple-choice answer returns true for $iterations questions',
      () {
        for (int i = 0; i < iterations; i++) {
          final question = generator.generateMultipleChoice();
          final selected = generator.correctAnswer(question);

          expect(
            provider.validateAnswer(question, selected),
            isTrue,
            reason: 'Iteration $i: correct answer ${question.correctAnswers} '
                'should validate as true. Selected: $selected',
          );
        }
      },
    );

    test(
      'shuffled correct answer returns true (order-independent) for $iterations questions',
      () {
        for (int i = 0; i < iterations; i++) {
          final question = generator.generateMultipleChoice();
          final shuffled = generator.shuffledCorrectAnswer(question);

          expect(
            provider.validateAnswer(question, shuffled),
            isTrue,
            reason: 'Iteration $i: shuffled correct answer $shuffled should '
                'validate as true. Correct: ${question.correctAnswers}',
          );
        }
      },
    );

    test(
      'partial answer (subset of correct) returns false for $iterations questions',
      () {
        for (int i = 0; i < iterations; i++) {
          final question = generator.generateMultipleChoice();
          // Take only the first correct answer (partial)
          final partial = [question.correctAnswers.first];

          // Only test when there are multiple correct answers
          if (question.correctAnswers.length > 1) {
            expect(
              provider.validateAnswer(question, partial),
              isFalse,
              reason:
                  'Iteration $i: partial answer $partial should validate as '
                  'false. Correct: ${question.correctAnswers}',
            );
          }
        }
      },
    );

    test(
      'wrong single option returns false for multiple-choice for $iterations questions',
      () {
        for (int i = 0; i < iterations; i++) {
          final question = generator.generateMultipleChoice();
          final wrong = generator.wrongAnswer(question);

          if (wrong.isEmpty) continue;

          expect(
            provider.validateAnswer(question, wrong),
            isFalse,
            reason:
                'Iteration $i: wrong answer $wrong should validate as false '
                'for multiple-choice. Correct: ${question.correctAnswers}',
          );
        }
      },
    );

    // -------------------------------------------------------------------------
    // Edge cases
    // -------------------------------------------------------------------------

    test('empty selected options always returns false', () {
      for (int i = 0; i < iterations; i++) {
        final question = i.isEven
            ? generator.generateSingleChoice()
            : generator.generateMultipleChoice();

        expect(
          provider.validateAnswer(question, []),
          isFalse,
          reason: 'Empty selection should always be false',
        );
      }
    });

    test('validation is deterministic: same inputs always produce same result',
        () {
      for (int i = 0; i < iterations; i++) {
        final question = generator.generateSingleChoice();
        final selected = generator.correctAnswer(question);

        final result1 = provider.validateAnswer(question, selected);
        final result2 = provider.validateAnswer(question, selected);

        expect(
          result1,
          equals(result2),
          reason: 'Iteration $i: validation should be deterministic',
        );
      }
    });
  });
}

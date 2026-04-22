import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/models/quiz_answer.dart';

void main() {
  group('QuizAnswer', () {
    group('validation', () {
      test('valid answer with single option passes', () {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: DateTime(2024, 1, 15, 10, 30),
        );

        expect(answer.isValid(), isTrue);
      });

      test('valid answer with multiple options passes', () {
        final answer = QuizAnswer(
          questionId: 'q2',
          selectedOptions: [1, 3],
          isCorrect: false,
          submittedAt: DateTime(2024, 1, 15, 10, 30),
        );

        expect(answer.isValid(), isTrue);
      });

      test('answer with empty question ID fails', () {
        final answer = QuizAnswer(
          questionId: '',
          selectedOptions: [0],
          isCorrect: true,
          submittedAt: DateTime(2024, 1, 15, 10, 30),
        );

        expect(answer.isValid(), isFalse);
      });

      test('answer with no selected options fails', () {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [],
          isCorrect: false,
          submittedAt: DateTime(2024, 1, 15, 10, 30),
        );

        expect(answer.isValid(), isFalse);
      });

      test('answer with invalid index (negative) fails', () {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [-1],
          isCorrect: false,
          submittedAt: DateTime(2024, 1, 15, 10, 30),
        );

        expect(answer.isValid(), isFalse);
      });

      test('answer with invalid index (>4) fails', () {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [5],
          isCorrect: false,
          submittedAt: DateTime(2024, 1, 15, 10, 30),
        );

        expect(answer.isValid(), isFalse);
      });

      test('answer with mixed valid and invalid indices fails', () {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2, 5],
          isCorrect: false,
          submittedAt: DateTime(2024, 1, 15, 10, 30),
        );

        expect(answer.isValid(), isFalse);
      });

      test('answer with all valid indices (0-4) passes', () {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [0, 1, 2, 3, 4],
          isCorrect: true,
          submittedAt: DateTime(2024, 1, 15, 10, 30),
        );

        expect(answer.isValid(), isTrue);
      });
    });

    group('JSON serialization', () {
      test('toJson converts answer to map correctly', () {
        final submittedAt = DateTime(2024, 1, 15, 10, 30);
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: submittedAt,
        );

        final json = answer.toJson();

        expect(json['questionId'], equals('q1'));
        expect(json['selectedOptions'], equals([2]));
        expect(json['isCorrect'], equals(true));
        expect(json['submittedAt'], equals(submittedAt.toIso8601String()));
      });

      test('fromJson creates answer from map correctly', () {
        final submittedAt = DateTime(2024, 1, 15, 10, 30);
        final json = {
          'questionId': 'q1',
          'selectedOptions': [2],
          'isCorrect': true,
          'submittedAt': submittedAt.toIso8601String(),
        };

        final answer = QuizAnswer.fromJson(json);

        expect(answer.questionId, equals('q1'));
        expect(answer.selectedOptions, equals([2]));
        expect(answer.isCorrect, equals(true));
        expect(answer.submittedAt, equals(submittedAt));
      });

      test('round-trip serialization preserves data', () {
        final original = QuizAnswer(
          questionId: 'q2',
          selectedOptions: [1, 3],
          isCorrect: false,
          submittedAt: DateTime(2024, 1, 15, 14, 45, 30),
        );

        final json = original.toJson();
        final deserialized = QuizAnswer.fromJson(json);

        expect(deserialized, equals(original));
      });

      test('fromJson handles multiple selected options', () {
        final submittedAt = DateTime(2024, 1, 15, 10, 30);
        final json = {
          'questionId': 'q3',
          'selectedOptions': [0, 2, 4],
          'isCorrect': true,
          'submittedAt': submittedAt.toIso8601String(),
        };

        final answer = QuizAnswer.fromJson(json);

        expect(answer.selectedOptions, equals([0, 2, 4]));
        expect(answer.isCorrect, equals(true));
      });

      test('fromJson handles incorrect answer', () {
        final submittedAt = DateTime(2024, 1, 15, 10, 30);
        final json = {
          'questionId': 'q4',
          'selectedOptions': [1],
          'isCorrect': false,
          'submittedAt': submittedAt.toIso8601String(),
        };

        final answer = QuizAnswer.fromJson(json);

        expect(answer.isCorrect, equals(false));
      });
    });

    group('equality', () {
      test('identical answers are equal', () {
        final submittedAt = DateTime(2024, 1, 15, 10, 30);
        final a1 = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: submittedAt,
        );

        final a2 = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: submittedAt,
        );

        expect(a1, equals(a2));
        expect(a1.hashCode, equals(a2.hashCode));
      });

      test('answers with different question IDs are not equal', () {
        final submittedAt = DateTime(2024, 1, 15, 10, 30);
        final a1 = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: submittedAt,
        );

        final a2 = QuizAnswer(
          questionId: 'q2',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: submittedAt,
        );

        expect(a1, isNot(equals(a2)));
      });

      test('answers with different selected options are not equal', () {
        final submittedAt = DateTime(2024, 1, 15, 10, 30);
        final a1 = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: submittedAt,
        );

        final a2 = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [3],
          isCorrect: true,
          submittedAt: submittedAt,
        );

        expect(a1, isNot(equals(a2)));
      });

      test('answers with different correctness are not equal', () {
        final submittedAt = DateTime(2024, 1, 15, 10, 30);
        final a1 = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: submittedAt,
        );

        final a2 = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: false,
          submittedAt: submittedAt,
        );

        expect(a1, isNot(equals(a2)));
      });

      test('answers with different timestamps are not equal', () {
        final a1 = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: DateTime(2024, 1, 15, 10, 30),
        );

        final a2 = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: DateTime(2024, 1, 15, 11, 30),
        );

        expect(a1, isNot(equals(a2)));
      });
    });

    group('toString', () {
      test('toString returns formatted string', () {
        final submittedAt = DateTime(2024, 1, 15, 10, 30);
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: submittedAt,
        );

        final str = answer.toString();

        expect(str, contains('QuizAnswer'));
        expect(str, contains('questionId: q1'));
        expect(str, contains('selectedOptions: [2]'));
        expect(str, contains('isCorrect: true'));
        expect(str, contains('submittedAt: $submittedAt'));
      });
    });
  });
}

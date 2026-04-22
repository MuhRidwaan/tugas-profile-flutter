import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/models/quiz_question.dart';

void main() {
  group('QuizQuestion', () {
    group('validation', () {
      test('valid single choice question with 5 options passes', () {
        final question = QuizQuestion(
          id: 'q1',
          questionText: 'What is 2+2?',
          type: QuestionType.single,
          options: ['2', '3', '4', '5', '6'],
          correctAnswers: [2],
        );

        expect(question.isValid(), isTrue);
      });

      test('valid multiple choice question with 5 options passes', () {
        final question = QuizQuestion(
          id: 'q2',
          questionText: 'Select even numbers',
          type: QuestionType.multiple,
          options: ['1', '2', '3', '4', '5'],
          correctAnswers: [1, 3],
        );

        expect(question.isValid(), isTrue);
      });

      test('question with 4 options fails', () {
        final question = QuizQuestion(
          id: 'q3',
          questionText: 'Test?',
          type: QuestionType.single,
          options: ['A', 'B', 'C', 'D'],
          correctAnswers: [0],
        );

        expect(question.isValid(), isFalse);
      });

      test('question with 6 options fails', () {
        final question = QuizQuestion(
          id: 'q4',
          questionText: 'Test?',
          type: QuestionType.single,
          options: ['A', 'B', 'C', 'D', 'E', 'F'],
          correctAnswers: [0],
        );

        expect(question.isValid(), isFalse);
      });

      test('question with no correct answers fails', () {
        final question = QuizQuestion(
          id: 'q5',
          questionText: 'Test?',
          type: QuestionType.single,
          options: ['A', 'B', 'C', 'D', 'E'],
          correctAnswers: [],
        );

        expect(question.isValid(), isFalse);
      });

      test('question with invalid index (negative) fails', () {
        final question = QuizQuestion(
          id: 'q6',
          questionText: 'Test?',
          type: QuestionType.single,
          options: ['A', 'B', 'C', 'D', 'E'],
          correctAnswers: [-1],
        );

        expect(question.isValid(), isFalse);
      });

      test('question with invalid index (>4) fails', () {
        final question = QuizQuestion(
          id: 'q7',
          questionText: 'Test?',
          type: QuestionType.single,
          options: ['A', 'B', 'C', 'D', 'E'],
          correctAnswers: [5],
        );

        expect(question.isValid(), isFalse);
      });

      test('single choice question with multiple correct answers fails', () {
        final question = QuizQuestion(
          id: 'q8',
          questionText: 'Test?',
          type: QuestionType.single,
          options: ['A', 'B', 'C', 'D', 'E'],
          correctAnswers: [0, 1],
        );

        expect(question.isValid(), isFalse);
      });

      test('multiple choice question with one correct answer passes', () {
        final question = QuizQuestion(
          id: 'q9',
          questionText: 'Test?',
          type: QuestionType.multiple,
          options: ['A', 'B', 'C', 'D', 'E'],
          correctAnswers: [0],
        );

        expect(question.isValid(), isTrue);
      });
    });

    group('JSON serialization', () {
      test('toJson converts question to map correctly', () {
        final question = QuizQuestion(
          id: 'q1',
          questionText: 'What is 2+2?',
          type: QuestionType.single,
          options: ['2', '3', '4', '5', '6'],
          correctAnswers: [2],
        );

        final json = question.toJson();

        expect(json['id'], equals('q1'));
        expect(json['questionText'], equals('What is 2+2?'));
        expect(json['type'], equals('single'));
        expect(json['options'], equals(['2', '3', '4', '5', '6']));
        expect(json['correctAnswers'], equals([2]));
      });

      test('fromJson creates question from map correctly', () {
        final json = {
          'id': 'q1',
          'questionText': 'What is 2+2?',
          'type': 'single',
          'options': ['2', '3', '4', '5', '6'],
          'correctAnswers': [2],
        };

        final question = QuizQuestion.fromJson(json);

        expect(question.id, equals('q1'));
        expect(question.questionText, equals('What is 2+2?'));
        expect(question.type, equals(QuestionType.single));
        expect(question.options, equals(['2', '3', '4', '5', '6']));
        expect(question.correctAnswers, equals([2]));
      });

      test('round-trip serialization preserves data', () {
        final original = QuizQuestion(
          id: 'q1',
          questionText: 'Select prime numbers',
          type: QuestionType.multiple,
          options: ['1', '2', '3', '4', '5'],
          correctAnswers: [1, 2, 4],
        );

        final json = original.toJson();
        final deserialized = QuizQuestion.fromJson(json);

        expect(deserialized, equals(original));
      });

      test('fromJson handles multiple choice type', () {
        final json = {
          'id': 'q2',
          'questionText': 'Test?',
          'type': 'multiple',
          'options': ['A', 'B', 'C', 'D', 'E'],
          'correctAnswers': [0, 2, 4],
        };

        final question = QuizQuestion.fromJson(json);

        expect(question.type, equals(QuestionType.multiple));
        expect(question.correctAnswers, equals([0, 2, 4]));
      });
    });

    group('equality', () {
      test('identical questions are equal', () {
        final q1 = QuizQuestion(
          id: 'q1',
          questionText: 'Test?',
          type: QuestionType.single,
          options: ['A', 'B', 'C', 'D', 'E'],
          correctAnswers: [0],
        );

        final q2 = QuizQuestion(
          id: 'q1',
          questionText: 'Test?',
          type: QuestionType.single,
          options: ['A', 'B', 'C', 'D', 'E'],
          correctAnswers: [0],
        );

        expect(q1, equals(q2));
        expect(q1.hashCode, equals(q2.hashCode));
      });

      test('different questions are not equal', () {
        final q1 = QuizQuestion(
          id: 'q1',
          questionText: 'Test?',
          type: QuestionType.single,
          options: ['A', 'B', 'C', 'D', 'E'],
          correctAnswers: [0],
        );

        final q2 = QuizQuestion(
          id: 'q2',
          questionText: 'Test?',
          type: QuestionType.single,
          options: ['A', 'B', 'C', 'D', 'E'],
          correctAnswers: [0],
        );

        expect(q1, isNot(equals(q2)));
      });
    });
  });
}

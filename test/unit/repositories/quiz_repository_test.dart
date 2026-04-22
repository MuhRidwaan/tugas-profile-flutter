import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/models/quiz_answer.dart';
import 'package:profile_tugas/models/quiz_question.dart';
import 'package:profile_tugas/repositories/quiz_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('QuizRepository', () {
    late QuizRepository repository;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      repository = QuizRepository(prefs);
    });

    group('getQuestions', () {
      test('returns 5 hardcoded questions', () async {
        final questions = await repository.getQuestions();

        expect(questions.length, equals(5));
      });

      test('all questions have exactly 5 options', () async {
        final questions = await repository.getQuestions();

        for (final q in questions) {
          expect(q.options.length, equals(5),
              reason: 'Question ${q.id} should have 5 options');
        }
      });

      test('all questions pass validation', () async {
        final questions = await repository.getQuestions();

        for (final q in questions) {
          expect(q.isValid(), isTrue,
              reason: 'Question ${q.id} should be valid');
        }
      });

      test('questions have unique IDs', () async {
        final questions = await repository.getQuestions();
        final ids = questions.map((q) => q.id).toSet();

        expect(ids.length, equals(questions.length));
      });

      test('contains both single and multiple choice questions', () async {
        final questions = await repository.getQuestions();
        final types = questions.map((q) => q.type).toSet();

        expect(types.contains(QuestionType.single), isTrue);
        expect(types.contains(QuestionType.multiple), isTrue);
      });
    });

    group('saveAnswer and getAnswer', () {
      test('saves and retrieves an answer', () async {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: DateTime(2024, 1, 15, 10, 30),
        );

        await repository.saveAnswer(answer);
        final retrieved = await repository.getAnswer('q1');

        expect(retrieved, equals(answer));
      });

      test('returns null for non-existent answer', () async {
        final result = await repository.getAnswer('nonexistent');

        expect(result, isNull);
      });

      test('overwrites existing answer for same question', () async {
        final first = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [0],
          isCorrect: false,
          submittedAt: DateTime(2024, 1, 15, 10, 0),
        );
        final second = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: DateTime(2024, 1, 15, 10, 30),
        );

        await repository.saveAnswer(first);
        await repository.saveAnswer(second);
        final retrieved = await repository.getAnswer('q1');

        expect(retrieved, equals(second));
      });
    });

    group('getAllAnswers', () {
      test('returns empty list when no answers saved', () async {
        final answers = await repository.getAllAnswers();

        expect(answers, isEmpty);
      });

      test('returns all saved answers', () async {
        final a1 = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [1],
          isCorrect: true,
          submittedAt: DateTime(2024, 1, 15, 10, 0),
        );
        final a2 = QuizAnswer(
          questionId: 'q2',
          selectedOptions: [3],
          isCorrect: false,
          submittedAt: DateTime(2024, 1, 15, 11, 0),
        );

        await repository.saveAnswer(a1);
        await repository.saveAnswer(a2);

        final answers = await repository.getAllAnswers();

        expect(answers.length, equals(2));
        expect(answers.any((a) => a.questionId == 'q1'), isTrue);
        expect(answers.any((a) => a.questionId == 'q2'), isTrue);
      });

      test('persists across repository instances', () async {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: DateTime(2024, 1, 15, 10, 30),
        );

        await repository.saveAnswer(answer);

        // Create new repository instance with same prefs
        final prefs = await SharedPreferences.getInstance();
        final newRepo = QuizRepository(prefs);
        final answers = await newRepo.getAllAnswers();

        expect(answers.length, equals(1));
        expect(answers.first, equals(answer));
      });
    });
  });
}

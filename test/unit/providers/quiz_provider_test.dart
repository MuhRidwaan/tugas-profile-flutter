import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/models/quiz_question.dart';
import 'package:profile_tugas/providers/quiz_provider.dart';
import 'package:profile_tugas/repositories/quiz_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('QuizProvider', () {
    late QuizProvider provider;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      provider = QuizProvider(QuizRepository(prefs));
    });

    group('initial state', () {
      test('starts with empty questions', () {
        expect(provider.questions, isEmpty);
      });

      test('starts with empty answers', () {
        expect(provider.answers, isEmpty);
      });

      test('starts not loading', () {
        expect(provider.isLoading, isFalse);
      });

      test('starts with no error', () {
        expect(provider.errorMessage, isNull);
      });
    });

    group('loadQuestions', () {
      test('loads 5 questions', () async {
        await provider.loadQuestions();

        expect(provider.questions.length, equals(5));
      });

      test('sets isLoading to false after loading', () async {
        await provider.loadQuestions();

        expect(provider.isLoading, isFalse);
      });

      test('notifies listeners when loading completes', () async {
        int notifyCount = 0;
        provider.addListener(() => notifyCount++);

        await provider.loadQuestions();

        expect(notifyCount, greaterThan(0));
      });
    });

    group('submitAnswer', () {
      setUp(() async {
        await provider.loadQuestions();
      });

      test('records answer for a question', () async {
        final question = provider.questions.first;
        final correctAnswer = question.correctAnswers;

        await provider.submitAnswer(question.id, correctAnswer);

        expect(provider.isQuestionAnswered(question.id), isTrue);
      });

      test('validates correct answer as correct', () async {
        final question =
            provider.questions.firstWhere((q) => q.type == QuestionType.single);
        final correctAnswer = question.correctAnswers;

        await provider.submitAnswer(question.id, correctAnswer);

        final answer = provider.getAnswer(question.id);
        expect(answer?.isCorrect, isTrue);
      });

      test('validates wrong answer as incorrect', () async {
        final question =
            provider.questions.firstWhere((q) => q.type == QuestionType.single);
        // Find a wrong answer
        final wrongIndex = question.correctAnswers.first == 0 ? 1 : 0;

        await provider.submitAnswer(question.id, [wrongIndex]);

        final answer = provider.getAnswer(question.id);
        expect(answer?.isCorrect, isFalse);
      });

      test('ignores re-answer attempt', () async {
        final question = provider.questions.first;
        final firstAnswer = question.correctAnswers;
        final secondAnswer = [firstAnswer.first == 0 ? 1 : 0];

        await provider.submitAnswer(question.id, firstAnswer);
        await provider.submitAnswer(question.id, secondAnswer);

        final answer = provider.getAnswer(question.id);
        expect(answer?.selectedOptions, equals(firstAnswer));
      });

      test('notifies listeners after submission', () async {
        int notifyCount = 0;
        provider.addListener(() => notifyCount++);

        final question = provider.questions.first;
        await provider.submitAnswer(question.id, question.correctAnswers);

        expect(notifyCount, greaterThan(0));
      });
    });

    group('validateAnswer', () {
      test('returns true for correct single-choice answer', () {
        final question = QuizQuestion(
          id: 'q_test',
          questionText: 'Test?',
          type: QuestionType.single,
          options: ['A', 'B', 'C', 'D', 'E'],
          correctAnswers: [2],
        );

        expect(provider.validateAnswer(question, [2]), isTrue);
      });

      test('returns false for wrong single-choice answer', () {
        final question = QuizQuestion(
          id: 'q_test',
          questionText: 'Test?',
          type: QuestionType.single,
          options: ['A', 'B', 'C', 'D', 'E'],
          correctAnswers: [2],
        );

        expect(provider.validateAnswer(question, [0]), isFalse);
      });

      test('returns true for correct multiple-choice answer', () {
        final question = QuizQuestion(
          id: 'q_test',
          questionText: 'Test?',
          type: QuestionType.multiple,
          options: ['A', 'B', 'C', 'D', 'E'],
          correctAnswers: [0, 2, 4],
        );

        expect(provider.validateAnswer(question, [0, 2, 4]), isTrue);
      });

      test('returns true for shuffled correct multiple-choice answer', () {
        final question = QuizQuestion(
          id: 'q_test',
          questionText: 'Test?',
          type: QuestionType.multiple,
          options: ['A', 'B', 'C', 'D', 'E'],
          correctAnswers: [0, 2, 4],
        );

        expect(provider.validateAnswer(question, [4, 0, 2]), isTrue);
      });

      test('returns false for partial multiple-choice answer', () {
        final question = QuizQuestion(
          id: 'q_test',
          questionText: 'Test?',
          type: QuestionType.multiple,
          options: ['A', 'B', 'C', 'D', 'E'],
          correctAnswers: [0, 2, 4],
        );

        expect(provider.validateAnswer(question, [0]), isFalse);
      });

      test('returns false for empty selection', () {
        final question = QuizQuestion(
          id: 'q_test',
          questionText: 'Test?',
          type: QuestionType.single,
          options: ['A', 'B', 'C', 'D', 'E'],
          correctAnswers: [2],
        );

        expect(provider.validateAnswer(question, []), isFalse);
      });
    });

    group('isQuestionAnswered', () {
      test('returns false for unanswered question', () {
        expect(provider.isQuestionAnswered('q1'), isFalse);
      });

      test('returns true after answering', () async {
        await provider.loadQuestions();
        final question = provider.questions.first;

        await provider.submitAnswer(question.id, question.correctAnswers);

        expect(provider.isQuestionAnswered(question.id), isTrue);
      });
    });

    group('getAnswer', () {
      test('returns null for unanswered question', () {
        expect(provider.getAnswer('q1'), isNull);
      });

      test('returns answer after submission', () async {
        await provider.loadQuestions();
        final question = provider.questions.first;

        await provider.submitAnswer(question.id, question.correctAnswers);

        final answer = provider.getAnswer(question.id);
        expect(answer, isNotNull);
        expect(answer!.questionId, equals(question.id));
      });
    });
  });
}

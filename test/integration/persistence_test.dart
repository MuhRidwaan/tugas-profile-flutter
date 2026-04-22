// Integration test: Data Persistence
// Tests that quiz answers and poll votes survive provider/app restarts.
// Requirements: 7.1, 7.2, 7.3, 7.4

import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/providers/poll_provider.dart';
import 'package:profile_tugas/providers/quiz_provider.dart';
import 'package:profile_tugas/repositories/poll_repository.dart';
import 'package:profile_tugas/repositories/quiz_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Data Persistence Integration', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    group('Quiz answer persistence', () {
      test('answered question persists across QuizProvider instances',
          () async {
        // Session 1: load and answer a question
        final provider1 = QuizProvider(QuizRepository(prefs));
        await provider1.loadQuestions();

        final question = provider1.questions.first;
        await provider1.submitAnswer(question.id, question.correctAnswers);

        expect(provider1.isQuestionAnswered(question.id), isTrue);

        // Session 2: new provider with same prefs
        final provider2 = QuizProvider(QuizRepository(prefs));
        await provider2.loadQuestions();

        expect(provider2.isQuestionAnswered(question.id), isTrue);
      });

      test('answer correctness persists', () async {
        final provider1 = QuizProvider(QuizRepository(prefs));
        await provider1.loadQuestions();

        final question = provider1.questions.first;
        await provider1.submitAnswer(question.id, question.correctAnswers);

        final answer1 = provider1.getAnswer(question.id);
        expect(answer1?.isCorrect, isTrue);

        // New provider
        final provider2 = QuizProvider(QuizRepository(prefs));
        await provider2.loadQuestions();

        final answer2 = provider2.getAnswer(question.id);
        expect(answer2?.isCorrect, isTrue);
        expect(answer2?.selectedOptions, equals(answer1?.selectedOptions));
      });

      test('multiple answers persist across instances', () async {
        final provider1 = QuizProvider(QuizRepository(prefs));
        await provider1.loadQuestions();

        // Answer first 3 questions
        for (int i = 0; i < 3; i++) {
          final q = provider1.questions[i];
          await provider1.submitAnswer(q.id, q.correctAnswers);
        }

        // New provider
        final provider2 = QuizProvider(QuizRepository(prefs));
        await provider2.loadQuestions();

        for (int i = 0; i < 3; i++) {
          final q = provider2.questions[i];
          expect(provider2.isQuestionAnswered(q.id), isTrue,
              reason: 'Question ${q.id} should be answered after reload');
        }

        // 4th and 5th should not be answered
        expect(
            provider2.isQuestionAnswered(provider2.questions[3].id), isFalse);
        expect(
            provider2.isQuestionAnswered(provider2.questions[4].id), isFalse);
      });

      test('cannot re-answer after reload', () async {
        final provider1 = QuizProvider(QuizRepository(prefs));
        await provider1.loadQuestions();

        final question = provider1.questions.first;
        final wrongIndex = question.correctAnswers.first == 0 ? 1 : 0;
        await provider1.submitAnswer(question.id, question.correctAnswers);

        // New provider
        final provider2 = QuizProvider(QuizRepository(prefs));
        await provider2.loadQuestions();

        // Try to re-answer with wrong answer
        await provider2.submitAnswer(question.id, [wrongIndex]);

        // Should still have original correct answer
        final answer = provider2.getAnswer(question.id);
        expect(answer?.selectedOptions, equals(question.correctAnswers));
      });
    });

    group('Poll vote persistence', () {
      test('vote persists across PollProvider instances', () async {
        final provider1 = PollProvider(PollRepository(prefs));
        await provider1.loadPoll();
        await provider1.submitVote(2);

        expect(provider1.hasVoted(), isTrue);
        expect(provider1.userVote?.selectedOption, equals(2));

        // New provider
        final provider2 = PollProvider(PollRepository(prefs));
        await provider2.loadPoll();

        expect(provider2.hasVoted(), isTrue);
        expect(provider2.userVote?.selectedOption, equals(2));
      });

      test('vote distribution persists across instances', () async {
        final provider1 = PollProvider(PollRepository(prefs));
        await provider1.loadPoll();
        await provider1.submitVote(0);

        expect(provider1.voteDistribution.totalVotes, equals(1));

        // New provider
        final provider2 = PollProvider(PollRepository(prefs));
        await provider2.loadPoll();

        expect(provider2.voteDistribution.totalVotes, equals(1));
        expect(provider2.voteDistribution.getCount(0), equals(1));
      });

      test('cannot vote twice after reload', () async {
        final provider1 = PollProvider(PollRepository(prefs));
        await provider1.loadPoll();
        await provider1.submitVote(1);

        // New provider
        final provider2 = PollProvider(PollRepository(prefs));
        await provider2.loadPoll();

        // Try to vote again
        await provider2.submitVote(3);

        // Should still have original vote
        expect(provider2.userVote?.selectedOption, equals(1));
        expect(provider2.voteDistribution.totalVotes, equals(1));
      });

      test('all valid option indices persist correctly', () async {
        for (int optionIndex = 0; optionIndex < 5; optionIndex++) {
          SharedPreferences.setMockInitialValues({});
          final freshPrefs = await SharedPreferences.getInstance();

          final provider1 = PollProvider(PollRepository(freshPrefs));
          await provider1.loadPoll();
          await provider1.submitVote(optionIndex);

          final provider2 = PollProvider(PollRepository(freshPrefs));
          await provider2.loadPoll();

          expect(
            provider2.userVote?.selectedOption,
            equals(optionIndex),
            reason: 'Option $optionIndex should persist',
          );
        }
      });
    });
  });
}

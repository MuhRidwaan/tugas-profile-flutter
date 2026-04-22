import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/providers/poll_provider.dart';
import 'package:profile_tugas/repositories/poll_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('PollProvider', () {
    late PollProvider provider;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      provider = PollProvider(PollRepository(prefs));
    });

    group('initial state', () {
      test('starts with no poll', () {
        expect(provider.currentPoll, isNull);
      });

      test('starts with no vote', () {
        expect(provider.userVote, isNull);
      });

      test('starts not loading', () {
        expect(provider.isLoading, isFalse);
      });

      test('starts with no error', () {
        expect(provider.errorMessage, isNull);
      });

      test('hasVoted returns false initially', () {
        expect(provider.hasVoted(), isFalse);
      });
    });

    group('loadPoll', () {
      test('loads the default poll', () async {
        await provider.loadPoll();

        expect(provider.currentPoll, isNotNull);
        expect(provider.currentPoll!.options.length, equals(5));
      });

      test('sets isLoading to false after loading', () async {
        await provider.loadPoll();

        expect(provider.isLoading, isFalse);
      });

      test('notifies listeners when loading completes', () async {
        int notifyCount = 0;
        provider.addListener(() => notifyCount++);

        await provider.loadPoll();

        expect(notifyCount, greaterThan(0));
      });

      test('initializes empty vote distribution', () async {
        await provider.loadPoll();

        expect(provider.voteDistribution.totalVotes, equals(0));
      });
    });

    group('submitVote', () {
      setUp(() async {
        await provider.loadPoll();
      });

      test('records user vote', () async {
        await provider.submitVote(2);

        expect(provider.hasVoted(), isTrue);
        expect(provider.userVote?.selectedOption, equals(2));
      });

      test('updates vote distribution', () async {
        await provider.submitVote(1);

        expect(provider.voteDistribution.getCount(1), equals(1));
        expect(provider.voteDistribution.totalVotes, equals(1));
      });

      test('ignores duplicate vote', () async {
        await provider.submitVote(0);
        await provider.submitVote(3);

        expect(provider.userVote?.selectedOption, equals(0));
        expect(provider.voteDistribution.totalVotes, equals(1));
      });

      test('notifies listeners after voting', () async {
        int notifyCount = 0;
        provider.addListener(() => notifyCount++);

        await provider.submitVote(2);

        expect(notifyCount, greaterThan(0));
      });

      test('vote percentage is 100% for single voter', () async {
        await provider.submitVote(3);

        expect(provider.getPercentage(3), equals(100.0));
        expect(provider.getPercentage(0), equals(0.0));
      });
    });

    group('getPercentage and getVoteCount', () {
      setUp(() async {
        await provider.loadPoll();
      });

      test('returns 0% before any votes', () {
        for (int i = 0; i < 5; i++) {
          expect(provider.getPercentage(i), equals(0.0));
        }
      });

      test('returns 0 count before any votes', () {
        for (int i = 0; i < 5; i++) {
          expect(provider.getVoteCount(i), equals(0));
        }
      });

      test('returns correct count after voting', () async {
        await provider.submitVote(4);

        expect(provider.getVoteCount(4), equals(1));
        expect(provider.getVoteCount(0), equals(0));
      });
    });

    group('hasVoted', () {
      test('returns false before voting', () async {
        await provider.loadPoll();

        expect(provider.hasVoted(), isFalse);
      });

      test('returns true after voting', () async {
        await provider.loadPoll();
        await provider.submitVote(0);

        expect(provider.hasVoted(), isTrue);
      });
    });
  });
}

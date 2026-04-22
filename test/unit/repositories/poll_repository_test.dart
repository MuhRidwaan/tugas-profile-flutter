import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/models/poll_vote.dart';
import 'package:profile_tugas/repositories/poll_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('PollRepository', () {
    late PollRepository repository;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      repository = PollRepository(prefs);
    });

    group('getPoll', () {
      test('returns default poll', () async {
        final poll = await repository.getPoll();

        expect(poll.id, equals('sports_poll_1'));
        expect(poll.options.length, equals(5));
        expect(poll.isValid(), isTrue);
      });

      test('poll contains all required sports', () async {
        final poll = await repository.getPoll();

        expect(poll.options.contains('Badminton'), isTrue);
        expect(poll.options.contains('Catur'), isTrue);
        expect(poll.options.contains('Padel'), isTrue);
        expect(poll.options.contains('Basket'), isTrue);
        expect(poll.options.contains('Lari Marathon'), isTrue);
      });
    });

    group('saveVote and getUserVote', () {
      test('saves and retrieves a vote', () async {
        final vote = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 2,
          votedAt: DateTime(2024, 1, 15, 10, 30),
        );

        await repository.saveVote(vote);
        final retrieved = await repository.getUserVote();

        expect(retrieved, equals(vote));
      });

      test('returns null when no vote saved', () async {
        final result = await repository.getUserVote();

        expect(result, isNull);
      });

      test('overwrites previous vote', () async {
        final first = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 0,
          votedAt: DateTime(2024, 1, 15, 10, 0),
        );
        final second = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 3,
          votedAt: DateTime(2024, 1, 15, 11, 0),
        );

        await repository.saveVote(first);
        await repository.saveVote(second);
        final retrieved = await repository.getUserVote();

        expect(retrieved, equals(second));
      });

      test('persists across repository instances', () async {
        final vote = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 1,
          votedAt: DateTime(2024, 1, 15, 10, 30),
        );

        await repository.saveVote(vote);

        final prefs = await SharedPreferences.getInstance();
        final newRepo = PollRepository(prefs);
        final retrieved = await newRepo.getUserVote();

        expect(retrieved, equals(vote));
      });
    });

    group('getVoteDistribution and updateVoteDistribution', () {
      test('returns empty distribution when no votes', () async {
        final distribution = await repository.getVoteDistribution();

        expect(distribution.totalVotes, equals(0));
      });

      test('updates vote distribution correctly', () async {
        await repository.updateVoteDistribution(2);
        final distribution = await repository.getVoteDistribution();

        expect(distribution.getCount(2), equals(1));
        expect(distribution.totalVotes, equals(1));
      });

      test('accumulates multiple votes for same option', () async {
        await repository.updateVoteDistribution(0);
        await repository.updateVoteDistribution(0);
        await repository.updateVoteDistribution(0);

        final distribution = await repository.getVoteDistribution();

        expect(distribution.getCount(0), equals(3));
        expect(distribution.totalVotes, equals(3));
      });

      test('tracks votes across different options', () async {
        await repository.updateVoteDistribution(0);
        await repository.updateVoteDistribution(1);
        await repository.updateVoteDistribution(2);

        final distribution = await repository.getVoteDistribution();

        expect(distribution.getCount(0), equals(1));
        expect(distribution.getCount(1), equals(1));
        expect(distribution.getCount(2), equals(1));
        expect(distribution.totalVotes, equals(3));
      });

      test('persists distribution across instances', () async {
        await repository.updateVoteDistribution(4);

        final prefs = await SharedPreferences.getInstance();
        final newRepo = PollRepository(prefs);
        final distribution = await newRepo.getVoteDistribution();

        expect(distribution.getCount(4), equals(1));
      });
    });
  });
}

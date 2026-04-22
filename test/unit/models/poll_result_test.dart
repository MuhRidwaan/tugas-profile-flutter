import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/models/poll_result.dart';

void main() {
  group('PollResult', () {
    group('getPercentage', () {
      test('returns correct percentage for each option', () {
        final result = PollResult(
          voteCounts: {0: 25, 1: 25, 2: 25, 3: 25, 4: 0},
          totalVotes: 100,
        );

        expect(result.getPercentage(0), equals(25.0));
        expect(result.getPercentage(1), equals(25.0));
        expect(result.getPercentage(4), equals(0.0));
      });

      test('returns 0.0 when totalVotes is zero', () {
        final result = PollResult(voteCounts: {}, totalVotes: 0);

        for (int i = 0; i < 5; i++) {
          expect(result.getPercentage(i), equals(0.0));
        }
      });

      test('returns 100.0 when one option has all votes', () {
        final result = PollResult(
          voteCounts: {0: 50, 1: 0, 2: 0, 3: 0, 4: 0},
          totalVotes: 50,
        );

        expect(result.getPercentage(0), equals(100.0));
        expect(result.getPercentage(1), equals(0.0));
      });

      test('returns 0.0 for option not in voteCounts', () {
        final result = PollResult(
          voteCounts: {0: 10},
          totalVotes: 10,
        );

        expect(result.getPercentage(3), equals(0.0));
      });
    });

    group('getCount', () {
      test('returns correct count for each option', () {
        final result = PollResult(
          voteCounts: {0: 10, 1: 20, 2: 30, 3: 40, 4: 0},
          totalVotes: 100,
        );

        expect(result.getCount(0), equals(10));
        expect(result.getCount(1), equals(20));
        expect(result.getCount(4), equals(0));
      });

      test('returns 0 for option not in voteCounts', () {
        final result = PollResult(voteCounts: {0: 5}, totalVotes: 5);

        expect(result.getCount(3), equals(0));
      });
    });

    group('validation', () {
      test('valid result passes', () {
        final result = PollResult(
          voteCounts: {0: 10, 1: 20, 2: 30, 3: 40, 4: 0},
          totalVotes: 100,
        );

        expect(result.isValid(), isTrue);
      });

      test('empty result passes', () {
        final result = PollResult(voteCounts: {}, totalVotes: 0);

        expect(result.isValid(), isTrue);
      });

      test('invalid index fails', () {
        final result = PollResult(
          voteCounts: {5: 10},
          totalVotes: 10,
        );

        expect(result.isValid(), isFalse);
      });

      test('negative count fails', () {
        final result = PollResult(
          voteCounts: {0: -1},
          totalVotes: -1,
        );

        expect(result.isValid(), isFalse);
      });

      test('mismatched totalVotes fails', () {
        final result = PollResult(
          voteCounts: {0: 10, 1: 20},
          totalVotes: 999,
        );

        expect(result.isValid(), isFalse);
      });
    });

    group('factories', () {
      test('empty() creates zero-vote result', () {
        final result = PollResult.empty();

        expect(result.totalVotes, equals(0));
        for (int i = 0; i < 5; i++) {
          expect(result.getCount(i), equals(0));
          expect(result.getPercentage(i), equals(0.0));
        }
      });

      test('fromDistribution() computes totalVotes correctly', () {
        final result = PollResult.fromDistribution({0: 10, 1: 20, 2: 30});

        expect(result.totalVotes, equals(60));
        expect(result.getCount(0), equals(10));
        expect(result.getCount(1), equals(20));
        expect(result.getCount(2), equals(30));
      });
    });

    group('JSON serialization', () {
      test('round-trip preserves data', () {
        final original = PollResult(
          voteCounts: {0: 10, 1: 20, 2: 30, 3: 40, 4: 0},
          totalVotes: 100,
        );

        final json = original.toJson();
        final deserialized = PollResult.fromJson(json);

        expect(deserialized, equals(original));
      });

      test('empty result round-trips correctly', () {
        final original = PollResult.empty();
        final deserialized = PollResult.fromJson(original.toJson());

        expect(deserialized.totalVotes, equals(0));
      });
    });
  });
}

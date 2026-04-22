import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/models/poll_vote.dart';

void main() {
  group('PollVote', () {
    group('validation', () {
      test('valid vote with option 0 passes', () {
        final vote = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 0,
          votedAt: DateTime(2024, 1, 15, 10, 30),
        );

        expect(vote.isValid(), isTrue);
      });

      test('valid vote with option 4 passes', () {
        final vote = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 4,
          votedAt: DateTime(2024, 1, 15, 10, 30),
        );

        expect(vote.isValid(), isTrue);
      });

      test('valid vote with middle option passes', () {
        final vote = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 2,
          votedAt: DateTime(2024, 1, 15, 10, 30),
        );

        expect(vote.isValid(), isTrue);
      });

      test('vote with empty poll ID fails', () {
        final vote = PollVote(
          pollId: '',
          selectedOption: 0,
          votedAt: DateTime(2024, 1, 15, 10, 30),
        );

        expect(vote.isValid(), isFalse);
      });

      test('vote with negative option index fails', () {
        final vote = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: -1,
          votedAt: DateTime(2024, 1, 15, 10, 30),
        );

        expect(vote.isValid(), isFalse);
      });

      test('vote with option index 5 fails', () {
        final vote = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 5,
          votedAt: DateTime(2024, 1, 15, 10, 30),
        );

        expect(vote.isValid(), isFalse);
      });

      test('vote with option index greater than 5 fails', () {
        final vote = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 10,
          votedAt: DateTime(2024, 1, 15, 10, 30),
        );

        expect(vote.isValid(), isFalse);
      });
    });

    group('JSON serialization', () {
      test('toJson converts vote to map correctly', () {
        final votedAt = DateTime(2024, 1, 15, 10, 30);
        final vote = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 2,
          votedAt: votedAt,
        );

        final json = vote.toJson();

        expect(json['pollId'], equals('sports_poll_1'));
        expect(json['selectedOption'], equals(2));
        expect(json['votedAt'], equals(votedAt.toIso8601String()));
      });

      test('fromJson creates vote from map correctly', () {
        final votedAt = DateTime(2024, 1, 15, 10, 30);
        final json = {
          'pollId': 'sports_poll_1',
          'selectedOption': 2,
          'votedAt': votedAt.toIso8601String(),
        };

        final vote = PollVote.fromJson(json);

        expect(vote.pollId, equals('sports_poll_1'));
        expect(vote.selectedOption, equals(2));
        expect(vote.votedAt, equals(votedAt));
      });

      test('round-trip serialization preserves data', () {
        final original = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 3,
          votedAt: DateTime(2024, 1, 15, 14, 45, 30),
        );

        final json = original.toJson();
        final deserialized = PollVote.fromJson(json);

        expect(deserialized, equals(original));
      });

      test('fromJson handles option 0', () {
        final votedAt = DateTime(2024, 1, 15, 10, 30);
        final json = {
          'pollId': 'sports_poll_1',
          'selectedOption': 0,
          'votedAt': votedAt.toIso8601String(),
        };

        final vote = PollVote.fromJson(json);

        expect(vote.selectedOption, equals(0));
      });

      test('fromJson handles option 4', () {
        final votedAt = DateTime(2024, 1, 15, 10, 30);
        final json = {
          'pollId': 'sports_poll_1',
          'selectedOption': 4,
          'votedAt': votedAt.toIso8601String(),
        };

        final vote = PollVote.fromJson(json);

        expect(vote.selectedOption, equals(4));
      });

      test('fromJson handles different poll IDs', () {
        final votedAt = DateTime(2024, 1, 15, 10, 30);
        final json = {
          'pollId': 'custom_poll_123',
          'selectedOption': 1,
          'votedAt': votedAt.toIso8601String(),
        };

        final vote = PollVote.fromJson(json);

        expect(vote.pollId, equals('custom_poll_123'));
      });
    });

    group('equality', () {
      test('identical votes are equal', () {
        final votedAt = DateTime(2024, 1, 15, 10, 30);
        final v1 = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 2,
          votedAt: votedAt,
        );

        final v2 = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 2,
          votedAt: votedAt,
        );

        expect(v1, equals(v2));
        expect(v1.hashCode, equals(v2.hashCode));
      });

      test('votes with different poll IDs are not equal', () {
        final votedAt = DateTime(2024, 1, 15, 10, 30);
        final v1 = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 2,
          votedAt: votedAt,
        );

        final v2 = PollVote(
          pollId: 'sports_poll_2',
          selectedOption: 2,
          votedAt: votedAt,
        );

        expect(v1, isNot(equals(v2)));
      });

      test('votes with different selected options are not equal', () {
        final votedAt = DateTime(2024, 1, 15, 10, 30);
        final v1 = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 2,
          votedAt: votedAt,
        );

        final v2 = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 3,
          votedAt: votedAt,
        );

        expect(v1, isNot(equals(v2)));
      });

      test('votes with different timestamps are not equal', () {
        final v1 = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 2,
          votedAt: DateTime(2024, 1, 15, 10, 30),
        );

        final v2 = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 2,
          votedAt: DateTime(2024, 1, 15, 11, 30),
        );

        expect(v1, isNot(equals(v2)));
      });

      test('same instance is equal to itself', () {
        final vote = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 2,
          votedAt: DateTime(2024, 1, 15, 10, 30),
        );

        expect(vote, equals(vote));
      });
    });

    group('toString', () {
      test('toString returns formatted string', () {
        final votedAt = DateTime(2024, 1, 15, 10, 30);
        final vote = PollVote(
          pollId: 'sports_poll_1',
          selectedOption: 2,
          votedAt: votedAt,
        );

        final str = vote.toString();

        expect(str, contains('PollVote'));
        expect(str, contains('pollId: sports_poll_1'));
        expect(str, contains('selectedOption: 2'));
        expect(str, contains('votedAt: $votedAt'));
      });

      test('toString handles all valid options', () {
        final votedAt = DateTime(2024, 1, 15, 10, 30);

        for (int i = 0; i < 5; i++) {
          final vote = PollVote(
            pollId: 'sports_poll_1',
            selectedOption: i,
            votedAt: votedAt,
          );

          final str = vote.toString();
          expect(str, contains('selectedOption: $i'));
        }
      });
    });
  });
}

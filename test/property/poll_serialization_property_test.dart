// Feature: questionnaire-and-polling
// Property 3: Poll Vote Serialization Round-Trip
//
// For any valid PollVote object, serializing to JSON and then deserializing
// SHALL produce an equivalent PollVote object with the same pollId,
// selectedOption, and votedAt timestamp.
//
// Validates: Requirements 7.2

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/models/poll_vote.dart';

// ---------------------------------------------------------------------------
// Generator
// ---------------------------------------------------------------------------

class PollVoteGenerator {
  final Random _random;

  PollVoteGenerator({int? seed}) : _random = Random(seed);

  /// Generates a random valid PollVote.
  PollVote generate() {
    final pollId = 'poll_${_random.nextInt(50)}';
    final selectedOption = _random.nextInt(5); // 0-4
    final votedAt = DateTime(
      2020 + _random.nextInt(5),
      1 + _random.nextInt(12),
      1 + _random.nextInt(28),
      _random.nextInt(24),
      _random.nextInt(60),
      _random.nextInt(60),
    );

    return PollVote(
      pollId: pollId,
      selectedOption: selectedOption,
      votedAt: votedAt,
    );
  }

  /// Generates a PollVote for each valid option index (0-4).
  List<PollVote> generateAllOptions() {
    return List.generate(
      5,
      (i) => PollVote(
        pollId: 'poll_all_options',
        selectedOption: i,
        votedAt: DateTime(2024, 1, 1, i),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  const int iterations = 100;

  group('Property 3: Poll Vote Serialization Round-Trip', () {
    final generator = PollVoteGenerator(seed: 42);

    test(
      'round-trip preserves all fields for $iterations random votes',
      () {
        for (int i = 0; i < iterations; i++) {
          final original = generator.generate();
          final json = original.toJson();
          final deserialized = PollVote.fromJson(json);

          expect(
            deserialized.pollId,
            equals(original.pollId),
            reason: 'Iteration $i: pollId mismatch',
          );
          expect(
            deserialized.selectedOption,
            equals(original.selectedOption),
            reason: 'Iteration $i: selectedOption mismatch',
          );
          expect(
            deserialized.votedAt,
            equals(original.votedAt),
            reason: 'Iteration $i: votedAt mismatch',
          );
        }
      },
    );

    test(
      'round-trip produces equal objects (== operator) for $iterations votes',
      () {
        for (int i = 0; i < iterations; i++) {
          final original = generator.generate();
          final deserialized = PollVote.fromJson(original.toJson());

          expect(
            deserialized,
            equals(original),
            reason: 'Iteration $i: deserialized object should equal original',
          );
        }
      },
    );

    test('round-trip preserves all valid option indices (0-4)', () {
      final votes = generator.generateAllOptions();

      for (final original in votes) {
        final deserialized = PollVote.fromJson(original.toJson());

        expect(
          deserialized.selectedOption,
          equals(original.selectedOption),
          reason: 'Option index ${original.selectedOption} should survive '
              'round-trip serialization',
        );
      }
    });

    test('JSON map contains all required keys', () {
      final vote = generator.generate();
      final json = vote.toJson();

      expect(json.containsKey('pollId'), isTrue);
      expect(json.containsKey('selectedOption'), isTrue);
      expect(json.containsKey('votedAt'), isTrue);
    });

    test('votedAt is serialized as ISO 8601 string', () {
      for (int i = 0; i < iterations; i++) {
        final original = generator.generate();
        final json = original.toJson();

        expect(
          json['votedAt'],
          isA<String>(),
          reason: 'votedAt should be serialized as a String',
        );

        final parsed = DateTime.parse(json['votedAt'] as String);
        expect(
          parsed,
          equals(original.votedAt),
          reason: 'Iteration $i: parsed DateTime should equal original',
        );
      }
    });

    test('selectedOption is serialized as an int', () {
      for (int i = 0; i < iterations; i++) {
        final vote = generator.generate();
        final json = vote.toJson();
        expect(json['selectedOption'], isA<int>());
      }
    });

    test('deserialized vote passes isValid()', () {
      for (int i = 0; i < iterations; i++) {
        final original = generator.generate();
        final deserialized = PollVote.fromJson(original.toJson());

        expect(
          deserialized.isValid(),
          isTrue,
          reason: 'Iteration $i: deserialized vote should pass validation. '
              'pollId: ${deserialized.pollId}, '
              'selectedOption: ${deserialized.selectedOption}',
        );
      }
    });
  });
}

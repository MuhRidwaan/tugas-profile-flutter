// Feature: questionnaire-and-polling
// Property 1: Vote Percentage Calculation Correctness
//
// For any valid vote distribution map where total votes > 0, the calculated
// percentage for each option SHALL equal (option_count / total_votes) * 100,
// and all percentages SHALL sum to 100% (within floating-point precision
// tolerance).
//
// Validates: Requirements 4.4, 5.2

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/models/poll_result.dart';

// ---------------------------------------------------------------------------
// Generator
// ---------------------------------------------------------------------------

class VoteDistributionGenerator {
  final Random _random;

  VoteDistributionGenerator({int? seed}) : _random = Random(seed);

  /// Generates a random vote distribution across 5 options.
  /// Total votes is in the range [1, 1000].
  Map<int, int> generate() {
    final totalVotes = _random.nextInt(1000) + 1;
    final distribution = <int, int>{};

    int remaining = totalVotes;
    for (int i = 0; i < 4; i++) {
      final votes = _random.nextInt(remaining + 1);
      distribution[i] = votes;
      remaining -= votes;
    }
    distribution[4] = remaining;

    return distribution;
  }

  /// Generates a distribution where a single option gets all votes.
  Map<int, int> generateSingleVote() {
    final winnerIndex = _random.nextInt(5);
    return {
      for (int i = 0; i < 5; i++) i: i == winnerIndex ? 1 : 0,
    };
  }

  /// Generates an equal distribution (100 votes each).
  Map<int, int> generateEqualDistribution() {
    return {for (int i = 0; i < 5; i++) i: 20};
  }

  /// Generates a skewed distribution where one option dominates.
  Map<int, int> generateSkewedDistribution() {
    final dominant = _random.nextInt(5);
    return {
      for (int i = 0; i < 5; i++) i: i == dominant ? 900 : 25,
    };
  }
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  const int iterations = 100;
  const double tolerance = 0.01; // floating-point tolerance

  group('Property 1: Vote Percentage Calculation Correctness', () {
    final generator = VoteDistributionGenerator(seed: 42);

    test(
      'percentages sum to 100% for $iterations random distributions',
      () {
        for (int i = 0; i < iterations; i++) {
          final distribution = generator.generate();
          final result = PollResult.fromDistribution(distribution);

          double sum = 0.0;
          for (int option = 0; option < 5; option++) {
            sum += result.getPercentage(option);
          }

          expect(
            sum,
            closeTo(100.0, tolerance),
            reason: 'Iteration $i: percentages should sum to 100%, got $sum. '
                'Distribution: $distribution',
          );
        }
      },
    );

    test(
      'each percentage equals (count / total) * 100 for $iterations distributions',
      () {
        for (int i = 0; i < iterations; i++) {
          final distribution = generator.generate();
          final result = PollResult.fromDistribution(distribution);

          for (int option = 0; option < 5; option++) {
            final count = distribution[option] ?? 0;
            final expectedPct = (count / result.totalVotes) * 100.0;
            final actualPct = result.getPercentage(option);

            expect(
              actualPct,
              closeTo(expectedPct, tolerance),
              reason: 'Iteration $i, option $option: expected $expectedPct%, '
                  'got $actualPct%. Distribution: $distribution',
            );
          }
        }
      },
    );

    test('single vote: winner has 100%, others have 0%', () {
      for (int i = 0; i < iterations; i++) {
        final distribution = generator.generateSingleVote();
        final result = PollResult.fromDistribution(distribution);

        final winnerIndex =
            distribution.entries.firstWhere((e) => e.value == 1).key;

        expect(
          result.getPercentage(winnerIndex),
          closeTo(100.0, tolerance),
          reason: 'Winner (option $winnerIndex) should have 100%',
        );

        for (int option = 0; option < 5; option++) {
          if (option != winnerIndex) {
            expect(
              result.getPercentage(option),
              closeTo(0.0, tolerance),
              reason: 'Non-winner option $option should have 0%',
            );
          }
        }
      }
    });

    test('equal distribution: each option has ~20%', () {
      final distribution = generator.generateEqualDistribution();
      final result = PollResult.fromDistribution(distribution);

      for (int option = 0; option < 5; option++) {
        expect(
          result.getPercentage(option),
          closeTo(20.0, tolerance),
          reason: 'Equal distribution: option $option should have 20%',
        );
      }
    });

    test('skewed distribution: dominant option has highest percentage', () {
      for (int i = 0; i < iterations; i++) {
        final distribution = generator.generateSkewedDistribution();
        final result = PollResult.fromDistribution(distribution);

        final dominantIndex = distribution.entries
            .reduce((a, b) => a.value > b.value ? a : b)
            .key;
        final dominantPct = result.getPercentage(dominantIndex);

        for (int option = 0; option < 5; option++) {
          if (option != dominantIndex) {
            expect(
              dominantPct,
              greaterThan(result.getPercentage(option)),
              reason: 'Dominant option $dominantIndex ($dominantPct%) should '
                  'exceed option $option (${result.getPercentage(option)}%)',
            );
          }
        }
      }
    });

    test('zero total votes: all percentages are 0%', () {
      final result = PollResult.empty();

      for (int option = 0; option < 5; option++) {
        expect(
          result.getPercentage(option),
          equals(0.0),
          reason: 'Zero votes: option $option should have 0%',
        );
      }
    });

    test('getCount returns correct vote count for each option', () {
      for (int i = 0; i < iterations; i++) {
        final distribution = generator.generate();
        final result = PollResult.fromDistribution(distribution);

        for (int option = 0; option < 5; option++) {
          final expected = distribution[option] ?? 0;
          expect(
            result.getCount(option),
            equals(expected),
            reason: 'Iteration $i, option $option: expected count $expected, '
                'got ${result.getCount(option)}',
          );
        }
      }
    });
  });
}

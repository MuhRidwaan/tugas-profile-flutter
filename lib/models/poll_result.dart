/// Model representing the aggregated results of a poll
///
/// Tracks vote distribution across all 5 sports options and provides
/// methods to calculate percentages and retrieve counts per option.
class PollResult {
  /// Map of option index (0-4) to vote count
  final Map<int, int> voteCounts;

  /// Total number of votes cast across all options
  final int totalVotes;

  PollResult({
    required this.voteCounts,
    required this.totalVotes,
  });

  /// Returns the percentage of votes for the given option index (0-4).
  ///
  /// Returns 0.0 if [totalVotes] is zero to avoid division by zero.
  /// The returned value is in the range 0.0 to 100.0.
  double getPercentage(int optionIndex) {
    if (totalVotes == 0) return 0.0;
    final count = voteCounts[optionIndex] ?? 0;
    return (count / totalVotes) * 100.0;
  }

  /// Returns the vote count for the given option index (0-4).
  ///
  /// Returns 0 if no votes have been recorded for that option.
  int getCount(int optionIndex) {
    return voteCounts[optionIndex] ?? 0;
  }

  /// Validates the poll result structure.
  ///
  /// Returns true if:
  /// - All option indices are valid (0-4)
  /// - All vote counts are non-negative
  /// - totalVotes matches the sum of all vote counts
  bool isValid() {
    // All option indices must be in range 0-4
    for (final index in voteCounts.keys) {
      if (index < 0 || index >= 5) {
        return false;
      }
    }

    // All vote counts must be non-negative
    for (final count in voteCounts.values) {
      if (count < 0) {
        return false;
      }
    }

    // totalVotes must match the sum of all vote counts
    final computedTotal =
        voteCounts.values.fold<int>(0, (sum, count) => sum + count);
    if (totalVotes != computedTotal) {
      return false;
    }

    return true;
  }

  /// Converts the poll result to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'voteCounts': voteCounts.map(
        (key, value) => MapEntry(key.toString(), value),
      ),
      'totalVotes': totalVotes,
    };
  }

  /// Creates a PollResult from a JSON map.
  factory PollResult.fromJson(Map<String, dynamic> json) {
    final rawCounts = json['voteCounts'] as Map<String, dynamic>;
    final voteCounts = rawCounts.map(
      (key, value) => MapEntry(int.parse(key), value as int),
    );

    return PollResult(
      voteCounts: voteCounts,
      totalVotes: json['totalVotes'] as int,
    );
  }

  /// Creates an empty PollResult with zero votes for all 5 options.
  factory PollResult.empty() {
    return PollResult(
      voteCounts: {0: 0, 1: 0, 2: 0, 3: 0, 4: 0},
      totalVotes: 0,
    );
  }

  /// Creates a PollResult from a vote distribution map, computing totalVotes automatically.
  factory PollResult.fromDistribution(Map<int, int> distribution) {
    final total = distribution.values.fold<int>(0, (sum, count) => sum + count);
    return PollResult(
      voteCounts: Map.from(distribution),
      totalVotes: total,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is! PollResult) return false;
    if (other.totalVotes != totalVotes) return false;
    if (other.voteCounts.length != voteCounts.length) return false;

    for (final entry in voteCounts.entries) {
      if (other.voteCounts[entry.key] != entry.value) return false;
    }

    return true;
  }

  @override
  int get hashCode {
    return Object.hash(
      totalVotes,
      Object.hashAll(
        voteCounts.entries.map((e) => Object.hash(e.key, e.value)),
      ),
    );
  }

  @override
  String toString() {
    return 'PollResult(totalVotes: $totalVotes, voteCounts: $voteCounts)';
  }
}

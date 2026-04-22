/// Model representing a user's vote on a poll
class PollVote {
  /// The ID of the poll this vote is for
  final String pollId;

  /// The index of the selected option (0-4)
  final int selectedOption;

  /// Timestamp when the vote was submitted
  final DateTime votedAt;

  PollVote({
    required this.pollId,
    required this.selectedOption,
    required this.votedAt,
  });

  /// Validates the poll vote structure
  ///
  /// Returns true if:
  /// - Poll ID is not empty
  /// - Selected option index is valid (0-4)
  bool isValid() {
    // Poll ID must not be empty
    if (pollId.isEmpty) {
      return false;
    }

    // Selected option must be valid index (0-4)
    if (selectedOption < 0 || selectedOption >= 5) {
      return false;
    }

    return true;
  }

  /// Converts the poll vote to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'pollId': pollId,
      'selectedOption': selectedOption,
      'votedAt': votedAt.toIso8601String(),
    };
  }

  /// Creates a PollVote from a JSON map
  factory PollVote.fromJson(Map<String, dynamic> json) {
    return PollVote(
      pollId: json['pollId'] as String,
      selectedOption: json['selectedOption'] as int,
      votedAt: DateTime.parse(json['votedAt'] as String),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PollVote &&
        other.pollId == pollId &&
        other.selectedOption == selectedOption &&
        other.votedAt == votedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      pollId,
      selectedOption,
      votedAt,
    );
  }

  @override
  String toString() {
    return 'PollVote(pollId: $pollId, selectedOption: $selectedOption, '
        'votedAt: $votedAt)';
  }
}

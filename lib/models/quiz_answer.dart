/// Model representing a user's answer to a quiz question
class QuizAnswer {
  /// The ID of the question this answer is for
  final String questionId;

  /// List of selected option indices (0-4)
  final List<int> selectedOptions;

  /// Whether the answer is correct
  final bool isCorrect;

  /// Timestamp when the answer was submitted
  final DateTime submittedAt;

  QuizAnswer({
    required this.questionId,
    required this.selectedOptions,
    required this.isCorrect,
    required this.submittedAt,
  });

  /// Validates the quiz answer structure
  ///
  /// Returns true if:
  /// - Question ID is not empty
  /// - At least 1 option is selected
  /// - All selected option indices are valid (0-4)
  bool isValid() {
    // Question ID must not be empty
    if (questionId.isEmpty) {
      return false;
    }

    // Must have at least one selected option
    if (selectedOptions.isEmpty) {
      return false;
    }

    // All selected option indices must be valid (0-4)
    if (!selectedOptions.every((index) => index >= 0 && index < 5)) {
      return false;
    }

    return true;
  }

  /// Converts the quiz answer to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'selectedOptions': selectedOptions,
      'isCorrect': isCorrect,
      'submittedAt': submittedAt.toIso8601String(),
    };
  }

  /// Creates a QuizAnswer from a JSON map
  factory QuizAnswer.fromJson(Map<String, dynamic> json) {
    return QuizAnswer(
      questionId: json['questionId'] as String,
      selectedOptions: List<int>.from(json['selectedOptions'] as List),
      isCorrect: json['isCorrect'] as bool,
      submittedAt: DateTime.parse(json['submittedAt'] as String),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuizAnswer &&
        other.questionId == questionId &&
        _listEquals(other.selectedOptions, selectedOptions) &&
        other.isCorrect == isCorrect &&
        other.submittedAt == submittedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      questionId,
      Object.hashAll(selectedOptions),
      isCorrect,
      submittedAt,
    );
  }

  /// Helper method to compare lists for equality
  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  String toString() {
    return 'QuizAnswer(questionId: $questionId, selectedOptions: $selectedOptions, '
        'isCorrect: $isCorrect, submittedAt: $submittedAt)';
  }
}

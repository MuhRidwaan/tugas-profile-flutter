/// Enum representing the type of quiz question
enum QuestionType {
  /// Single choice question - exactly one correct answer
  single,

  /// Multiple choice question - two or more correct answers
  multiple,
}

/// Model representing a quiz question with validation and serialization
class QuizQuestion {
  /// Unique identifier for the question
  final String id;

  /// The question text displayed to the user
  final String questionText;

  /// Type of question (single or multiple choice)
  final QuestionType type;

  /// List of answer options - must be exactly 5 options
  final List<String> options;

  /// List of correct answer indices (0-4) - at least 1 required
  final List<int> correctAnswers;

  QuizQuestion({
    required this.id,
    required this.questionText,
    required this.type,
    required this.options,
    required this.correctAnswers,
  });

  /// Validates the quiz question structure
  ///
  /// Returns true if:
  /// - Exactly 5 options are provided
  /// - At least 1 correct answer is provided
  /// - All correct answer indices are valid (0-4)
  /// - Single choice questions have exactly 1 correct answer
  bool isValid() {
    // Must have exactly 5 options
    if (options.length != 5) {
      return false;
    }

    // Must have at least one correct answer
    if (correctAnswers.isEmpty) {
      return false;
    }

    // All correct answer indices must be valid (0-4)
    if (!correctAnswers.every((index) => index >= 0 && index < 5)) {
      return false;
    }

    // Single choice questions must have exactly 1 correct answer
    if (type == QuestionType.single && correctAnswers.length != 1) {
      return false;
    }

    return true;
  }

  /// Converts the quiz question to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionText': questionText,
      'type': type.name,
      'options': options,
      'correctAnswers': correctAnswers,
    };
  }

  /// Creates a QuizQuestion from a JSON map
  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'] as String,
      questionText: json['questionText'] as String,
      type: QuestionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => QuestionType.single,
      ),
      options: List<String>.from(json['options'] as List),
      correctAnswers: List<int>.from(json['correctAnswers'] as List),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuizQuestion &&
        other.id == id &&
        other.questionText == questionText &&
        other.type == type &&
        _listEquals(other.options, options) &&
        _listEquals(other.correctAnswers, correctAnswers);
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      questionText,
      type,
      Object.hashAll(options),
      Object.hashAll(correctAnswers),
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
    return 'QuizQuestion(id: $id, questionText: $questionText, type: $type, '
        'options: $options, correctAnswers: $correctAnswers)';
  }
}

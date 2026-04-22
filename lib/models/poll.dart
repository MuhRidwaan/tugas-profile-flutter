/// Model representing a poll with validation and serialization
class Poll {
  /// Unique identifier for the poll
  final String id;

  /// The poll question displayed to the user
  final String question;

  /// List of poll options - must be exactly 5 sports options
  final List<String> options;

  /// The fixed sports options for the poll
  static const List<String> validSportsOptions = [
    'Badminton',
    'Catur',
    'Padel',
    'Basket',
    'Lari Marathon',
  ];

  Poll({
    required this.id,
    required this.question,
    required this.options,
  });

  /// Validates the poll structure
  ///
  /// Returns true if:
  /// - Exactly 5 options are provided
  /// - Options match the valid sports options
  bool isValid() {
    // Must have exactly 5 options
    if (options.length != 5) {
      return false;
    }

    // Options must match the valid sports options
    // Check that all required sports are present
    for (final sport in validSportsOptions) {
      if (!options.contains(sport)) {
        return false;
      }
    }

    return true;
  }

  /// Converts the poll to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
    };
  }

  /// Creates a Poll from a JSON map
  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      id: json['id'] as String,
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List),
    );
  }

  /// Creates a default poll with the standard sports options
  factory Poll.defaultPoll() {
    return Poll(
      id: 'sports_poll_1',
      question: 'Apa hobi olahraga favorit Anda?',
      options: List.from(validSportsOptions),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Poll &&
        other.id == id &&
        other.question == question &&
        _listEquals(other.options, options);
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      question,
      Object.hashAll(options),
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
    return 'Poll(id: $id, question: $question, options: $options)';
  }
}

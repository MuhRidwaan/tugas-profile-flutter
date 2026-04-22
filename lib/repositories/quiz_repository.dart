import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/quiz_answer.dart';
import '../models/quiz_question.dart';

/// Repository for managing quiz questions and user answers.
///
/// Provides hardcoded quiz questions (extensible to remote API) and
/// persists user answers using SharedPreferences.
class QuizRepository {
  static const String _answersKey = 'quiz_answers';

  final SharedPreferences _prefs;

  QuizRepository(this._prefs);

  // ---------------------------------------------------------------------------
  // Hardcoded quiz questions (sports/general knowledge in Indonesian)
  // ---------------------------------------------------------------------------

  static final List<QuizQuestion> _hardcodedQuestions = [
    // 1. Single choice
    QuizQuestion(
      id: 'q1',
      questionText:
          'Berapa jumlah pemain dalam satu tim bola basket yang bermain di lapangan?',
      type: QuestionType.single,
      options: [
        'A. 4 pemain',
        'B. 5 pemain',
        'C. 6 pemain',
        'D. 7 pemain',
        'E. 8 pemain',
      ],
      correctAnswers: [1], // B. 5 pemain
    ),

    // 2. Single choice
    QuizQuestion(
      id: 'q2',
      questionText: 'Negara manakah yang memenangkan Piala Dunia FIFA 2022?',
      type: QuestionType.single,
      options: [
        'A. Brasil',
        'B. Prancis',
        'C. Argentina',
        'D. Jerman',
        'E. Spanyol',
      ],
      correctAnswers: [2], // C. Argentina
    ),

    // 3. Single choice
    QuizQuestion(
      id: 'q3',
      questionText:
          'Olahraga apa yang menggunakan istilah "smash" dan "drop shot"?',
      type: QuestionType.single,
      options: [
        'A. Tenis Meja',
        'B. Voli',
        'C. Bulu Tangkis',
        'D. Squash',
        'E. Tenis Lapangan',
      ],
      correctAnswers: [2], // C. Bulu Tangkis
    ),

    // 4. Multiple choice
    QuizQuestion(
      id: 'q4',
      questionText:
          'Manakah dari berikut ini yang termasuk cabang olahraga atletik? (Pilih semua yang benar — pilih salah satu)',
      type: QuestionType.multiple,
      options: [
        'A. Lari 100 meter',
        'B. Renang gaya bebas',
        'C. Lempar cakram',
        'D. Senam lantai',
        'E. Loncat tinggi',
      ],
      correctAnswers: [0, 2, 4], // A, C, E
    ),

    // 5. Multiple choice
    QuizQuestion(
      id: 'q5',
      questionText:
          'Manakah dari berikut ini yang merupakan teknik dasar dalam bola voli? (Pilih semua yang benar — pilih salah satu)',
      type: QuestionType.multiple,
      options: [
        'A. Passing bawah',
        'B. Dribbling',
        'C. Servis',
        'D. Tackle',
        'E. Smash',
      ],
      correctAnswers: [0, 2, 4], // A, C, E
    ),
  ];

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  /// Returns the list of hardcoded quiz questions.
  ///
  /// This method is designed to be extensible: in the future the questions
  /// can be fetched from a remote API and merged with or replaced by the
  /// hardcoded list.
  Future<List<QuizQuestion>> getQuestions() async {
    try {
      return List<QuizQuestion>.from(_hardcodedQuestions);
    } catch (e) {
      // Return empty list on unexpected error
      return [];
    }
  }

  /// Saves (or updates) a [QuizAnswer] to SharedPreferences.
  ///
  /// Answers are stored as a JSON-encoded list under [_answersKey].
  Future<void> saveAnswer(QuizAnswer answer) async {
    try {
      final allAnswers = await _loadAnswersMap();
      allAnswers[answer.questionId] = answer.toJson();

      final encoded = jsonEncode(allAnswers.values.toList());
      await _prefs.setString(_answersKey, encoded);
    } catch (e) {
      // Silently fail — in-memory state is still valid
    }
  }

  /// Retrieves the saved [QuizAnswer] for [questionId], or `null` if not found.
  Future<QuizAnswer?> getAnswer(String questionId) async {
    try {
      final allAnswers = await _loadAnswersMap();
      final json = allAnswers[questionId];
      if (json == null) return null;
      return QuizAnswer.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  /// Retrieves all saved [QuizAnswer] objects.
  Future<List<QuizAnswer>> getAllAnswers() async {
    try {
      final allAnswers = await _loadAnswersMap();
      return allAnswers.values
          .map((json) => QuizAnswer.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// Loads the answers map (questionId → raw JSON map) from SharedPreferences.
  Future<Map<String, Map<String, dynamic>>> _loadAnswersMap() async {
    try {
      final raw = _prefs.getString(_answersKey);
      if (raw == null || raw.isEmpty) return {};

      final decoded = jsonDecode(raw);
      if (decoded is! List) return {};

      final map = <String, Map<String, dynamic>>{};
      for (final item in decoded) {
        if (item is Map<String, dynamic>) {
          final questionId = item['questionId'] as String?;
          if (questionId != null) {
            map[questionId] = item;
          }
        }
      }
      return map;
    } catch (e) {
      return {};
    }
  }
}

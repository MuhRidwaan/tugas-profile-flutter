import 'package:flutter/foundation.dart';

import '../models/quiz_answer.dart';
import '../models/quiz_question.dart';
import '../repositories/quiz_repository.dart';

/// Provider managing quiz state: questions, user answers, loading, and errors.
///
/// Integrates with [QuizRepository] for data persistence and notifies
/// listeners on every state change so the UI can rebuild automatically.
class QuizProvider extends ChangeNotifier {
  final QuizRepository _repository;

  // ---------------------------------------------------------------------------
  // State
  // ---------------------------------------------------------------------------

  List<QuizQuestion> _questions = [];
  Map<String, QuizAnswer> _answers = {};
  bool _isLoading = false;
  String? _errorMessage;

  // ---------------------------------------------------------------------------
  // Constructor
  // ---------------------------------------------------------------------------

  QuizProvider(this._repository);

  // ---------------------------------------------------------------------------
  // Public getters
  // ---------------------------------------------------------------------------

  /// All loaded quiz questions.
  List<QuizQuestion> get questions => List.unmodifiable(_questions);

  /// Map of questionId → [QuizAnswer] for every answered question.
  Map<String, QuizAnswer> get answers => Map.unmodifiable(_answers);

  /// Whether a loading operation is in progress.
  bool get isLoading => _isLoading;

  /// Non-null when the last operation produced an error.
  String? get errorMessage => _errorMessage;

  // ---------------------------------------------------------------------------
  // Public methods
  // ---------------------------------------------------------------------------

  /// Loads questions from the repository and restores any previously saved
  /// answers.
  ///
  /// Sets [isLoading] to `true` while working and clears it when done.
  /// On failure, [errorMessage] is set with a user-friendly description.
  Future<void> loadQuestions() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final loadedQuestions = await _repository.getQuestions();
      _questions = loadedQuestions;

      // Restore previously saved answers
      try {
        final savedAnswers = await _repository.getAllAnswers();
        _answers = {
          for (final answer in savedAnswers) answer.questionId: answer,
        };
      } catch (e) {
        debugPrint('Failed to load saved answers: $e');
        _answers = {};
        _errorMessage = 'Could not load previous answers. Starting fresh.';
      }
    } catch (e) {
      debugPrint('Failed to load questions: $e');
      _questions = [];
      _errorMessage = 'Could not load questions. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Validates [selectedOptions] against the question's correct answers and
  /// persists the resulting [QuizAnswer] via the repository.
  ///
  /// Silently ignores attempts to re-answer an already-answered question.
  /// On persistence failure the in-memory state is still updated so the UI
  /// remains consistent.
  Future<void> submitAnswer(
    String questionId,
    List<int> selectedOptions,
  ) async {
    // Prevent re-answering
    if (isQuestionAnswered(questionId)) {
      debugPrint('Attempted to re-answer question: $questionId');
      return;
    }

    // Find the question
    final question = _questions.cast<QuizQuestion?>().firstWhere(
          (q) => q?.id == questionId,
          orElse: () => null,
        );

    if (question == null) {
      debugPrint('Question not found: $questionId');
      return;
    }

    final correct = validateAnswer(question, selectedOptions);

    final answer = QuizAnswer(
      questionId: questionId,
      selectedOptions: List<int>.from(selectedOptions),
      isCorrect: correct,
      submittedAt: DateTime.now(),
    );

    // Update in-memory state immediately (optimistic UI)
    _answers = Map<String, QuizAnswer>.from(_answers)..[questionId] = answer;
    notifyListeners();

    // Persist asynchronously
    try {
      await _repository.saveAnswer(answer);
    } catch (e) {
      debugPrint('Failed to save answer for $questionId: $e');
      _errorMessage = 'Having trouble saving your progress.';
      notifyListeners();
    }
  }

  /// Returns `true` if [selectedOptions] exactly matches [question.correctAnswers]
  /// (order-independent).
  bool validateAnswer(QuizQuestion question, List<int> selectedOptions) {
    if (selectedOptions.length != question.correctAnswers.length) {
      return false;
    }

    final selectedSet = selectedOptions.toSet();
    final correctSet = question.correctAnswers.toSet();

    return selectedSet.length == selectedOptions.length &&
        selectedSet.containsAll(correctSet) &&
        correctSet.containsAll(selectedSet);
  }

  /// Returns `true` if the user has already submitted an answer for
  /// [questionId].
  bool isQuestionAnswered(String questionId) {
    return _answers.containsKey(questionId);
  }

  /// Returns the saved [QuizAnswer] for [questionId], or `null` if not yet
  /// answered.
  QuizAnswer? getAnswer(String questionId) {
    return _answers[questionId];
  }
}

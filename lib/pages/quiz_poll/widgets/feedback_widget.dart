import 'package:flutter/material.dart';

import '../../../models/quiz_answer.dart';
import '../../../models/quiz_question.dart';

/// A widget that displays feedback after a user submits a quiz answer.
///
/// Shows a green success indicator when the answer is correct, or a red error
/// indicator when incorrect. When incorrect, it also shows the user's selected
/// answer and the correct answer(s).
///
/// Fades in with an 80ms animation (satisfying the < 100ms requirement).
///
/// Requirements: 1.2, 1.3, 2.2, 2.3, 3.1, 3.2, 3.3, 3.4, 3.5, 8.1
class FeedbackWidget extends StatefulWidget {
  /// The submitted answer to display feedback for.
  final QuizAnswer answer;

  /// The question, used to resolve option text and correct answers.
  final QuizQuestion question;

  const FeedbackWidget({
    super.key,
    required this.answer,
    required this.question,
  });

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget>
    with SingleTickerProviderStateMixin {
  // ---------------------------------------------------------------------------
  // Constants
  // ---------------------------------------------------------------------------

  static const Duration _fadeDuration = Duration(milliseconds: 80);

  static const Color _successBackground = Color(0xFFE8F5E9);
  static const Color _successBorder = Color(0xFF4CAF50);
  static const Color _successIcon = Color(0xFF4CAF50);
  static const Color _successText = Color(0xFF2E7D32);

  static const Color _errorBackground = Color(0xFFFFEBEE);
  static const Color _errorBorder = Color(0xFFF44336);
  static const Color _errorIcon = Color(0xFFF44336);
  static const Color _errorText = Color(0xFFC62828);

  // ---------------------------------------------------------------------------
  // Animation
  // ---------------------------------------------------------------------------

  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _fadeDuration);
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    // Start the fade-in immediately.
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  bool get _isCorrect => widget.answer.isCorrect;

  Color get _backgroundColor =>
      _isCorrect ? _successBackground : _errorBackground;

  Color get _borderColor => _isCorrect ? _successBorder : _errorBorder;

  Color get _iconColor => _isCorrect ? _successIcon : _errorIcon;

  Color get _titleColor => _isCorrect ? _successText : _errorText;

  IconData get _icon => _isCorrect ? Icons.check_circle : Icons.cancel;

  String get _title => _isCorrect ? 'Jawaban Benar!' : 'Jawaban Salah!';

  /// Returns the display text for a given option index, safely handling
  /// out-of-range indices.
  String _optionText(int index) {
    final options = widget.question.options;
    if (index < 0 || index >= options.length) return 'Opsi $index';
    return options[index];
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _borderColor, width: 1.5),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            if (!_isCorrect) ...[
              const SizedBox(height: 10),
              _buildAnswerDetails(),
            ],
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Sub-builders
  // ---------------------------------------------------------------------------

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(_icon, color: _iconColor, size: 22),
        const SizedBox(width: 8),
        Text(
          _title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: _titleColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAnswerRow(
          label: 'Jawaban kamu:',
          options: widget.answer.selectedOptions,
          color: _errorText,
        ),
        const SizedBox(height: 6),
        _buildAnswerRow(
          label: 'Jawaban benar:',
          options: widget.question.correctAnswers,
          color: _successText,
          isCorrect: true,
        ),
      ],
    );
  }

  Widget _buildAnswerRow({
    required String label,
    required List<int> options,
    required Color color,
    bool isCorrect = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 3),
        ...options.map(
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  isCorrect ? Icons.check : Icons.close,
                  size: 14,
                  color: color,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    _optionText(index),
                    style: TextStyle(
                      fontSize: 13,
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

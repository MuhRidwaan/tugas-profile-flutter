import 'package:flutter/material.dart';

import '../../../models/quiz_answer.dart';
import '../../../models/quiz_question.dart';

/// A card widget that displays a single quiz question with answer options.
///
/// Supports both single-choice (RadioListTile) and multiple-choice
/// (CheckboxListTile) question types. When [existingAnswer] is provided the
/// card renders in a read-only/disabled state showing the previously selected
/// options. Otherwise it shows interactive controls and a Submit button.
///
/// This widget is intentionally Provider-free: all data flows in via
/// constructor parameters and results flow out via [onSubmit].
class QuizQuestionCard extends StatefulWidget {
  /// The question to display.
  final QuizQuestion question;

  /// If non-null, the question has already been answered and the card is
  /// rendered in a disabled/read-only state.
  final QuizAnswer? existingAnswer;

  /// Called when the user taps the Submit button.
  /// Receives the list of selected option indices.
  final Function(List<int> selectedOptions)? onSubmit;

  /// Optional 1-based question number shown above the question text.
  final int? questionNumber;

  const QuizQuestionCard({
    super.key,
    required this.question,
    this.existingAnswer,
    this.onSubmit,
    this.questionNumber,
  });

  @override
  State<QuizQuestionCard> createState() => _QuizQuestionCardState();
}

class _QuizQuestionCardState extends State<QuizQuestionCard> {
  // ---------------------------------------------------------------------------
  // Constants
  // ---------------------------------------------------------------------------

  static const Color _primaryBlue = Color(0xFF1565C0);
  static const Color _disabledGrey = Color(0xFF9E9E9E);
  static const Color _cardBackground = Colors.white;

  // ---------------------------------------------------------------------------
  // Local state
  // ---------------------------------------------------------------------------

  /// Currently selected option indices (before submission).
  late List<int> _selectedOptions;

  @override
  void initState() {
    super.initState();
    // Pre-populate from existing answer so the card shows the right state
    // even when switching between answered/unanswered.
    _selectedOptions = widget.existingAnswer != null
        ? List<int>.from(widget.existingAnswer!.selectedOptions)
        : [];
  }

  @override
  void didUpdateWidget(QuizQuestionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the answer state changed externally, sync local selection.
    if (widget.existingAnswer != oldWidget.existingAnswer) {
      _selectedOptions = widget.existingAnswer != null
          ? List<int>.from(widget.existingAnswer!.selectedOptions)
          : [];
    }
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  bool get _isAnswered => widget.existingAnswer != null;

  bool get _isSingleChoice => widget.question.type == QuestionType.single;

  bool get _canSubmit => _selectedOptions.isNotEmpty;

  void _handleSingleSelect(int index) {
    if (_isAnswered) return;
    setState(() {
      _selectedOptions = [index];
    });
  }

  void _handleMultipleSelect(int index, bool selected) {
    if (_isAnswered) return;
    setState(() {
      if (selected) {
        // Per requirements, multiple-choice also allows only 1 selection.
        _selectedOptions = [index];
      } else {
        _selectedOptions.remove(index);
      }
    });
  }

  void _submit() {
    if (!_canSubmit || _isAnswered) return;
    widget.onSubmit?.call(List<int>.from(_selectedOptions));
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: _cardBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuestionHeader(),
            const SizedBox(height: 12),
            _buildOptions(),
            if (!_isAnswered) ...[
              const SizedBox(height: 16),
              _buildSubmitButton(),
            ],
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Sub-builders
  // ---------------------------------------------------------------------------

  Widget _buildQuestionHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.questionNumber != null)
            Text(
              'Pertanyaan ${widget.questionNumber}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _primaryBlue,
                letterSpacing: 0.5,
              ),
            ),
          if (widget.questionNumber != null) const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  widget.question.questionText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF212121),
                    height: 1.4,
                  ),
                ),
              ),
              if (_isAnswered) _buildAnsweredBadge(),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            _isSingleChoice ? 'Pilih satu jawaban' : 'Pilih jawaban yang benar',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnsweredBadge() {
    final isCorrect = widget.existingAnswer?.isCorrect ?? false;
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isCorrect ? const Color(0x264CAF50) : const Color(0x26F44336),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isCorrect ? Icons.check_circle : Icons.cancel,
            size: 14,
            color:
                isCorrect ? const Color(0xFF4CAF50) : const Color(0xFFF44336),
          ),
          const SizedBox(width: 4),
          Text(
            isCorrect ? 'Benar' : 'Salah',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color:
                  isCorrect ? const Color(0xFF4CAF50) : const Color(0xFFF44336),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptions() {
    return Column(
      children: List.generate(
        widget.question.options.length,
        (index) => _isSingleChoice
            ? _buildRadioOption(index)
            : _buildCheckboxOption(index),
      ),
    );
  }

  Widget _buildRadioOption(int index) {
    final isSelected = _selectedOptions.contains(index);
    final isCorrect = widget.question.correctAnswers.contains(index);
    final optionColor = _optionColor(
      isSelected: isSelected,
      isCorrect: isCorrect,
    );

    return RadioListTile<int>(
      value: index,
      groupValue: _selectedOptions.isNotEmpty ? _selectedOptions.first : null,
      onChanged: _isAnswered ? null : (_) => _handleSingleSelect(index),
      title: Text(
        widget.question.options[index],
        style: TextStyle(
          fontSize: 15,
          color: _isAnswered ? optionColor : const Color(0xFF424242),
          fontWeight:
              isSelected && _isAnswered ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      activeColor: _primaryBlue,
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (_isAnswered) {
          if (isSelected) return optionColor;
          return _disabledGrey.withOpacity(0.5);
        }
        if (states.contains(WidgetState.selected)) return _primaryBlue;
        return _disabledGrey;
      }),
      tileColor:
          _isAnswered && isSelected ? optionColor.withOpacity(0.08) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    );
  }

  Widget _buildCheckboxOption(int index) {
    final isSelected = _selectedOptions.contains(index);
    final isCorrect = widget.question.correctAnswers.contains(index);
    final optionColor = _optionColor(
      isSelected: isSelected,
      isCorrect: isCorrect,
    );

    return CheckboxListTile(
      value: isSelected,
      onChanged: _isAnswered
          ? null
          : (checked) => _handleMultipleSelect(index, checked ?? false),
      title: Text(
        widget.question.options[index],
        style: TextStyle(
          fontSize: 15,
          color: _isAnswered ? optionColor : const Color(0xFF424242),
          fontWeight:
              isSelected && _isAnswered ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      activeColor: _primaryBlue,
      checkColor: Colors.white,
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (_isAnswered) {
          if (isSelected) return optionColor;
          return _disabledGrey.withOpacity(0.5);
        }
        if (states.contains(WidgetState.selected)) return _primaryBlue;
        return null;
      }),
      tileColor:
          _isAnswered && isSelected ? optionColor.withOpacity(0.08) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _canSubmit ? _submit : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryBlue,
            disabledBackgroundColor: _disabledGrey.withOpacity(0.3),
            foregroundColor: Colors.white,
            disabledForegroundColor: _disabledGrey,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: const Text(
            'Kirim Jawaban',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Color helpers
  // ---------------------------------------------------------------------------

  /// Returns the accent color for an option tile when the card is in the
  /// answered/disabled state.
  Color _optionColor({required bool isSelected, required bool isCorrect}) {
    if (!_isAnswered) return _primaryBlue;

    if (isSelected && isCorrect) return const Color(0xFF4CAF50); // green
    if (isSelected && !isCorrect) return const Color(0xFFF44336); // red
    if (!isSelected && isCorrect) return const Color(0xFF4CAF50); // green hint
    return _disabledGrey;
  }
}

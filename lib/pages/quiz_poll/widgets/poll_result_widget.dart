import 'package:flutter/material.dart';

import '../../../models/poll.dart';
import '../../../models/poll_result.dart';

/// A widget that displays poll results with vote distribution visualization.
///
/// Shows each sports option with:
/// - A progress bar representing the percentage of votes
/// - Vote count and percentage text
/// - Highlighted styling for the user's selected option
///
/// Animates result updates smoothly (< 200ms) using AnimatedBuilder.
///
/// Requirements: 4.3, 4.4, 5.1, 5.2, 5.3, 5.4, 5.5, 8.2
class PollResultWidget extends StatefulWidget {
  /// The poll containing the 5 sports options.
  final Poll poll;

  /// The aggregated vote distribution and percentages.
  final PollResult voteDistribution;

  /// The index of the user's selected option (0-4), or null if not voted.
  final int? userSelectedOptionIndex;

  const PollResultWidget({
    super.key,
    required this.poll,
    required this.voteDistribution,
    this.userSelectedOptionIndex,
  });

  @override
  State<PollResultWidget> createState() => _PollResultWidgetState();
}

class _PollResultWidgetState extends State<PollResultWidget>
    with SingleTickerProviderStateMixin {
  // ---------------------------------------------------------------------------
  // Constants
  // ---------------------------------------------------------------------------

  static const Duration _animationDuration = Duration(milliseconds: 200);

  static const Color _primaryBlue = Color(0xFF1565C0);
  static const Color _accentPurple = Color(0xFF7B1FA2);
  static const Color _progressBackground = Color(0xFFE0E0E0);
  static const Color _selectedHighlight = Color(0xFFF3E5F5);
  static const Color _selectedBorder = Color(0xFF7B1FA2);

  // ---------------------------------------------------------------------------
  // Animation
  // ---------------------------------------------------------------------------

  late final AnimationController _controller;
  late final Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    _progressAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    // Start animation immediately
    _controller.forward();
  }

  @override
  void didUpdateWidget(PollResultWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Restart animation when vote distribution changes
    if (oldWidget.voteDistribution != widget.voteDistribution) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Maps each poll option index to a relevant sports icon.
  ///
  /// Index mapping matches [Poll.validSportsOptions]:
  ///   0 → Badminton, 1 → Catur, 2 → Padel, 3 → Basket, 4 → Lari Marathon
  IconData _sportsIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.sports_tennis; // Badminton
      case 1:
        return Icons.casino; // Catur (chess)
      case 2:
        return Icons.sports_tennis; // Padel
      case 3:
        return Icons.sports_basketball; // Basket
      case 4:
        return Icons.directions_run; // Lari Marathon
      default:
        return Icons.sports;
    }
  }

  bool _isUserSelected(int optionIndex) {
    return widget.userSelectedOptionIndex == optionIndex;
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                'Hasil Polling',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
              ),
            ),
            ...List.generate(
              widget.poll.options.length,
              (index) => _buildResultRow(index),
            ),
          ],
        );
      },
    );
  }

  /// Builds a single result row for one sports option.
  Widget _buildResultRow(int optionIndex) {
    final isSelected = _isUserSelected(optionIndex);
    final optionText = widget.poll.options[optionIndex];
    final percentage = widget.voteDistribution.getPercentage(optionIndex);
    final count = widget.voteDistribution.getCount(optionIndex);

    return Semantics(
      label: '$optionText: $percentage% ($count votes)',
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? _selectedHighlight : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? _selectedBorder : Colors.transparent,
            width: isSelected ? 2.0 : 0,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOptionHeader(optionIndex, optionText, isSelected),
            const SizedBox(height: 8),
            _buildProgressBar(percentage),
            const SizedBox(height: 6),
            _buildStatsRow(percentage, count),
          ],
        ),
      ),
    );
  }

  /// Builds the header row with icon, option text, and selection indicator.
  Widget _buildOptionHeader(
    int optionIndex,
    String optionText,
    bool isSelected,
  ) {
    return Row(
      children: [
        Icon(
          _sportsIconForIndex(optionIndex),
          size: 20,
          color: isSelected ? _accentPurple : Colors.grey[600],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            optionText,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? _accentPurple : Colors.black87,
            ),
          ),
        ),
        if (isSelected)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _accentPurple.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 14,
                  color: _accentPurple,
                ),
                SizedBox(width: 4),
                Text(
                  'Pilihan Anda',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _accentPurple,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  /// Builds the animated progress bar.
  Widget _buildProgressBar(double percentage) {
    // Animate the progress bar width based on percentage
    final animatedPercentage = percentage * _progressAnimation.value;

    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 24,
        decoration: BoxDecoration(
          color: _progressBackground,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          children: [
            // Animated progress fill
            Container(
              height: 24,
              width: (animatedPercentage / 100) * 300, // Max width ~300
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_primaryBlue, _primaryBlue.withOpacity(0.7)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            // Percentage text overlay
            Center(
              child: Text(
                '${animatedPercentage.toStringAsFixed(1)}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the stats row showing vote count.
  Widget _buildStatsRow(double percentage, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${percentage.toStringAsFixed(1)}%',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _primaryBlue,
          ),
        ),
        Text(
          '$count suara',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

/// A tappable card representing a single sports option in the poll.
///
/// Displays the option text with a radio-like indicator on the left and a
/// checkmark when selected. Visual state changes based on [isSelected] and
/// [isDisabled]:
///
/// - **Unselected**: white background, grey border, grey text.
/// - **Selected**: light-purple background, purple border, purple text, checkmark.
/// - **Disabled**: grey background, grey border, grey text, no tap response.
///
/// Selection state is managed by the parent widget; this is a pure
/// [StatelessWidget] that calls [onTap] when tapped and not disabled.
///
/// Requirements: 4.1, 4.5, 5.5
class PollOptionCard extends StatelessWidget {
  // ---------------------------------------------------------------------------
  // Constants
  // ---------------------------------------------------------------------------

  static const Color _accentPurple = Color(0xFF7B1FA2);
  static const Color _selectedBackground = Color(0xFFF3E5F5);
  static const Color _disabledBackground = Color(0xFFF5F5F5);
  static const Color _unselectedBackground = Colors.white;

  static const Color _selectedBorder = Color(0xFF7B1FA2);
  static const Color _disabledBorder = Color(0xFFBDBDBD);
  static const Color _unselectedBorder = Color(0xFFBDBDBD);

  static const Color _selectedText = Color(0xFF7B1FA2);
  static const Color _disabledText = Color(0xFF9E9E9E);
  static const Color _unselectedText = Color(0xFF424242);

  // ---------------------------------------------------------------------------
  // Properties
  // ---------------------------------------------------------------------------

  /// The sports option text to display (e.g. "Badminton").
  final String optionText;

  /// Zero-based index of this option within the poll (0–4).
  final int optionIndex;

  /// Whether this option is currently selected by the user.
  final bool isSelected;

  /// Whether voting has been disabled (e.g. after the user has already voted).
  /// When true the card ignores taps and renders in a greyed-out style.
  final bool isDisabled;

  /// Called when the user taps this card while it is not disabled.
  final VoidCallback? onTap;

  const PollOptionCard({
    super.key,
    required this.optionText,
    required this.optionIndex,
    required this.isSelected,
    required this.isDisabled,
    this.onTap,
  });

  // ---------------------------------------------------------------------------
  // Derived styling helpers
  // ---------------------------------------------------------------------------

  Color get _backgroundColor {
    if (isDisabled) return _disabledBackground;
    if (isSelected) return _selectedBackground;
    return _unselectedBackground;
  }

  Color get _borderColor {
    if (isDisabled) return _disabledBorder;
    if (isSelected) return _selectedBorder;
    return _unselectedBorder;
  }

  Color get _textColor {
    if (isDisabled) return _disabledText;
    if (isSelected) return _selectedText;
    return _unselectedText;
  }

  double get _borderWidth => isSelected ? 2.0 : 1.0;

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: optionText,
      selected: isSelected,
      enabled: !isDisabled,
      button: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _borderColor,
            width: _borderWidth,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: _accentPurple.withOpacity(0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: isDisabled ? null : onTap,
            splashColor: _accentPurple.withOpacity(0.12),
            highlightColor: _accentPurple.withOpacity(0.06),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Row(
                children: [
                  _buildRadioIndicator(),
                  const SizedBox(width: 12),
                  _buildSportsIcon(),
                  const SizedBox(width: 10),
                  Expanded(child: _buildOptionText()),
                  if (isSelected) _buildCheckmark(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Sub-builders
  // ---------------------------------------------------------------------------

  /// A radio-button-like circle indicator on the left side of the card.
  Widget _buildRadioIndicator() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? _accentPurple : _borderColor,
          width: isSelected ? 2.0 : 1.5,
        ),
        color: isSelected ? _accentPurple : Colors.transparent,
      ),
      child: isSelected
          ? const Center(
              child: Icon(
                Icons.circle,
                size: 10,
                color: Colors.white,
              ),
            )
          : null,
    );
  }

  /// A small sports icon to the left of the option text.
  Widget _buildSportsIcon() {
    return Icon(
      _sportsIconForIndex(optionIndex),
      size: 20,
      color: _textColor,
    );
  }

  Widget _buildOptionText() {
    return Text(
      optionText,
      style: TextStyle(
        fontSize: 15,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        color: _textColor,
      ),
    );
  }

  /// A checkmark icon shown on the right when the option is selected.
  Widget _buildCheckmark() {
    return const Icon(
      Icons.check_circle,
      size: 20,
      color: _accentPurple,
    );
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
}

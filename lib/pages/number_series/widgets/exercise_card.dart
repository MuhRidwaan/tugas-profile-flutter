import 'package:flutter/material.dart';

/// A card widget for selecting a number series exercise.
///
/// Displays a gradient card with an icon, title, description, a Loop_Badge
/// showing the loop type used in the exercise, and a forward arrow.
/// Follows the same design as `_FeatureCard` in `explore_page.dart`.
class ExerciseCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  /// The loop type label shown in the badge (e.g. 'for', 'while', 'do-while').
  final String loopType;
  final VoidCallback onTap;

  const ExerciseCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.loopType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(width: 16),
              // Title, description, and Loop_Badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF757575),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Loop_Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Loop: $loopType',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Arrow indicator
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: color.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

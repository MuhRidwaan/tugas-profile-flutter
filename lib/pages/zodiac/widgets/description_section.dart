import 'package:flutter/material.dart';
import '../../zodiac/constants/zodiac_constants.dart';

class DescriptionSection extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const DescriptionSection({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (content.trim().isEmpty) return const SizedBox.shrink();

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Color(0xFFF9FAFC),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ZodiacConstants.primaryColor.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: ZodiacConstants.primaryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: ZodiacConstants.headerStyle.copyWith(
                    color: const Color(0xFF2C3E50),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                content,
                style: ZodiacConstants.bodyStyle.copyWith(
                  fontSize: 15,
                  color: const Color(0xFF555555),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

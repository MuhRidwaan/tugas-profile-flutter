import 'package:flutter/material.dart';
import '../../zodiac/constants/zodiac_constants.dart';

class ZodiacResultCard extends StatelessWidget {
  final String namaZodiac;
  final String dateRangeFormatted;

  const ZodiacResultCard({
    super.key,
    required this.namaZodiac,
    required this.dateRangeFormatted,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ZodiacConstants.cardBorderRadius),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ZodiacConstants.cardBorderRadius),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1565C0),
              Color(0xFF7B1FA2),
            ],
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    namaZodiac,
                    style: ZodiacConstants.titleStyle.copyWith(
                      color: Colors.white,
                      fontSize: 32,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.white70,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        dateRangeFormatted,
                        style: ZodiacConstants.subtitleStyle.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.star,
                color: Colors.amber,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

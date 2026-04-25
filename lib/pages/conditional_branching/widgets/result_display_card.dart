import 'package:flutter/material.dart';

/// Widget to display max/min calculation results
class ResultDisplayCard extends StatelessWidget {
  final double? maxValue;
  final double? minValue;
  final bool isEqual;

  const ResultDisplayCard({
    super.key,
    this.maxValue,
    this.minValue,
    required this.isEqual,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1565C0).withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Hasil Perhitungan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 16),
          if (isEqual) ...[
            const Icon(
              Icons.check_circle,
              size: 48,
              color: Color(0xFF1565C0),
            ),
            const SizedBox(height: 8),
            const Text(
              'Kedua bilangan sama',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              ),
            ),
          ] else ...[
            _buildResultRow(
              'Nilai Maksimal',
              maxValue?.toString() ?? '0',
              Icons.arrow_upward,
              const Color(0xFF2E7D32),
            ),
            const SizedBox(height: 16),
            _buildResultRow(
              'Nilai Minimal',
              minValue?.toString() ?? '0',
              Icons.arrow_downward,
              const Color(0xFFD32F2F),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResultRow(
      String label, String value, IconData icon, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF757575),
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

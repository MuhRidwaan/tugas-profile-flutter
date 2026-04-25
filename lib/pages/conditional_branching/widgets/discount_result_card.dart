import 'package:flutter/material.dart';
import '../utils/formatting_utils.dart';

/// Widget to display discount calculation results
class DiscountResultCard extends StatelessWidget {
  final double originalAmount;
  final double discountRate;
  final double discountAmount;
  final double finalPayment;

  const DiscountResultCard({
    super.key,
    required this.originalAmount,
    required this.discountRate,
    required this.discountAmount,
    required this.finalPayment,
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
            color: const Color(0xFF7B1FA2).withOpacity(0.2),
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
          _buildResultRow(
            'Jumlah Awal',
            formatCurrency(originalAmount),
            const Color(0xFF424242),
          ),
          const Divider(height: 24),
          _buildResultRow(
            'Persentase Diskon',
            formatPercentage(discountRate),
            const Color(0xFF7B1FA2),
          ),
          const SizedBox(height: 12),
          _buildResultRow(
            'Jumlah Diskon',
            formatCurrency(discountAmount),
            const Color(0xFFFF6F00),
          ),
          const Divider(height: 24),
          _buildResultRow(
            'Total Bayar',
            formatCurrency(finalPayment),
            const Color(0xFF2E7D32),
            isHighlighted: true,
          ),
        ],
      ),
    );
  }

  Widget _buildResultRow(
    String label,
    String value,
    Color color, {
    bool isHighlighted = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isHighlighted ? 18 : 16,
            fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.normal,
            color: const Color(0xFF757575),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isHighlighted ? 24 : 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

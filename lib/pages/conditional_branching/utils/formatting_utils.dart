import 'package:intl/intl.dart';

/// Formats a numeric value as Indonesian Rupiah currency
/// Returns formatted string with "Rp" prefix, thousand separators, and no decimal places
String formatCurrency(double value) {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );
  return formatter.format(value);
}

/// Formats a decimal rate as a percentage
/// Returns formatted string with "%" suffix
String formatPercentage(double rate) {
  return '${(rate * 100).toStringAsFixed(0)}%';
}

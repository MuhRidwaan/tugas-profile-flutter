import '../models/validation_result.dart';

/// Validates numeric input with optional negative value support
/// Returns ValidationResult indicating whether input is valid
ValidationResult validateNumericInput(
  String input, {
  bool allowNegative = true,
}) {
  if (input.trim().isEmpty) {
    return ValidationResult.invalid('Field tidak boleh kosong');
  }

  final number = double.tryParse(input);
  if (number == null) {
    return ValidationResult.invalid('Input harus berupa angka');
  }

  if (!allowNegative && number <= 0) {
    return ValidationResult.invalid('Nilai harus lebih dari 0');
  }

  return ValidationResult.valid();
}

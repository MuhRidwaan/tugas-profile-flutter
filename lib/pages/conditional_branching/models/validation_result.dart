/// Result of input validation
class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  const ValidationResult({
    required this.isValid,
    this.errorMessage,
  });

  /// Factory constructor for valid input
  factory ValidationResult.valid() => const ValidationResult(isValid: true);

  /// Factory constructor for invalid input with error message
  factory ValidationResult.invalid(String message) =>
      ValidationResult(isValid: false, errorMessage: message);
}

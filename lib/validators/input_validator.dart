class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  ValidationResult({required this.isValid, this.errorMessage});
}

class InputValidator {
  ValidationResult validateZodiacName(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      return ValidationResult(
        isValid: false,
        errorMessage: 'Nama zodiak tidak boleh kosong.',
      );
    }
    // Reject if it has non-alphabetic characters
    final regExp = RegExp(r'^[a-zA-Z]+$');
    if (!regExp.hasMatch(trimmed)) {
      return ValidationResult(
        isValid: false,
        errorMessage: 'Nama zodiak hanya boleh berisi huruf.',
      );
    }
    return ValidationResult(isValid: true);
  }

  ValidationResult validateDate(int? day, int? month) {
    if (day == null || month == null) {
      return ValidationResult(
        isValid: false,
        errorMessage: 'Pilih tanggal dan bulan lahir Anda.',
      );
    }

    if (month < 1 || month > 12) {
      return ValidationResult(
        isValid: false,
        errorMessage: 'Bulan harus di antara 1 sampai 12.',
      );
    }

    // Determine days in that month
    int maxDays;
    switch (month) {
      case 2:
        maxDays = 29; // allow 29 for leap year
        break;
      case 4:
      case 6:
      case 9:
      case 11:
        maxDays = 30;
        break;
      default:
        maxDays = 31;
    }

    if (day < 1 || day > maxDays) {
      return ValidationResult(
        isValid: false,
        errorMessage: 'Hari tidak valid untuk bulan yang dipilih (1-$maxDays).',
      );
    }

    return ValidationResult(isValid: true);
  }

  String sanitizeInput(String input) {
    var sanitized = input.trim();
    // Escape single quotes
    sanitized = sanitized.replaceAll("'", "''");
    // Remove SQL comment characters
    sanitized = sanitized.replaceAll('--', '');
    sanitized = sanitized.replaceAll('/*', '');
    sanitized = sanitized.replaceAll('*/', '');
    // Remove query chain character
    sanitized = sanitized.replaceAll(';', '');
    return sanitized;
  }
}

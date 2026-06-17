import 'package:flutter/material.dart';

class ZodiacConstants {
  // Theme Colors
  static const Color primaryColor = Color(0xFF1565C0);
  static const Color accentColor = Color(0xFF7B1FA2);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color backgroundColor = Color(0xFFF5F7FA);

  // Spacing & Design
  static const double defaultPadding = 16.0;
  static const double cardBorderRadius = 16.0;

  // Text Styles
  static const TextStyle titleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Color(0xFF212121),
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 16,
    color: Color(0xFF757575),
    fontWeight: FontWeight.w500,
  );

  static const TextStyle headerStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    height: 1.5,
    color: Color(0xFF37474F),
  );

  // Strings & Error Messages
  static const String appTitle = 'Informasi Zodiak';
  static const String searchHint = 'Masukkan nama zodiak (cth: Aries)';
  static const String searchButtonText = 'Cari Zodiak';
  static const String dateSearchButtonText = 'Tentukan Zodiak';
  static const String emptyStateText = 'Cari zodiak berdasarkan nama atau pilih tanggal lahir Anda untuk memulai.';
  static const String notFoundText = 'Zodiak tidak ditemukan. Silakan periksa kembali ejaan Anda.';
  static const String invalidDateText = 'Tanggal lahir tidak valid. Harap periksa hari dan bulan.';
  static const String connectionErrorText = 'Terjadi kesalahan sistem. Silakan coba beberapa saat lagi.';
}

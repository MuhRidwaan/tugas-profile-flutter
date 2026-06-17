import 'package:flutter/material.dart';
import '../database/app_database.dart';

class ZodiacDescriptionSection {
  final String title;
  final String content;
  final IconData icon;

  ZodiacDescriptionSection({
    required this.title,
    required this.content,
    required this.icon,
  });
}

class ZodiacQueryResult {
  final ZodiacData zodiac;
  final String dateRangeFormatted;
  final List<ZodiacDescriptionSection> sections;

  ZodiacQueryResult({
    required this.zodiac,
    required this.dateRangeFormatted,
    required this.sections,
  });

  factory ZodiacQueryResult.fromData(ZodiacData data) {
    final monthsIndo = {
      1: 'Jan',
      2: 'Feb',
      3: 'Mar',
      4: 'Apr',
      5: 'Mei',
      6: 'Jun',
      7: 'Jul',
      8: 'Agu',
      9: 'Sep',
      10: 'Okt',
      11: 'Nov',
      12: 'Des',
    };

    final startDay = data.tanggalAwal.day;
    final startMonth = monthsIndo[data.tanggalAwal.month] ?? '';
    final endDay = data.tanggalAkhir.day;
    final endMonth = monthsIndo[data.tanggalAkhir.month] ?? '';

    final dateRangeFormatted = '$startDay $startMonth - $endDay $endMonth';

    final sections = <ZodiacDescriptionSection>[
      ZodiacDescriptionSection(
        title: 'Asmara & Hubungan',
        content: data.deskripsiAsmara,
        icon: Icons.favorite,
      ),
      ZodiacDescriptionSection(
        title: 'Karier & Finansial',
        content: data.deskripsiKarir,
        icon: Icons.work,
      ),
    ];

    // Nullable flexible fields
    if (data.deskripsiKepribadian != null && data.deskripsiKepribadian!.trim().isNotEmpty) {
      sections.add(
        ZodiacDescriptionSection(
          title: 'Kepribadian & Sifat',
          content: data.deskripsiKepribadian!,
          icon: Icons.psychology,
        ),
      );
    }

    if (data.deskripsiKesehatan != null && data.deskripsiKesehatan!.trim().isNotEmpty) {
      sections.add(
        ZodiacDescriptionSection(
          title: 'Kesehatan & Energi',
          content: data.deskripsiKesehatan!,
          icon: Icons.health_and_safety,
        ),
      );
    }

    return ZodiacQueryResult(
      zodiac: data,
      dateRangeFormatted: dateRangeFormatted,
      sections: sections,
    );
  }
}

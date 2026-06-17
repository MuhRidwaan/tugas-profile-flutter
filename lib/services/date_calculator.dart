class DateCalculator {
  // Static list of zodiac signs and their date ranges for fast calculation.
  static const List<Map<String, dynamic>> _zodiacRanges = [
    {
      'name': 'Capricorn',
      'startMonth': 12,
      'startDay': 22,
      'endMonth': 1,
      'endDay': 19,
    },
    {
      'name': 'Aquarius',
      'startMonth': 1,
      'startDay': 20,
      'endMonth': 2,
      'endDay': 18,
    },
    {
      'name': 'Pisces',
      'startMonth': 2,
      'startDay': 19,
      'endMonth': 3,
      'endDay': 20,
    },
    {
      'name': 'Aries',
      'startMonth': 3,
      'startDay': 21,
      'endMonth': 4,
      'endDay': 19,
    },
    {
      'name': 'Taurus',
      'startMonth': 4,
      'startDay': 20,
      'endMonth': 5,
      'endDay': 20,
    },
    {
      'name': 'Gemini',
      'startMonth': 5,
      'startDay': 21,
      'endMonth': 6,
      'endDay': 20,
    },
    {
      'name': 'Cancer',
      'startMonth': 6,
      'startDay': 21,
      'endMonth': 7,
      'endDay': 22,
    },
    {
      'name': 'Leo',
      'startMonth': 7,
      'startDay': 23,
      'endMonth': 8,
      'endDay': 22,
    },
    {
      'name': 'Virgo',
      'startMonth': 8,
      'startDay': 23,
      'endMonth': 9,
      'endDay': 22,
    },
    {
      'name': 'Libra',
      'startMonth': 9,
      'startDay': 23,
      'endMonth': 10,
      'endDay': 22,
    },
    {
      'name': 'Scorpio',
      'startMonth': 10,
      'startDay': 23,
      'endMonth': 11,
      'endDay': 21,
    },
    {
      'name': 'Sagittarius',
      'startMonth': 11,
      'startDay': 22,
      'endMonth': 12,
      'endDay': 21,
    },
  ];

  int getDaysInMonth(int month) {
    switch (month) {
      case 2:
        return 29; // allow 29 for year-agnostic leap year
      case 4:
      case 6:
      case 9:
      case 11:
        return 30;
      default:
        return 31;
    }
  }

  bool isValidDate(int day, int month) {
    if (month < 1 || month > 12) return false;
    final maxDays = getDaysInMonth(month);
    return day >= 1 && day <= maxDays;
  }

  String? determineZodiacSign(int day, int month) {
    if (!isValidDate(day, month)) return null;

    for (final range in _zodiacRanges) {
      final startMonth = range['startMonth'] as int;
      final startDay = range['startDay'] as int;
      final endMonth = range['endMonth'] as int;
      final endDay = range['endDay'] as int;

      if (isDateInRangeStatic(day, month, startMonth, startDay, endMonth, endDay)) {
        return range['name'] as String;
      }
    }
    return null;
  }

  bool isDateInRange(int day, int month, DateTime startDate, DateTime endDate) {
    return isDateInRangeStatic(
      day,
      month,
      startDate.month,
      startDate.day,
      endDate.month,
      endDate.day,
    );
  }

  bool isDateInRangeStatic(
    int day,
    int month,
    int startMonth,
    int startDay,
    int endMonth,
    int endDay,
  ) {
    if (startMonth == endMonth) {
      return month == startMonth && day >= startDay && day <= endDay;
    } else if (startMonth > endMonth) {
      // Year-spanning range (e.g., Capricorn)
      return (month == startMonth && day >= startDay) ||
             (month == endMonth && day <= endDay);
    } else {
      // Standard range
      return (month == startMonth && day >= startDay) ||
             (month == endMonth && day <= endDay);
    }
  }
}

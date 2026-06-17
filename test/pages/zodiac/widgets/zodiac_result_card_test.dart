import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/pages/zodiac/widgets/zodiac_result_card.dart';

void main() {
  testWidgets('ZodiacResultCard renders name and date range correctly', (WidgetTester tester) async {
    const name = 'Aries';
    const range = '21 Mar - 19 Apr';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ZodiacResultCard(
            namaZodiac: name,
            dateRangeFormatted: range,
          ),
        ),
      ),
    );

    expect(find.text(name), findsOneWidget);
    expect(find.text(range), findsOneWidget);
    expect(find.byIcon(Icons.star), findsOneWidget);
  });
}

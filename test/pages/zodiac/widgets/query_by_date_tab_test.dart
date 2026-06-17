import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/database/app_database.dart';
import 'package:profile_tugas/services/zodiac_service.dart';
import 'package:profile_tugas/pages/zodiac/widgets/query_by_date_tab.dart';

void main() {
  late AppDatabase database;
  late ZodiacService service;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    service = ZodiacService(database);
  });

  tearDown(() async {
    await database.close();
  });

  testWidgets('QueryByDateTab search flow - validation error, success search by date', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: QueryByDateTab(service: service),
        ),
      ),
    );

    // Initial state shows start info text
    expect(find.text('Cari zodiak berdasarkan nama atau pilih tanggal lahir Anda untuk memulai.'), findsOneWidget);

    // Click search without selecting date
    await tester.tap(find.byIcon(Icons.calendar_today));
    await tester.pumpAndSettle();

    // Should show validation error message
    expect(find.text('Pilih tanggal dan bulan lahir Anda.'), findsOneWidget);

    // Let's select Day 25 and Month December (Month 12)
    // Find dropdown for Day and select 25
    await tester.tap(find.byKey(const Key('day-dropdown')));
    await tester.pumpAndSettle();
    
    // Select day 25
    await tester.tap(find.text('25').last);
    await tester.pumpAndSettle();

    // Find dropdown for Month and select Desember (Month 12)
    await tester.tap(find.byKey(const Key('month-dropdown')));
    await tester.pumpAndSettle();

    // Select Desember
    await tester.tap(find.text('Desember').last);
    await tester.pumpAndSettle();

    // Click search
    await tester.tap(find.byIcon(Icons.calendar_today));
    await tester.pumpAndSettle(); // Finish lookup

    // Should render result card for Capricorn (since 25 Dec is Capricorn)
    expect(find.text('Capricorn'), findsOneWidget);
    expect(find.text('Asmara & Hubungan'), findsOneWidget);
    expect(find.text('Karier & Finansial'), findsOneWidget);
  });
}

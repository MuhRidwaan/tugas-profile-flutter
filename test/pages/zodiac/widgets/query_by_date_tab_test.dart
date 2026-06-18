import 'dart:ffi';
import 'dart:io';
import 'package:sqlite3/open.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/database/app_database.dart';
import 'package:profile_tugas/services/zodiac_service.dart';
import 'package:profile_tugas/pages/zodiac/widgets/query_by_date_tab.dart';

void main() {
  open.overrideFor(OperatingSystem.windows, () {
    return DynamicLibrary.open(p.join(Directory.current.path, 'sqlite3.dll'));
  });

  testWidgets('QueryByDateTab search flow - validation error, success search by date', (WidgetTester tester) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final service = ZodiacService(database);

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

    // Let's select Day 5 and Month Maret (Month 3)
    // Find dropdown for Day and select 5
    await tester.tap(find.byType(DropdownButton<int>).first);
    await tester.pumpAndSettle();
    
    // Select day 5
    await tester.tap(find.text('5').last);
    await tester.pumpAndSettle();

    // Find dropdown for Month and select Maret (Month 3)
    await tester.tap(find.byType(DropdownButton<int>).last);
    await tester.pumpAndSettle();

    // Select Maret
    await tester.tap(find.text('Maret').last);
    await tester.pumpAndSettle();

    // Click search
    await tester.tap(find.byIcon(Icons.calendar_today));
    await tester.pumpAndSettle(); // Finish lookup

    // Should render result card for Pisces (since 5 Mar is Pisces)
    expect(find.text('Pisces'), findsOneWidget);
    expect(find.text('Asmara & Hubungan'), findsOneWidget);
    expect(find.text('Karier & Finansial'), findsOneWidget);

    await database.close();
  });
}

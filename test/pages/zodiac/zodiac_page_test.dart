import 'dart:ffi';
import 'dart:io';
import 'package:sqlite3/open.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/database/app_database.dart';
import 'package:profile_tugas/services/zodiac_service.dart';
import 'package:profile_tugas/pages/zodiac/zodiac_page.dart';

void main() {
  open.overrideFor(OperatingSystem.windows, () {
    return DynamicLibrary.open(p.join(Directory.current.path, 'sqlite3.dll'));
  });

  testWidgets('ZodiacPage end-to-end flow and tab switching', (WidgetTester tester) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final service = ZodiacService(database);

    await tester.pumpWidget(
      MaterialApp(
        home: ZodiacPage(service: service, database: database),
      ),
    );

    // Verify Title is present
    expect(find.text('Informasi Zodiak'), findsOneWidget);

    // Verify Tab names are present
    expect(find.text('Nama Zodiak'), findsOneWidget);
    expect(find.text('Tanggal Lahir'), findsOneWidget);

    // Default tab is Name Search. Verify it has TextField
    expect(find.byType(TextField), findsOneWidget);

    // Switch tab to Date Search
    await tester.tap(find.text('Tanggal Lahir'));
    await tester.pumpAndSettle();

    // Verify dropdown hints are shown
    expect(find.text('Tanggal'), findsOneWidget);
    expect(find.text('Bulan'), findsOneWidget);

    // Switch back to Name Search tab
    await tester.tap(find.text('Nama Zodiak'));
    await tester.pumpAndSettle();

    // Verify TextField is back
    expect(find.byType(TextField), findsOneWidget);

    // Enter name "Aries" and tap Search
    await tester.enterText(find.byType(TextField), 'Aries');
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Result card for Aries should be shown
    expect(find.text('Aries'), findsWidgets);
    expect(find.text('Asmara & Hubungan'), findsOneWidget);

    await database.close();
  });
}

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/database/app_database.dart';
import 'package:profile_tugas/services/zodiac_service.dart';
import 'package:profile_tugas/pages/zodiac/widgets/query_by_name_tab.dart';

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

  testWidgets('QueryByNameTab search flow - validation error, success search', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: QueryByNameTab(service: service),
        ),
      ),
    );

    // Initial state shows start info text
    expect(find.text('Cari zodiak berdasarkan nama atau pilih tanggal lahir Anda untuk memulai.'), findsOneWidget);

    // Enter empty name and click search
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Should show validation error message
    expect(find.text('Nama zodiak tidak boleh kosong.'), findsOneWidget);

    // Enter invalid name with numbers
    await tester.enterText(find.byType(TextField), 'Aries123');
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.text('Nama zodiak hanya boleh berisi huruf.'), findsOneWidget);

    // Enter valid name "Aries"
    await tester.enterText(find.byType(TextField), 'Aries');
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle(); // Finish lookup

    // Should render result card
    expect(find.text('Aries'), findsWidgets); // TextField value + ResultCard header
    expect(find.text('Asmara & Hubungan'), findsOneWidget);
    expect(find.text('Karier & Finansial'), findsOneWidget);
  });
}

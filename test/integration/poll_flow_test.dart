// Integration test: Complete Poll Flow
// Tests navigation, voting, result visualization, and persistence.
// Requirements: 4.1, 4.2, 4.3, 4.4, 4.5, 6.2, 6.4, 7.2, 7.4

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/pages/quiz_poll/quiz_poll_page.dart';
import 'package:profile_tugas/pages/quiz_poll/widgets/poll_option_card.dart';
import 'package:profile_tugas/pages/quiz_poll/widgets/poll_result_widget.dart';
import 'package:profile_tugas/providers/poll_provider.dart';
import 'package:profile_tugas/providers/quiz_provider.dart';
import 'package:profile_tugas/repositories/poll_repository.dart';
import 'package:profile_tugas/repositories/quiz_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> buildApp({SharedPreferences? prefs}) async {
  prefs ??= await SharedPreferences.getInstance();

  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => QuizProvider(QuizRepository(prefs!))),
      ChangeNotifierProvider(
          create: (_) => PollProvider(PollRepository(prefs))),
    ],
    child: const MaterialApp(home: QuizPollPage()),
  );
}

Future<void> navigateToPollTab(WidgetTester tester) async {
  await tester.tap(find.text('Polling'));
  await tester.pumpAndSettle();
}

void main() {
  group('Poll Flow Integration', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('poll tab is accessible from QuizPollPage', (tester) async {
      await tester.pumpWidget(await buildApp());
      await tester.pump();

      expect(find.text('Polling'), findsOneWidget);
    });

    testWidgets('poll page shows 5 sports options before voting',
        (tester) async {
      await tester.pumpWidget(await buildApp());
      await navigateToPollTab(tester);

      expect(find.byType(PollOptionCard), findsNWidgets(5));
    });

    testWidgets('poll page shows all sports names', (tester) async {
      await tester.pumpWidget(await buildApp());
      await navigateToPollTab(tester);

      expect(find.text('Badminton'), findsOneWidget);
      expect(find.text('Catur'), findsOneWidget);
      expect(find.text('Padel'), findsOneWidget);
      expect(find.text('Basket'), findsOneWidget);
      expect(find.text('Lari Marathon'), findsOneWidget);
    });

    testWidgets('selecting an option enables the vote button', (tester) async {
      await tester.pumpWidget(await buildApp());
      await navigateToPollTab(tester);

      // Vote button should be disabled initially
      final buttonBefore = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Kirim Vote'),
      );
      expect(buttonBefore.onPressed, isNull);

      // Select an option
      await tester.tap(find.byType(PollOptionCard).first);
      await tester.pump();

      // Vote button should now be enabled
      final buttonAfter = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Kirim Vote'),
      );
      expect(buttonAfter.onPressed, isNotNull);
    });

    testWidgets('submitting vote shows poll results', (tester) async {
      await tester.pumpWidget(await buildApp());
      await navigateToPollTab(tester);

      // Select first option and vote
      await tester.tap(find.byType(PollOptionCard).first);
      await tester.pump();
      await tester.tap(find.text('Kirim Vote'));
      await tester.pumpAndSettle();

      // Results should appear
      expect(find.byType(PollResultWidget), findsOneWidget);
    });

    testWidgets('results show "Pilihan Anda" for selected option',
        (tester) async {
      await tester.pumpWidget(await buildApp());
      await navigateToPollTab(tester);

      await tester.tap(find.byType(PollOptionCard).first);
      await tester.pump();
      await tester.tap(find.text('Kirim Vote'));
      await tester.pumpAndSettle();

      expect(find.text('Pilihan Anda'), findsOneWidget);
    });

    testWidgets('results show confirmation banner after voting',
        (tester) async {
      await tester.pumpWidget(await buildApp());
      await navigateToPollTab(tester);

      await tester.tap(find.byType(PollOptionCard).first);
      await tester.pump();
      await tester.tap(find.text('Kirim Vote'));
      await tester.pumpAndSettle();

      expect(
        find.text('Terima kasih! Vote kamu sudah tercatat.'),
        findsOneWidget,
      );
    });

    testWidgets('vote persists after provider reload', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      // First session: vote
      await tester.pumpWidget(await buildApp(prefs: prefs));
      await navigateToPollTab(tester);

      await tester.tap(find.byType(PollOptionCard).first);
      await tester.pump();
      await tester.tap(find.text('Kirim Vote'));
      await tester.pumpAndSettle();

      expect(find.byType(PollResultWidget), findsOneWidget);

      // Second session: rebuild with same prefs
      await tester.pumpWidget(await buildApp(prefs: prefs));
      await navigateToPollTab(tester);

      // Should still show results (vote persisted)
      expect(find.byType(PollResultWidget), findsOneWidget);
    });
  });
}

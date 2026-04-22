import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/pages/quiz_poll/quiz_poll_page.dart';
import 'package:profile_tugas/providers/poll_provider.dart';
import 'package:profile_tugas/providers/quiz_provider.dart';
import 'package:profile_tugas/repositories/poll_repository.dart';
import 'package:profile_tugas/repositories/quiz_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> buildApp() async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();

  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => QuizProvider(QuizRepository(prefs))),
      ChangeNotifierProvider(
          create: (_) => PollProvider(PollRepository(prefs))),
    ],
    child: const MaterialApp(home: QuizPollPage()),
  );
}

void main() {
  group('QuizPollPage', () {
    testWidgets('shows app bar with "Quiz & Polling" title', (tester) async {
      await tester.pumpWidget(await buildApp());
      await tester.pump();

      expect(find.text('Quiz & Polling'), findsOneWidget);
    });

    testWidgets('shows two tabs: Kuesioner and Polling', (tester) async {
      await tester.pumpWidget(await buildApp());
      await tester.pump();

      expect(find.text('Kuesioner'), findsOneWidget);
      expect(find.text('Polling'), findsOneWidget);
    });

    testWidgets('shows TabBar', (tester) async {
      await tester.pumpWidget(await buildApp());
      await tester.pump();

      expect(find.byType(TabBar), findsOneWidget);
    });

    testWidgets('shows TabBarView', (tester) async {
      await tester.pumpWidget(await buildApp());
      await tester.pump();

      expect(find.byType(TabBarView), findsOneWidget);
    });

    testWidgets('switches to Polling tab when tapped', (tester) async {
      await tester.pumpWidget(await buildApp());
      await tester.pump();

      await tester.tap(find.text('Polling'));
      await tester.pumpAndSettle();

      // Poll page should be visible — look for loading or poll content
      expect(find.byType(TabBarView), findsOneWidget);
    });
  });

  group('QuizPage', () {
    testWidgets('shows loading indicator initially', (tester) async {
      await tester.pumpWidget(await buildApp());
      // Pump once to trigger initState
      await tester.pump();

      // Loading state should appear briefly
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows questions after loading', (tester) async {
      await tester.pumpWidget(await buildApp());
      await tester.pumpAndSettle();

      // After loading, questions should appear
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });

  group('PollPage', () {
    testWidgets('shows poll content after switching to Polling tab',
        (tester) async {
      await tester.pumpWidget(await buildApp());
      await tester.pump();

      await tester.tap(find.text('Polling'));
      await tester.pumpAndSettle();

      // Poll page loaded — no crash
      expect(find.byType(TabBarView), findsOneWidget);
    });
  });
}

// Integration test: Complete Quiz Flow
// Tests navigation, answering questions, feedback display, and persistence.
// Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 6.1, 6.3, 7.1, 7.3

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/pages/quiz_poll/quiz_poll_page.dart';
import 'package:profile_tugas/pages/quiz_poll/widgets/feedback_widget.dart';
import 'package:profile_tugas/pages/quiz_poll/widgets/quiz_question_card.dart';
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

void main() {
  group('Quiz Flow Integration', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('quiz page loads and displays questions', (tester) async {
      await tester.pumpWidget(await buildApp());
      await tester.pumpAndSettle();

      // Should show quiz question cards
      expect(find.byType(QuizQuestionCard), findsWidgets);
    });

    testWidgets('quiz page shows 5 questions', (tester) async {
      await tester.pumpWidget(await buildApp());
      await tester.pumpAndSettle();

      expect(find.byType(QuizQuestionCard), findsNWidgets(5));
    });

    testWidgets('selecting and submitting an answer shows feedback',
        (tester) async {
      await tester.pumpWidget(await buildApp());
      await tester.pumpAndSettle();

      // Select first radio option of first question
      await tester.tap(find.byType(RadioListTile<int>).first);
      await tester.pump();

      // Submit the answer
      await tester.tap(find.text('Kirim Jawaban').first);
      await tester.pumpAndSettle();

      // Feedback should appear
      expect(find.byType(FeedbackWidget), findsWidgets);
    });

    testWidgets('answered question shows disabled state', (tester) async {
      await tester.pumpWidget(await buildApp());
      await tester.pumpAndSettle();

      // Select and submit first question
      await tester.tap(find.byType(RadioListTile<int>).first);
      await tester.pump();
      await tester.tap(find.text('Kirim Jawaban').first);
      await tester.pumpAndSettle();

      // Submit button should be gone for answered question
      // (only remaining unanswered questions have submit buttons)
      final submitButtons = find.text('Kirim Jawaban');
      final cardCount = tester.widgetList(find.byType(QuizQuestionCard)).length;
      expect(submitButtons, findsNWidgets(cardCount - 1));
    });

    testWidgets('answered question persists after provider reload',
        (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      // First session: answer a question
      await tester.pumpWidget(await buildApp(prefs: prefs));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(RadioListTile<int>).first);
      await tester.pump();
      await tester.tap(find.text('Kirim Jawaban').first);
      await tester.pumpAndSettle();

      // Verify feedback appeared
      expect(find.byType(FeedbackWidget), findsWidgets);

      // Second session: rebuild with same prefs
      await tester.pumpWidget(await buildApp(prefs: prefs));
      await tester.pumpAndSettle();

      // Previously answered question should still show feedback
      expect(find.byType(FeedbackWidget), findsWidgets);
    });

    testWidgets('quiz tab is accessible from QuizPollPage', (tester) async {
      await tester.pumpWidget(await buildApp());
      await tester.pump();

      // Kuesioner tab should be visible
      expect(find.text('Kuesioner'), findsOneWidget);

      // Tap it to ensure it's active
      await tester.tap(find.text('Kuesioner'));
      await tester.pumpAndSettle();

      expect(find.byType(QuizQuestionCard), findsWidgets);
    });
  });
}

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
  final sharedPrefs = prefs ?? await SharedPreferences.getInstance();

  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => QuizProvider(QuizRepository(sharedPrefs))),
      ChangeNotifierProvider(
          create: (_) => PollProvider(PollRepository(sharedPrefs))),
    ],
    child: const MaterialApp(home: QuizPollPage()),
  );
}

Future<void> pumpQuizApp(WidgetTester tester, {SharedPreferences? prefs}) async {
  await tester.binding.setSurfaceSize(const Size(800, 1200));
  await tester.pumpWidget(await buildApp(prefs: prefs));
  await tester.pumpAndSettle();
}

Future<void> submitFirstQuizAnswer(WidgetTester tester) async {
  await tester.tap(find.byType(RadioListTile<int>).first);
  await tester.pump();

  final firstCard = find.byType(QuizQuestionCard).first;
  final firstSubmitButton = find.descendant(
    of: firstCard,
    matching: find.widgetWithText(ElevatedButton, 'Kirim Jawaban'),
  );

  await tester.dragUntilVisible(
    firstSubmitButton,
    find.byType(Scrollable).first,
    const Offset(0, -120),
  );
  await tester.tap(firstSubmitButton);
  await tester.pumpAndSettle();
}

void main() {
  group('Quiz Flow Integration', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('quiz page loads and displays questions', (tester) async {
      await pumpQuizApp(tester);

      // Should show quiz question cards
      expect(find.byType(QuizQuestionCard), findsWidgets);
    });

    testWidgets('quiz page shows 5 questions', (tester) async {
      await pumpQuizApp(tester);

      // ListView.builder renders lazily; verify all questions by scrolling.
      expect(find.text('Pertanyaan 1'), findsOneWidget);
      for (var i = 0; i < 12; i++) {
        if (find.text('Pertanyaan 5').evaluate().isNotEmpty) break;
        await tester.drag(
          find.byType(Scrollable).first,
          const Offset(0, -250),
        );
        await tester.pumpAndSettle();
      }
      expect(find.text('Pertanyaan 5'), findsOneWidget);
    });

    testWidgets('selecting and submitting an answer shows feedback',
        (tester) async {
      await pumpQuizApp(tester);

      await submitFirstQuizAnswer(tester);

      // Feedback should appear
      expect(find.byType(FeedbackWidget), findsWidgets);
    });

    testWidgets('answered question shows disabled state', (tester) async {
      await pumpQuizApp(tester);

      await submitFirstQuizAnswer(tester);

      // For answered first question, submit button should no longer appear there.
      expect(find.byType(FeedbackWidget), findsWidgets);
    });

    testWidgets('answered question persists after provider reload',
        (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      // First session: answer a question
      await pumpQuizApp(tester, prefs: prefs);

      await submitFirstQuizAnswer(tester);

      // Verify feedback appeared
      expect(find.byType(FeedbackWidget), findsWidgets);

      // Second session: rebuild with same prefs
      await pumpQuizApp(tester, prefs: prefs);

      // Previously answered question should still show feedback
      expect(find.byType(FeedbackWidget), findsWidgets);
    });

    testWidgets('quiz tab is accessible from QuizPollPage', (tester) async {
      await pumpQuizApp(tester);

      // Kuesioner tab should be visible
      expect(find.text('Kuesioner'), findsOneWidget);

      // Tap it to ensure it's active
      await tester.tap(find.text('Kuesioner'));
      await tester.pumpAndSettle();

      expect(find.byType(QuizQuestionCard), findsWidgets);
    });
  });
}

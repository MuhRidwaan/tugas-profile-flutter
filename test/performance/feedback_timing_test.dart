import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/pages/quiz_poll/quiz_page.dart';
import 'package:profile_tugas/pages/quiz_poll/widgets/feedback_widget.dart';
import 'package:profile_tugas/providers/quiz_provider.dart';
import 'package:profile_tugas/repositories/quiz_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Performance test for answer feedback timing.
///
/// **Validates: Requirement 8.1** - Answer feedback < 100ms
///
/// This test measures the time from when a user selects an answer to when
/// the feedback widget is displayed. The requirement is that feedback must
/// appear within 100ms.
void main() {
  group('Answer Feedback Timing Performance', () {
    testWidgets(
      'feedback appears within 100ms after answer selection',
      (tester) async {
        // Setup: Initialize SharedPreferences and repository
        SharedPreferences.setMockInitialValues({});
        final prefs = await SharedPreferences.getInstance();
        final repository = QuizRepository(prefs);
        final provider = QuizProvider(repository);

        // Build the quiz page widget
        await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider<QuizProvider>.value(
              value: provider,
              child: const Scaffold(
                body: QuizPage(),
              ),
            ),
          ),
        );

        // Wait for initial load
        await tester.pumpAndSettle();

        // Verify we have quiz questions loaded
        expect(find.byType(RadioListTile<int>), findsWidgets);

        // Find the first radio button option
        final firstOption = find.byType(RadioListTile<int>).first;

        // Start timing measurement
        final stopwatch = Stopwatch()..start();

        // Tap the first answer option
        await tester.tap(firstOption);

        // Pump a single frame to allow the answer submission to process
        await tester.pump();

        // Check if FeedbackWidget appears
        final feedbackWidget = find.byType(FeedbackWidget);
        expect(feedbackWidget, findsOneWidget);

        // Stop timing
        stopwatch.stop();

        // Verify the timing requirement: < 100ms
        final elapsedMs = stopwatch.elapsedMilliseconds;
        expect(
          elapsedMs,
          lessThan(100),
          reason: 'Feedback should appear within 100ms, '
              'but took ${elapsedMs}ms',
        );
      },
    );

    testWidgets(
      'feedback widget renders immediately without delay',
      (tester) async {
        // Setup: Initialize SharedPreferences and repository
        SharedPreferences.setMockInitialValues({});
        final prefs = await SharedPreferences.getInstance();
        final repository = QuizRepository(prefs);
        final provider = QuizProvider(repository);

        // Load questions first
        await provider.loadQuestions();

        // Build the quiz page widget
        await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider<QuizProvider>.value(
              value: provider,
              child: const Scaffold(
                body: QuizPage(),
              ),
            ),
          ),
        );

        // Wait for initial load
        await tester.pumpAndSettle();

        // Get the first question
        final firstQuestion = provider.questions.first;

        // Start timing measurement
        final stopwatch = Stopwatch()..start();

        // Submit answer programmatically
        await provider.submitAnswer(firstQuestion.id, [0]);

        // Pump a single frame
        await tester.pump();

        // Stop timing
        stopwatch.stop();

        // Verify feedback widget appears
        expect(find.byType(FeedbackWidget), findsOneWidget);

        // Verify the timing requirement: < 100ms
        final elapsedMs = stopwatch.elapsedMilliseconds;
        expect(
          elapsedMs,
          lessThan(100),
          reason: 'Feedback should render within 100ms, '
              'but took ${elapsedMs}ms',
        );
      },
    );

    testWidgets(
      'multiple feedback widgets render within performance budget',
      (tester) async {
        // Setup: Initialize SharedPreferences and repository
        SharedPreferences.setMockInitialValues({});
        final prefs = await SharedPreferences.getInstance();
        final repository = QuizRepository(prefs);
        final provider = QuizProvider(repository);

        // Build the quiz page widget
        await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider<QuizProvider>.value(
              value: provider,
              child: const Scaffold(
                body: QuizPage(),
              ),
            ),
          ),
        );

        // Wait for initial load
        await tester.pumpAndSettle();

        // Answer multiple questions and measure cumulative time
        final stopwatch = Stopwatch()..start();

        // Find all radio button options
        final radioButtons = find.byType(RadioListTile<int>);
        final buttonCount = radioButtons.evaluate().length;

        // Answer first 3 questions (or all if less than 3)
        final questionsToAnswer = buttonCount < 3 ? buttonCount : 3;

        for (int i = 0; i < questionsToAnswer; i++) {
          await tester.tap(radioButtons.at(i));
          await tester.pump();
        }

        stopwatch.stop();

        // Verify all feedback widgets appear
        expect(
          find.byType(FeedbackWidget),
          findsNWidgets(questionsToAnswer),
        );

        // Verify average time per feedback is < 100ms
        final averageMs = stopwatch.elapsedMilliseconds / questionsToAnswer;
        expect(
          averageMs,
          lessThan(100),
          reason: 'Average feedback time should be < 100ms, '
              'but was ${averageMs.toStringAsFixed(2)}ms',
        );
      },
    );
  });
}

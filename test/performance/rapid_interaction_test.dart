import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/pages/quiz_poll/quiz_poll_page.dart';
import 'package:profile_tugas/providers/poll_provider.dart';
import 'package:profile_tugas/providers/quiz_provider.dart';
import 'package:profile_tugas/repositories/poll_repository.dart';
import 'package:profile_tugas/repositories/quiz_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Stress test for rapid user interactions.
///
/// **Validates: Requirement 8.5** - Test rapid answer selections and navigation.
/// Verify no errors or crashes occur.
///
/// This test simulates rapid user interactions that might occur with impatient
/// users, including:
/// - Multiple quick answer selections
/// - Rapid tab switching between Quiz and Poll tabs
/// - Rapid navigation (back and forth)
/// - Double-tapping scenarios
/// - Rapid answer changes
///
/// The test verifies that the app handles these interactions gracefully without
/// errors, crashes, or UI instability.
void main() {
  group('Rapid Interaction Stress Tests', () {
    late QuizProvider quizProvider;
    late PollProvider pollProvider;

    setUp(() async {
      // Initialize SharedPreferences with mock data
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      // Create repositories and providers
      final quizRepository = QuizRepository(prefs);
      final pollRepository = PollRepository(prefs);

      quizProvider = QuizProvider(quizRepository);
      pollProvider = PollProvider(pollRepository);
    });

    /// Helper function to build the app with providers
    Widget buildTestApp() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<QuizProvider>.value(value: quizProvider),
          ChangeNotifierProvider<PollProvider>.value(value: pollProvider),
        ],
        child: const MaterialApp(
          home: QuizPollPage(),
        ),
      );
    }

    testWidgets(
      'handles rapid quiz answer selections without errors',
      (tester) async {
        await tester.pumpWidget(buildTestApp());
        await tester.pumpAndSettle();

        // Wait for quiz questions to load
        expect(find.text('Kuesioner'), findsOneWidget);

        // Find the first quiz question card
        final firstQuestionOptions = find.byType(RadioListTile<int>);

        if (firstQuestionOptions.evaluate().isNotEmpty) {
          // Rapidly tap different options multiple times
          for (int i = 0; i < 10; i++) {
            await tester.tap(firstQuestionOptions.first);
            await tester.pump(const Duration(milliseconds: 10));
          }

          // Verify no errors occurred and UI is still responsive
          expect(tester.takeException(), isNull);
          expect(find.text('Kuesioner'), findsOneWidget);
        }
      },
    );

    testWidgets(
      'handles rapid tab switching without errors',
      (tester) async {
        await tester.pumpWidget(buildTestApp());
        await tester.pumpAndSettle();

        // Find the tab buttons
        final quizTab = find.text('Kuesioner');
        final pollTab = find.text('Polling');

        expect(quizTab, findsOneWidget);
        expect(pollTab, findsOneWidget);

        // Rapidly switch between tabs 20 times
        for (int i = 0; i < 20; i++) {
          await tester.tap(pollTab);
          await tester.pump(const Duration(milliseconds: 50));

          await tester.tap(quizTab);
          await tester.pump(const Duration(milliseconds: 50));
        }

        // Verify no errors occurred
        expect(tester.takeException(), isNull);

        // Verify both tabs are still accessible
        expect(quizTab, findsOneWidget);
        expect(pollTab, findsOneWidget);
      },
    );

    testWidgets(
      'handles double-tapping on quiz submit without errors',
      (tester) async {
        await tester.pumpWidget(buildTestApp());
        await tester.pumpAndSettle();

        // Wait for quiz questions to load
        expect(find.text('Kuesioner'), findsOneWidget);

        // Find and select an option
        final firstOption = find.byType(RadioListTile<int>).first;
        if (firstOption.evaluate().isNotEmpty) {
          await tester.tap(firstOption);
          await tester.pump();

          // Find the submit button
          final submitButton = find.text('Kirim Jawaban');
          if (submitButton.evaluate().isNotEmpty) {
            // Double-tap the submit button rapidly
            await tester.tap(submitButton);
            await tester.pump(const Duration(milliseconds: 10));
            await tester.tap(submitButton);
            await tester.pump(const Duration(milliseconds: 10));

            // Verify no errors occurred
            expect(tester.takeException(), isNull);
          }
        }
      },
    );

    testWidgets(
      'handles rapid poll option changes without errors',
      (tester) async {
        await tester.pumpWidget(buildTestApp());
        await tester.pumpAndSettle();

        // Switch to poll tab
        final pollTab = find.text('Polling');
        await tester.tap(pollTab);
        await tester.pumpAndSettle();

        // Find poll options
        final pollOptions = find.byType(InkWell);

        if (pollOptions.evaluate().length >= 2) {
          // Rapidly change selection between different options
          for (int i = 0; i < 15; i++) {
            final optionIndex = i % pollOptions.evaluate().length;
            await tester.tap(pollOptions.at(optionIndex));
            await tester.pump(const Duration(milliseconds: 20));
          }

          // Verify no errors occurred
          expect(tester.takeException(), isNull);
          expect(find.text('Polling'), findsOneWidget);
        }
      },
    );

    testWidgets(
      'handles rapid poll vote submission attempts without errors',
      (tester) async {
        await tester.pumpWidget(buildTestApp());
        await tester.pumpAndSettle();

        // Switch to poll tab
        final pollTab = find.text('Polling');
        await tester.tap(pollTab);
        await tester.pumpAndSettle();

        // Find and select a poll option
        final pollOptions = find.byType(InkWell);
        if (pollOptions.evaluate().isNotEmpty) {
          await tester.tap(pollOptions.first);
          await tester.pump();

          // Find the submit vote button
          final submitButton = find.text('Kirim Vote');
          if (submitButton.evaluate().isNotEmpty) {
            // Rapidly tap submit button multiple times
            for (int i = 0; i < 10; i++) {
              await tester.tap(submitButton);
              await tester.pump(const Duration(milliseconds: 10));
            }

            // Verify no errors occurred
            expect(tester.takeException(), isNull);
          }
        }
      },
    );

    testWidgets(
      'handles rapid tab switching during loading without errors',
      (tester) async {
        await tester.pumpWidget(buildTestApp());

        // Don't wait for settle - start switching immediately
        final quizTab = find.text('Kuesioner');
        final pollTab = find.text('Polling');

        // Rapidly switch tabs while content is still loading
        for (int i = 0; i < 10; i++) {
          await tester.tap(pollTab);
          await tester.pump(const Duration(milliseconds: 20));

          await tester.tap(quizTab);
          await tester.pump(const Duration(milliseconds: 20));
        }

        // Wait for everything to settle
        await tester.pumpAndSettle();

        // Verify no errors occurred
        expect(tester.takeException(), isNull);
        expect(find.text('Kuesioner'), findsOneWidget);
        expect(find.text('Polling'), findsOneWidget);
      },
    );

    testWidgets(
      'handles rapid answer changes before submission without errors',
      (tester) async {
        await tester.pumpWidget(buildTestApp());
        await tester.pumpAndSettle();

        // Wait for quiz questions to load
        expect(find.text('Kuesioner'), findsOneWidget);

        // Find all radio options for the first question
        final radioOptions = find.byType(RadioListTile<int>);

        if (radioOptions.evaluate().length >= 2) {
          // Rapidly change selection between different options
          for (int i = 0; i < 20; i++) {
            final optionIndex = i % radioOptions.evaluate().length;
            await tester.tap(radioOptions.at(optionIndex));
            await tester.pump(const Duration(milliseconds: 15));
          }

          // Verify no errors occurred
          expect(tester.takeException(), isNull);
          expect(find.text('Kuesioner'), findsOneWidget);
        }
      },
    );

    testWidgets(
      'handles rapid scrolling and tapping without errors',
      (tester) async {
        await tester.pumpWidget(buildTestApp());
        await tester.pumpAndSettle();

        // Wait for quiz questions to load
        expect(find.text('Kuesioner'), findsOneWidget);

        // Perform rapid scroll and tap operations
        for (int i = 0; i < 10; i++) {
          // Scroll down
          await tester.drag(
            find.byType(ListView),
            const Offset(0, -100),
          );
          await tester.pump(const Duration(milliseconds: 20));

          // Try to tap any visible option
          final visibleOptions = find.byType(RadioListTile<int>);
          if (visibleOptions.evaluate().isNotEmpty) {
            await tester.tap(visibleOptions.first);
            await tester.pump(const Duration(milliseconds: 20));
          }

          // Scroll up
          await tester.drag(
            find.byType(ListView),
            const Offset(0, 100),
          );
          await tester.pump(const Duration(milliseconds: 20));
        }

        // Verify no errors occurred
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'handles rapid navigation with tab switching without errors',
      (tester) async {
        await tester.pumpWidget(buildTestApp());
        await tester.pumpAndSettle();

        final quizTab = find.text('Kuesioner');
        final pollTab = find.text('Polling');

        // Simulate rapid navigation pattern: tab switch + interaction
        for (int i = 0; i < 15; i++) {
          // Switch to poll tab
          await tester.tap(pollTab);
          await tester.pump(const Duration(milliseconds: 30));

          // Try to interact with poll
          final pollOptions = find.byType(InkWell);
          if (pollOptions.evaluate().isNotEmpty) {
            await tester.tap(pollOptions.first);
            await tester.pump(const Duration(milliseconds: 20));
          }

          // Switch back to quiz tab
          await tester.tap(quizTab);
          await tester.pump(const Duration(milliseconds: 30));

          // Try to interact with quiz
          final quizOptions = find.byType(RadioListTile<int>);
          if (quizOptions.evaluate().isNotEmpty) {
            await tester.tap(quizOptions.first);
            await tester.pump(const Duration(milliseconds: 20));
          }
        }

        // Verify no errors occurred
        expect(tester.takeException(), isNull);
        expect(find.text('Kuesioner'), findsOneWidget);
        expect(find.text('Polling'), findsOneWidget);
      },
    );

    testWidgets(
      'UI remains stable and responsive after stress test',
      (tester) async {
        await tester.pumpWidget(buildTestApp());
        await tester.pumpAndSettle();

        final quizTab = find.text('Kuesioner');
        final pollTab = find.text('Polling');

        // Perform a comprehensive stress test
        for (int i = 0; i < 5; i++) {
          // Rapid tab switching
          await tester.tap(pollTab);
          await tester.pump(const Duration(milliseconds: 20));
          await tester.tap(quizTab);
          await tester.pump(const Duration(milliseconds: 20));

          // Rapid option selection
          final options = find.byType(RadioListTile<int>);
          if (options.evaluate().isNotEmpty) {
            await tester.tap(options.first);
            await tester.pump(const Duration(milliseconds: 10));
          }

          // Rapid scrolling
          await tester.drag(
            find.byType(ListView),
            const Offset(0, -50),
          );
          await tester.pump(const Duration(milliseconds: 20));
        }

        // Wait for everything to settle
        await tester.pumpAndSettle();

        // Verify UI is still stable and responsive
        expect(tester.takeException(), isNull);
        expect(find.text('Kuesioner'), findsOneWidget);
        expect(find.text('Polling'), findsOneWidget);

        // Verify we can still interact normally
        await tester.tap(pollTab);
        await tester.pumpAndSettle();
        expect(find.text('Polling'), findsOneWidget);

        await tester.tap(quizTab);
        await tester.pumpAndSettle();
        expect(find.text('Kuesioner'), findsOneWidget);
      },
    );
  });
}

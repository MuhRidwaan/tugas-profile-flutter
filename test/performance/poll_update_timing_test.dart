import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/models/poll.dart';
import 'package:profile_tugas/models/poll_result.dart';
import 'package:profile_tugas/pages/quiz_poll/poll_page.dart';
import 'package:profile_tugas/pages/quiz_poll/widgets/poll_result_widget.dart';
import 'package:profile_tugas/providers/poll_provider.dart';
import 'package:profile_tugas/repositories/poll_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Performance test for poll result update timing.
///
/// **Validates: Requirement 8.2** - Poll result update < 200ms
///
/// This test measures the time from when a user submits a vote to when
/// the poll results are displayed. The requirement is that results must
/// update within 200ms.
void main() {
  group('Poll Result Update Timing Performance', () {
    testWidgets(
      'poll results display within 200ms after vote submission',
      (tester) async {
        // Setup: Initialize SharedPreferences and repository
        SharedPreferences.setMockInitialValues({});
        final prefs = await SharedPreferences.getInstance();
        final repository = PollRepository(prefs);
        final provider = PollProvider(repository);

        // Build the poll page widget
        await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider<PollProvider>.value(
              value: provider,
              child: const Scaffold(
                body: PollPage(),
              ),
            ),
          ),
        );

        // Wait for initial load
        await tester.pumpAndSettle();

        // Verify we're in the voting state (not yet voted)
        expect(find.text('Pilih olahraga favoritmu:'), findsOneWidget);
        expect(find.text('Kirim Vote'), findsOneWidget);

        // Select the first option (Badminton)
        final firstOption = find.text('Badminton');
        expect(firstOption, findsOneWidget);
        await tester.tap(firstOption);
        await tester.pump();

        // Start timing measurement
        final stopwatch = Stopwatch()..start();

        // Submit the vote
        final submitButton = find.text('Kirim Vote');
        await tester.tap(submitButton);

        // Pump a single frame to allow the vote submission to process
        await tester.pump();

        // Check if PollResultWidget appears
        final resultWidget = find.byType(PollResultWidget);
        expect(resultWidget, findsOneWidget);

        // Stop timing
        stopwatch.stop();

        // Verify the timing requirement: < 200ms
        final elapsedMs = stopwatch.elapsedMilliseconds;
        expect(
          elapsedMs,
          lessThan(200),
          reason: 'Poll results should display within 200ms, '
              'but took ${elapsedMs}ms',
        );

        // Additional verification: confirm results are displayed
        expect(find.text('Hasil Polling'), findsOneWidget);
        expect(
          find.text('Terima kasih! Vote kamu sudah tercatat.'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'poll result widget animates within 200ms',
      (tester) async {
        // Setup: Create a poll and vote distribution
        final poll = Poll.defaultPoll();
        final voteDistribution = PollResult.fromDistribution({
          0: 10,
          1: 5,
          2: 3,
          3: 7,
          4: 2,
        });

        // Start timing measurement
        final stopwatch = Stopwatch()..start();

        // Build the PollResultWidget
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: PollResultWidget(
                  poll: poll,
                  voteDistribution: voteDistribution,
                  userSelectedOptionIndex: 0,
                ),
              ),
            ),
          ),
        );

        // Pump a single frame
        await tester.pump();

        // Stop timing
        stopwatch.stop();

        // Verify the timing requirement: < 200ms
        final elapsedMs = stopwatch.elapsedMilliseconds;
        expect(
          elapsedMs,
          lessThan(200),
          reason: 'Poll result widget should render within 200ms, '
              'but took ${elapsedMs}ms',
        );

        // Verify the widget is displayed
        expect(find.text('Hasil Polling'), findsOneWidget);
        expect(find.text('Pilihan Anda'), findsOneWidget);
      },
    );

    testWidgets(
      'vote distribution update reflects immediately',
      (tester) async {
        // Setup: Initialize SharedPreferences and repository
        SharedPreferences.setMockInitialValues({});
        final prefs = await SharedPreferences.getInstance();
        final repository = PollRepository(prefs);
        final provider = PollProvider(repository);

        // Build the poll page widget
        await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider<PollProvider>.value(
              value: provider,
              child: const Scaffold(
                body: PollPage(),
              ),
            ),
          ),
        );

        // Wait for initial load
        await tester.pumpAndSettle();

        // Select and submit vote
        await tester.tap(find.text('Badminton'));
        await tester.pump();

        // Start timing for the update
        final stopwatch = Stopwatch()..start();

        await tester.tap(find.text('Kirim Vote'));
        await tester.pump();

        // Verify vote count is updated
        expect(find.text('1 suara'), findsWidgets);

        stopwatch.stop();

        // Verify timing
        final elapsedMs = stopwatch.elapsedMilliseconds;
        expect(
          elapsedMs,
          lessThan(200),
          reason: 'Vote distribution should update within 200ms, '
              'but took ${elapsedMs}ms',
        );
      },
    );
  });
}

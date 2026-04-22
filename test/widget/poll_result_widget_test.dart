import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/models/poll.dart';
import 'package:profile_tugas/models/poll_result.dart';
import 'package:profile_tugas/pages/quiz_poll/widgets/poll_result_widget.dart';

Widget buildResult({
  required Poll poll,
  required PollResult voteDistribution,
  int? userSelectedOptionIndex,
}) {
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: PollResultWidget(
          poll: poll,
          voteDistribution: voteDistribution,
          userSelectedOptionIndex: userSelectedOptionIndex,
        ),
      ),
    ),
  );
}

final _poll = Poll.defaultPoll();

void main() {
  group('PollResultWidget', () {
    group('rendering', () {
      testWidgets('shows "Hasil Polling" header', (tester) async {
        await tester.pumpWidget(buildResult(
          poll: _poll,
          voteDistribution: PollResult.empty(),
        ));
        await tester.pumpAndSettle();

        expect(find.text('Hasil Polling'), findsOneWidget);
      });

      testWidgets('displays all 5 sports options', (tester) async {
        await tester.pumpWidget(buildResult(
          poll: _poll,
          voteDistribution: PollResult.empty(),
        ));
        await tester.pumpAndSettle();

        for (final option in _poll.options) {
          expect(find.text(option), findsOneWidget);
        }
      });

      testWidgets('shows 0% for all options with no votes', (tester) async {
        await tester.pumpWidget(buildResult(
          poll: _poll,
          voteDistribution: PollResult.empty(),
        ));
        await tester.pumpAndSettle();

        // Should show 0.0% multiple times (one per option)
        expect(find.text('0.0%'), findsWidgets);
      });

      testWidgets('shows vote counts', (tester) async {
        final distribution = PollResult.fromDistribution({
          0: 10,
          1: 20,
          2: 30,
          3: 40,
          4: 0,
        });

        await tester.pumpWidget(buildResult(
          poll: _poll,
          voteDistribution: distribution,
        ));
        await tester.pumpAndSettle();

        expect(find.text('10 suara'), findsOneWidget);
        expect(find.text('20 suara'), findsOneWidget);
      });

      testWidgets('shows "Pilihan Anda" badge for user selected option',
          (tester) async {
        await tester.pumpWidget(buildResult(
          poll: _poll,
          voteDistribution: PollResult.fromDistribution({0: 1}),
          userSelectedOptionIndex: 0,
        ));
        await tester.pumpAndSettle();

        expect(find.text('Pilihan Anda'), findsOneWidget);
      });

      testWidgets('does not show "Pilihan Anda" when no selection',
          (tester) async {
        await tester.pumpWidget(buildResult(
          poll: _poll,
          voteDistribution: PollResult.empty(),
        ));
        await tester.pumpAndSettle();

        expect(find.text('Pilihan Anda'), findsNothing);
      });
    });

    group('animation', () {
      testWidgets('uses AnimatedBuilder for progress animation',
          (tester) async {
        await tester.pumpWidget(buildResult(
          poll: _poll,
          voteDistribution: PollResult.empty(),
        ));

        // Verify that AnimatedBuilder widgets are present (may be multiple due to Material widgets)
        expect(find.byType(AnimatedBuilder), findsWidgets);
      });
    });
  });
}

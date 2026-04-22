import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/pages/quiz_poll/widgets/poll_option_card.dart';

Widget buildCard({
  required String optionText,
  required int optionIndex,
  required bool isSelected,
  required bool isDisabled,
  VoidCallback? onTap,
}) {
  return MaterialApp(
    home: Scaffold(
      body: PollOptionCard(
        optionText: optionText,
        optionIndex: optionIndex,
        isSelected: isSelected,
        isDisabled: isDisabled,
        onTap: onTap,
      ),
    ),
  );
}

void main() {
  group('PollOptionCard', () {
    group('rendering', () {
      testWidgets('displays option text', (tester) async {
        await tester.pumpWidget(buildCard(
          optionText: 'Badminton',
          optionIndex: 0,
          isSelected: false,
          isDisabled: false,
        ));

        expect(find.text('Badminton'), findsOneWidget);
      });

      testWidgets('shows checkmark when selected', (tester) async {
        await tester.pumpWidget(buildCard(
          optionText: 'Basket',
          optionIndex: 3,
          isSelected: true,
          isDisabled: false,
        ));

        expect(find.byIcon(Icons.check_circle), findsOneWidget);
      });

      testWidgets('does not show checkmark when not selected', (tester) async {
        await tester.pumpWidget(buildCard(
          optionText: 'Catur',
          optionIndex: 1,
          isSelected: false,
          isDisabled: false,
        ));

        expect(find.byIcon(Icons.check_circle), findsNothing);
      });

      testWidgets('renders all 5 sports options correctly', (tester) async {
        final sports = [
          'Badminton',
          'Catur',
          'Padel',
          'Basket',
          'Lari Marathon'
        ];

        for (int i = 0; i < sports.length; i++) {
          await tester.pumpWidget(buildCard(
            optionText: sports[i],
            optionIndex: i,
            isSelected: false,
            isDisabled: false,
          ));

          expect(find.text(sports[i]), findsOneWidget);
        }
      });
    });

    group('interaction', () {
      testWidgets('calls onTap when tapped and not disabled', (tester) async {
        bool tapped = false;

        await tester.pumpWidget(buildCard(
          optionText: 'Padel',
          optionIndex: 2,
          isSelected: false,
          isDisabled: false,
          onTap: () => tapped = true,
        ));

        await tester.tap(find.byType(InkWell));
        await tester.pump();

        expect(tapped, isTrue);
      });

      testWidgets('does not call onTap when disabled', (tester) async {
        bool tapped = false;

        await tester.pumpWidget(buildCard(
          optionText: 'Padel',
          optionIndex: 2,
          isSelected: false,
          isDisabled: true,
          onTap: () => tapped = true,
        ));

        await tester.tap(find.byType(InkWell));
        await tester.pump();

        expect(tapped, isFalse);
      });
    });

    group('accessibility', () {
      testWidgets('has Semantics widget', (tester) async {
        await tester.pumpWidget(buildCard(
          optionText: 'Badminton',
          optionIndex: 0,
          isSelected: false,
          isDisabled: false,
        ));

        expect(find.byType(Semantics), findsWidgets);
      });
    });
  });
}

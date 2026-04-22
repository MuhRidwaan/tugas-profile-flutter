import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/models/quiz_answer.dart';
import 'package:profile_tugas/models/quiz_question.dart';
import 'package:profile_tugas/pages/quiz_poll/widgets/feedback_widget.dart';

Widget buildFeedback({
  required QuizAnswer answer,
  required QuizQuestion question,
}) {
  return MaterialApp(
    home: Scaffold(
      body: FeedbackWidget(answer: answer, question: question),
    ),
  );
}

final _question = QuizQuestion(
  id: 'q1',
  questionText: 'What is 2+2?',
  type: QuestionType.single,
  options: ['1', '2', '4', '5', '6'],
  correctAnswers: [2],
);

void main() {
  group('FeedbackWidget', () {
    group('correct answer', () {
      testWidgets('shows "Jawaban Benar!" for correct answer', (tester) async {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: DateTime.now(),
        );

        await tester
            .pumpWidget(buildFeedback(answer: answer, question: _question));
        await tester.pumpAndSettle();

        expect(find.text('Jawaban Benar!'), findsOneWidget);
      });

      testWidgets('does not show answer details for correct answer',
          (tester) async {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: DateTime.now(),
        );

        await tester
            .pumpWidget(buildFeedback(answer: answer, question: _question));
        await tester.pumpAndSettle();

        expect(find.text('Jawaban kamu:'), findsNothing);
        expect(find.text('Jawaban benar:'), findsNothing);
      });

      testWidgets('shows check_circle icon for correct answer', (tester) async {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: DateTime.now(),
        );

        await tester
            .pumpWidget(buildFeedback(answer: answer, question: _question));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.check_circle), findsOneWidget);
      });
    });

    group('incorrect answer', () {
      testWidgets('shows "Jawaban Salah!" for incorrect answer',
          (tester) async {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [0],
          isCorrect: false,
          submittedAt: DateTime.now(),
        );

        await tester
            .pumpWidget(buildFeedback(answer: answer, question: _question));
        await tester.pumpAndSettle();

        expect(find.text('Jawaban Salah!'), findsOneWidget);
      });

      testWidgets('shows selected answer label for incorrect answer',
          (tester) async {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [0],
          isCorrect: false,
          submittedAt: DateTime.now(),
        );

        await tester
            .pumpWidget(buildFeedback(answer: answer, question: _question));
        await tester.pumpAndSettle();

        expect(find.text('Jawaban kamu:'), findsOneWidget);
      });

      testWidgets('shows correct answer label for incorrect answer',
          (tester) async {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [0],
          isCorrect: false,
          submittedAt: DateTime.now(),
        );

        await tester
            .pumpWidget(buildFeedback(answer: answer, question: _question));
        await tester.pumpAndSettle();

        expect(find.text('Jawaban benar:'), findsOneWidget);
      });

      testWidgets('shows cancel icon for incorrect answer', (tester) async {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [0],
          isCorrect: false,
          submittedAt: DateTime.now(),
        );

        await tester
            .pumpWidget(buildFeedback(answer: answer, question: _question));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.cancel), findsOneWidget);
      });

      testWidgets('shows selected option text for incorrect answer',
          (tester) async {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [0], // '1' is wrong
          isCorrect: false,
          submittedAt: DateTime.now(),
        );

        await tester
            .pumpWidget(buildFeedback(answer: answer, question: _question));
        await tester.pumpAndSettle();

        // Option at index 0 is '1'
        expect(find.text('1'), findsWidgets);
      });

      testWidgets('shows correct option text for incorrect answer',
          (tester) async {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [0],
          isCorrect: false,
          submittedAt: DateTime.now(),
        );

        await tester
            .pumpWidget(buildFeedback(answer: answer, question: _question));
        await tester.pumpAndSettle();

        // Correct answer is index 2 = '4'
        expect(find.text('4'), findsWidgets);
      });
    });

    group('animation', () {
      testWidgets('widget is visible after animation completes',
          (tester) async {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: DateTime.now(),
        );

        await tester
            .pumpWidget(buildFeedback(answer: answer, question: _question));
        await tester.pumpAndSettle();

        expect(find.byType(FeedbackWidget), findsOneWidget);
      });

      testWidgets('uses FadeTransition for animation', (tester) async {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: DateTime.now(),
        );

        await tester
            .pumpWidget(buildFeedback(answer: answer, question: _question));

        expect(find.byType(FadeTransition), findsOneWidget);
      });
    });
  });
}

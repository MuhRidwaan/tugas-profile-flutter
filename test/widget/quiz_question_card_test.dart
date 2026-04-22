import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/models/quiz_answer.dart';
import 'package:profile_tugas/models/quiz_question.dart';
import 'package:profile_tugas/pages/quiz_poll/widgets/quiz_question_card.dart';

// Helper to wrap widget in MaterialApp
Widget buildCard({
  required QuizQuestion question,
  QuizAnswer? existingAnswer,
  Function(List<int>)? onSubmit,
  int? questionNumber,
}) {
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: QuizQuestionCard(
          question: question,
          existingAnswer: existingAnswer,
          onSubmit: onSubmit,
          questionNumber: questionNumber,
        ),
      ),
    ),
  );
}

final _singleQuestion = QuizQuestion(
  id: 'q1',
  questionText: 'What is 2+2?',
  type: QuestionType.single,
  options: ['1', '2', '4', '5', '6'],
  correctAnswers: [2],
);

final _multipleQuestion = QuizQuestion(
  id: 'q2',
  questionText: 'Select even numbers',
  type: QuestionType.multiple,
  options: ['1', '2', '3', '4', '5'],
  correctAnswers: [1, 3],
);

void main() {
  group('QuizQuestionCard', () {
    group('rendering', () {
      testWidgets('displays question text', (tester) async {
        await tester.pumpWidget(buildCard(question: _singleQuestion));

        expect(find.text('What is 2+2?'), findsOneWidget);
      });

      testWidgets('displays exactly 5 options for single choice',
          (tester) async {
        await tester.pumpWidget(buildCard(question: _singleQuestion));

        expect(find.byType(RadioListTile<int>), findsNWidgets(5));
      });

      testWidgets('displays exactly 5 options for multiple choice',
          (tester) async {
        await tester.pumpWidget(buildCard(question: _multipleQuestion));

        expect(find.byType(CheckboxListTile), findsNWidgets(5));
      });

      testWidgets('displays question number when provided', (tester) async {
        await tester.pumpWidget(
          buildCard(question: _singleQuestion, questionNumber: 3),
        );

        expect(find.text('Pertanyaan 3'), findsOneWidget);
      });

      testWidgets('does not display question number when not provided',
          (tester) async {
        await tester.pumpWidget(buildCard(question: _singleQuestion));

        expect(find.text('Pertanyaan 1'), findsNothing);
      });

      testWidgets('shows submit button when not answered', (tester) async {
        await tester.pumpWidget(buildCard(question: _singleQuestion));

        expect(find.text('Kirim Jawaban'), findsOneWidget);
      });

      testWidgets('hides submit button when already answered', (tester) async {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: DateTime.now(),
        );

        await tester.pumpWidget(
          buildCard(question: _singleQuestion, existingAnswer: answer),
        );

        expect(find.text('Kirim Jawaban'), findsNothing);
      });

      testWidgets('shows all option texts', (tester) async {
        await tester.pumpWidget(buildCard(question: _singleQuestion));

        for (final option in _singleQuestion.options) {
          expect(find.text(option), findsOneWidget);
        }
      });
    });

    group('interaction', () {
      testWidgets('submit button is disabled before selection', (tester) async {
        await tester.pumpWidget(buildCard(question: _singleQuestion));

        final button = tester.widget<ElevatedButton>(
          find.widgetWithText(ElevatedButton, 'Kirim Jawaban'),
        );
        expect(button.onPressed, isNull);
      });

      testWidgets('submit button enables after selecting an option',
          (tester) async {
        await tester.pumpWidget(buildCard(question: _singleQuestion));

        await tester.tap(find.byType(RadioListTile<int>).first);
        await tester.pump();

        final button = tester.widget<ElevatedButton>(
          find.widgetWithText(ElevatedButton, 'Kirim Jawaban'),
        );
        expect(button.onPressed, isNotNull);
      });

      testWidgets('calls onSubmit with selected option when submitted',
          (tester) async {
        List<int>? submittedOptions;

        await tester.pumpWidget(buildCard(
          question: _singleQuestion,
          onSubmit: (options) => submittedOptions = options,
        ));

        // Select option at index 2
        await tester.tap(find.byType(RadioListTile<int>).at(2));
        await tester.pump();

        await tester.tap(find.text('Kirim Jawaban'));
        await tester.pump();

        expect(submittedOptions, equals([2]));
      });

      testWidgets('radio buttons are disabled when answered', (tester) async {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: DateTime.now(),
        );

        await tester.pumpWidget(
          buildCard(question: _singleQuestion, existingAnswer: answer),
        );

        final radios = tester.widgetList<RadioListTile<int>>(
          find.byType(RadioListTile<int>),
        );

        for (final radio in radios) {
          expect(radio.onChanged, isNull);
        }
      });
    });

    group('answered state', () {
      testWidgets('shows answered badge when question is answered',
          (tester) async {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [2],
          isCorrect: true,
          submittedAt: DateTime.now(),
        );

        await tester.pumpWidget(
          buildCard(question: _singleQuestion, existingAnswer: answer),
        );

        expect(find.text('Benar'), findsOneWidget);
      });

      testWidgets('shows wrong badge for incorrect answer', (tester) async {
        final answer = QuizAnswer(
          questionId: 'q1',
          selectedOptions: [0],
          isCorrect: false,
          submittedAt: DateTime.now(),
        );

        await tester.pumpWidget(
          buildCard(question: _singleQuestion, existingAnswer: answer),
        );

        expect(find.text('Salah'), findsOneWidget);
      });
    });
  });
}

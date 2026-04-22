import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/quiz_provider.dart';
import 'widgets/feedback_widget.dart';
import 'widgets/quiz_question_card.dart';

/// Main quiz page displaying all quiz questions in a scrollable list.
///
/// Uses [Consumer<QuizProvider>] to observe state changes and rebuild
/// automatically. Handles loading, error, and loaded states.
///
/// Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 6.3, 7.3, 8.1, 8.3
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // ---------------------------------------------------------------------------
  // Constants
  // ---------------------------------------------------------------------------

  static const Color _primaryBlue = Color(0xFF1565C0);

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    // Load questions after the first frame so the provider is available.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<QuizProvider>().loadQuestions();
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return _buildLoading();
        }

        if (provider.errorMessage != null && provider.questions.isEmpty) {
          return _buildError(provider);
        }

        return _buildQuestionList(provider);
      },
    );
  }

  // ---------------------------------------------------------------------------
  // State builders
  // ---------------------------------------------------------------------------

  Widget _buildLoading() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: _primaryBlue),
          SizedBox(height: 16),
          Text(
            'Memuat pertanyaan...',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(QuizProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              provider.errorMessage ?? 'Terjadi kesalahan.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => provider.loadQuestions(),
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryBlue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionList(QuizProvider provider) {
    final questions = provider.questions;

    if (questions.isEmpty) {
      return const Center(
        child: Text(
          'Tidak ada pertanyaan tersedia.',
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      );
    }

    // Show a non-blocking error snackbar if there's a soft error
    if (provider.errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(provider.errorMessage!),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      });
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        final existingAnswer = provider.getAnswer(question.id);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuizQuestionCard(
              question: question,
              existingAnswer: existingAnswer,
              questionNumber: index + 1,
              onSubmit: (selectedOptions) {
                provider.submitAnswer(question.id, selectedOptions);
              },
            ),
            // Show feedback below the card when answered
            if (existingAnswer != null) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FeedbackWidget(
                  answer: existingAnswer,
                  question: question,
                ),
              ),
            ],
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}

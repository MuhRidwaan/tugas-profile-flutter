import 'package:flutter/material.dart';

import 'poll_page.dart';
import 'quiz_page.dart';

/// Main entry point for the Quiz & Poll feature.
///
/// Provides a [TabBar] with two tabs:
/// - "Kuesioner" → [QuizPage]
/// - "Polling" → [PollPage]
///
/// Requirements: 6.1, 6.2, 6.3, 6.4
class QuizPollPage extends StatelessWidget {
  const QuizPollPage({super.key});

  // ---------------------------------------------------------------------------
  // Constants
  // ---------------------------------------------------------------------------

  static const Color _primaryBlue = Color(0xFF1565C0);

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Quiz & Polling',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: _primaryBlue,
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            tabs: [
              Tab(
                icon: Icon(Icons.quiz_outlined),
                text: 'Kuesioner',
              ),
              Tab(
                icon: Icon(Icons.poll_outlined),
                text: 'Polling',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            QuizPage(),
            PollPage(),
          ],
        ),
      ),
    );
  }
}

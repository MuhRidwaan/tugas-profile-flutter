import 'package:flutter/material.dart';
import 'widgets/exercise_card.dart';
import 'constants/strings.dart';
import 'max_min_calculator_page.dart';
import 'nested_if_discount_page.dart';
import 'switch_case_discount_page.dart';

/// Main selection page for Conditional Branching Exercises
class ConditionalBranchingPage extends StatelessWidget {
  const ConditionalBranchingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exercises = [
      {
        'title': ConditionalBranchingStrings.ifStatementTitle,
        'description': ConditionalBranchingStrings.ifStatementDescription,
        'icon': Icons.compare_arrows,
        'color': const Color(0xFF1565C0),
        'page': const MaxMinCalculatorPage(),
      },
      {
        'title': ConditionalBranchingStrings.nestedIfTitle,
        'description': ConditionalBranchingStrings.nestedIfDescription,
        'icon': Icons.discount,
        'color': const Color(0xFF7B1FA2),
        'page': const NestedIfDiscountPage(),
      },
      {
        'title': ConditionalBranchingStrings.switchCaseTitle,
        'description': ConditionalBranchingStrings.switchCaseDescription,
        'icon': Icons.switch_access_shortcut,
        'color': const Color(0xFFFF6F00),
        'page': const SwitchCaseDiscountPage(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ConditionalBranchingStrings.pageTitle,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF1565C0), Color(0xFF7B1FA2)],
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5F7FA),
              Color(0xFFE8EAF6),
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            final exercise = exercises[index];
            return ExerciseCard(
              title: exercise['title'] as String,
              description: exercise['description'] as String,
              icon: exercise['icon'] as IconData,
              color: exercise['color'] as Color,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => exercise['page'] as Widget,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

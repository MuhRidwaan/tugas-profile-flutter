import 'package:flutter/material.dart';
import 'widgets/exercise_card.dart';
import 'constants/strings.dart';
import 'integer_series_page.dart';
import 'odd_series_page.dart';
import 'fibonacci_series_page.dart';
import 'even_series_page.dart';

/// Halaman utama pemilihan sub-latihan deret bilangan.
/// Menampilkan 4 ExerciseCard yang masing-masing menavigasi ke sub-latihan.
class NumberSeriesPage extends StatelessWidget {
  const NumberSeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exercises = [
      {
        'title': NumberSeriesStrings.integerSeriesTitle,
        'description': NumberSeriesStrings.integerSeriesDescription,
        'icon': Icons.format_list_numbered,
        'color': const Color(0xFF00695C),
        'loopType': 'for',
        'page': const IntegerSeriesPage(),
      },
      {
        'title': NumberSeriesStrings.oddSeriesTitle,
        'description': NumberSeriesStrings.oddSeriesDescription,
        'icon': Icons.filter_list,
        'color': const Color(0xFF2E7D32),
        'loopType': 'while',
        'page': const OddSeriesPage(),
      },
      {
        'title': NumberSeriesStrings.fibonacciSeriesTitle,
        'description': NumberSeriesStrings.fibonacciSeriesDescription,
        'icon': Icons.timeline,
        'color': const Color(0xFF283593),
        'loopType': 'do-while',
        'page': const FibonacciSeriesPage(),
      },
      {
        'title': NumberSeriesStrings.evenSeriesTitle,
        'description': NumberSeriesStrings.evenSeriesDescription,
        'icon': Icons.looks_two,
        'color': const Color(0xFF00838F),
        'loopType': 'for',
        'page': const EvenSeriesPage(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          NumberSeriesStrings.pageTitle,
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
              colors: [Color(0xFF00695C), Color(0xFF2E7D32)],
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
              Color(0xFFE8F5E9),
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
              loopType: exercise['loopType'] as String,
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

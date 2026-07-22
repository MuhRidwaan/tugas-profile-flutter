import 'package:flutter/material.dart';
import 'widgets/series_grid.dart';
import 'utils/series_generators.dart';
import 'constants/strings.dart';

/// Page demonstrating a `for` loop by displaying 20 even numbers (2–40).
class EvenSeriesPage extends StatefulWidget {
  const EvenSeriesPage({super.key});

  @override
  State<EvenSeriesPage> createState() => _EvenSeriesPageState();
}

class _EvenSeriesPageState extends State<EvenSeriesPage> {
  List<int> _series = [];

  @override
  void initState() {
    super.initState();
    _generateSeries();
  }

  /// Generates even numbers [2, 4, 6, ..., 40] using a for loop.
  void _generateSeries() {
    final List<int> result = [];
    for (int i = 2; i <= 40; i += 2) {
      result.add(i);
    }
    setState(() => _series = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          NumberSeriesStrings.evenPageTitle,
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
              colors: [Color(0xFF00838F), Color(0xFF0097A7)],
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Icon
            const Icon(
              Icons.looks_two,
              size: 60,
              color: Color(0xFF00838F),
            ),
            const SizedBox(height: 16),
            // Title
            const Text(
              NumberSeriesStrings.evenSeriesTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00838F),
              ),
            ),
            const SizedBox(height: 8),
            // Subtitle
            const Text(
              NumberSeriesStrings.evenSeriesDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF757575),
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 12),
            // Loop badge
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF00838F).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  NumberSeriesStrings.forLoopLabel,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00838F),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Series grid
            SeriesGrid(
              items: toSeriesItems(_series),
              themeColor: const Color(0xFF00838F),
            ),
          ],
        ),
      ),
    );
  }
}

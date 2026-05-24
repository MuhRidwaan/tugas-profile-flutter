import 'package:flutter/material.dart';
import 'widgets/series_grid.dart';
import 'utils/series_generators.dart';
import 'constants/strings.dart';

/// Demonstrates the `for` loop by displaying 20 sequential integers (1–20).
class IntegerSeriesPage extends StatefulWidget {
  const IntegerSeriesPage({super.key});

  @override
  State<IntegerSeriesPage> createState() => _IntegerSeriesPageState();
}

class _IntegerSeriesPageState extends State<IntegerSeriesPage> {
  List<int> _series = [];

  @override
  void initState() {
    super.initState();
    _generateSeries();
  }

  void _generateSeries() {
    final List<int> result = [];
    for (int i = 1; i <= 20; i++) {
      result.add(i);
    }
    setState(() => _series = result);
  }

  @override
  Widget build(BuildContext context) {
    const themeColor = Color(0xFF00695C);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          NumberSeriesStrings.integerPageTitle,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF00695C),
                Color(0xFF2E7D32),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.format_list_numbered,
              size: 60,
              color: themeColor,
            ),
            const SizedBox(height: 12),
            const Text(
              NumberSeriesStrings.integerSeriesTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              NumberSeriesStrings.integerSeriesDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Color(0xFF757575),
              ),
            ),
            const SizedBox(height: 12),
            // Loop badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: themeColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                NumberSeriesStrings.forLoopLabel,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                ),
              ),
            ),
            const SizedBox(height: 24),
            SeriesGrid(
              items: toSeriesItems(_series),
              themeColor: themeColor,
            ),
          ],
        ),
      ),
    );
  }
}

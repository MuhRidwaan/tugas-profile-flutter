import 'package:flutter/material.dart';
import 'widgets/series_grid.dart';
import 'utils/series_generators.dart';
import 'constants/strings.dart';

/// Page demonstrating the while loop through odd number series generation.
class OddSeriesPage extends StatefulWidget {
  const OddSeriesPage({super.key});

  @override
  State<OddSeriesPage> createState() => _OddSeriesPageState();
}

class _OddSeriesPageState extends State<OddSeriesPage> {
  List<int> _series = [];

  @override
  void initState() {
    super.initState();
    _generateSeries();
  }

  /// Generates the first 20 odd numbers using a while loop.
  void _generateSeries() {
    final List<int> result = [];
    int number = 1;
    while (result.length < 20) {
      result.add(number);
      number += 2;
    }
    setState(() => _series = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          NumberSeriesStrings.oddPageTitle,
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
              colors: [Color(0xFF2E7D32), Color(0xFF388E3C)],
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.filter_list,
                size: 60,
                color: Color(0xFF2E7D32),
              ),
              const SizedBox(height: 16),
              const Text(
                NumberSeriesStrings.oddSeriesTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                NumberSeriesStrings.oddSeriesDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF757575),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    NumberSeriesStrings.whileLoopLabel,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (_series.isNotEmpty)
                SeriesGrid(
                  items: toSeriesItems(_series),
                  themeColor: const Color(0xFF2E7D32),
                )
              else
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}

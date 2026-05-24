import 'package:flutter/material.dart';
import 'widgets/series_grid.dart';
import 'utils/series_generators.dart';
import 'constants/strings.dart';

/// Page demonstrating do-while loop usage through Fibonacci series generation
class FibonacciSeriesPage extends StatefulWidget {
  const FibonacciSeriesPage({super.key});

  @override
  State<FibonacciSeriesPage> createState() => _FibonacciSeriesPageState();
}

class _FibonacciSeriesPageState extends State<FibonacciSeriesPage> {
  List<int> _series = [];

  @override
  void initState() {
    super.initState();
    _generateSeries();
  }

  /// Generates the first 20 Fibonacci numbers using a do-while loop
  void _generateSeries() {
    final List<int> result = [];
    int a = 0, b = 1;
    do {
      result.add(a);
      int temp = a + b;
      a = b;
      b = temp;
    } while (result.length < 20);

    setState(() {
      _series = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          NumberSeriesStrings.fibonacciPageTitle,
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
              colors: [Color(0xFF283593), Color(0xFF3949AB)],
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
            const Icon(
              Icons.timeline,
              size: 60,
              color: Color(0xFF283593),
            ),
            const SizedBox(height: 16),
            const Text(
              NumberSeriesStrings.fibonacciSeriesTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF283593),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              NumberSeriesStrings.fibonacciSeriesDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF757575),
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF283593).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF283593).withOpacity(0.3),
                  ),
                ),
                child: const Text(
                  NumberSeriesStrings.doWhileLoopLabel,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF283593),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SeriesGrid(
              items: toSeriesItems(_series),
              themeColor: const Color(0xFF283593),
              showIndex: true,
            ),
          ],
        ),
      ),
    );
  }
}

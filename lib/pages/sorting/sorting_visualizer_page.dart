import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sorting_algorithms.dart';

class SortingVisualizerPage extends StatefulWidget {
  final String algorithmName;

  const SortingVisualizerPage({
    super.key,
    required this.algorithmName,
  });

  @override
  State<SortingVisualizerPage> createState() => _SortingVisualizerPageState();
}

class _SortingVisualizerPageState extends State<SortingVisualizerPage> {
  final List<TextEditingController> _controllers = List.generate(
    10,
    (index) => TextEditingController(),
  );

  List<int> _originalNumbers = [];
  List<int> _sortedNumbers = [];
  bool _isSorted = false;
  bool _isAscending = true;

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _generateRandomNumbers() {
    final random = Random();
    setState(() {
      _originalNumbers.clear();
      _sortedNumbers.clear();
      _isSorted = false;

      for (int i = 0; i < 10; i++) {
        int number = random.nextInt(100) + 1; // 1-100
        _controllers[i].text = number.toString();
      }
    });
  }

  void _sortNumbers() {
    // Validate and collect numbers
    List<int> numbers = [];
    for (var controller in _controllers) {
      if (controller.text.isEmpty) {
        _showError('Semua field harus diisi!');
        return;
      }
      try {
        numbers.add(int.parse(controller.text));
      } catch (e) {
        _showError('Masukkan angka yang valid!');
        return;
      }
    }

    // Sort based on algorithm
    List<int> sorted;
    switch (widget.algorithmName) {
      case 'Bubble Sort':
        sorted = SortingAlgorithms.bubbleSort(numbers, _isAscending);
        break;
      case 'Selection Sort':
        sorted = SortingAlgorithms.selectionSort(numbers, _isAscending);
        break;
      case 'Insertion Sort':
        sorted = SortingAlgorithms.insertionSort(numbers, _isAscending);
        break;
      case 'Merge Sort':
        sorted = SortingAlgorithms.mergeSort(numbers, _isAscending);
        break;
      case 'Quick Sort':
        sorted = SortingAlgorithms.quickSort(numbers, _isAscending);
        break;
      default:
        sorted = [];
    }

    setState(() {
      _originalNumbers = numbers;
      _sortedNumbers = sorted;
      _isSorted = true;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _reset() {
    setState(() {
      for (var controller in _controllers) {
        controller.clear();
      }
      _originalNumbers.clear();
      _sortedNumbers.clear();
      _isSorted = false;
    });
  }

  Color _getAlgorithmColor() {
    switch (widget.algorithmName) {
      case 'Bubble Sort':
        return const Color(0xFF1565C0);
      case 'Selection Sort':
        return const Color(0xFF7B1FA2);
      case 'Insertion Sort':
        return const Color(0xFFFF6F00);
      case 'Merge Sort':
        return const Color(0xFF00695C);
      case 'Quick Sort':
        return const Color(0xFFC62828);
      default:
        return const Color(0xFF1565C0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getAlgorithmColor();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.algorithmName,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [color, color.withOpacity(0.7)],
            ),
          ),
        ),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Algorithm Info Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: color),
                          const SizedBox(width: 8),
                          Text(
                            'Tentang Algoritma',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        SortingAlgorithms.getDescription(widget.algorithmName),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF616161),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.timer, size: 16, color: color),
                            const SizedBox(width: 4),
                            Text(
                              'Kompleksitas: ${SortingAlgorithms.getTimeComplexity(widget.algorithmName)}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Input Section
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Input 10 Angka',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: _generateRandomNumbers,
                            icon: const Icon(Icons.shuffle, size: 18),
                            label: const Text('Acak'),
                            style: TextButton.styleFrom(
                              foregroundColor: color,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return TextField(
                            controller: _controllers[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              hintText: '${index + 1}',
                              filled: true,
                              fillColor: color.withOpacity(0.05),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: color.withOpacity(0.3),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: color,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(8),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Sorting Order
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Urutan Sorting',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _OrderOption(
                              title: 'Ascending',
                              subtitle: 'Kecil → Besar',
                              icon: Icons.arrow_upward,
                              isSelected: _isAscending,
                              color: color,
                              onTap: () => setState(() => _isAscending = true),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _OrderOption(
                              title: 'Descending',
                              subtitle: 'Besar → Kecil',
                              icon: Icons.arrow_downward,
                              isSelected: !_isAscending,
                              color: color,
                              onTap: () => setState(() => _isAscending = false),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Sort Button
              ElevatedButton(
                onPressed: _sortNumbers,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.sort),
                    SizedBox(width: 8),
                    Text(
                      'Urutkan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Reset Button
              OutlinedButton(
                onPressed: _reset,
                style: OutlinedButton.styleFrom(
                  foregroundColor: color,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: color, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh),
                    SizedBox(width: 8),
                    Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Result Section
              if (_isSorted) ...[
                const SizedBox(height: 20),
                _ResultCard(
                  title: 'Data Asli',
                  numbers: _originalNumbers,
                  color: Colors.grey[700]!,
                ),
                const SizedBox(height: 16),
                _ResultCard(
                  title: 'Hasil ${_isAscending ? "Ascending" : "Descending"}',
                  numbers: _sortedNumbers,
                  color: color,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _OrderOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey[100],
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? color : Colors.grey,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected ? color : Colors.grey[700],
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? color.withOpacity(0.7) : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String title;
  final List<int> numbers;
  final Color color;

  const _ResultCard({
    required this.title,
    required this.numbers,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              color.withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: numbers.map((num) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: color.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    num.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

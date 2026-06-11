import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sorting_algorithms_animated.dart';

class AnimatedSortingVisualizer extends StatefulWidget {
  final String algorithmName;

  const AnimatedSortingVisualizer({
    super.key,
    required this.algorithmName,
  });

  @override
  State<AnimatedSortingVisualizer> createState() =>
      _AnimatedSortingVisualizerState();
}

class _AnimatedSortingVisualizerState extends State<AnimatedSortingVisualizer> {
  final List<TextEditingController> _controllers = List.generate(
    10,
    (index) => TextEditingController(),
  );

  List<int> _originalNumbers = [];
  List<int> _currentNumbers = [];
  bool _isAscending = true;
  bool _isAnimating = false;
  bool _hasStarted = false;

  int _currentStep = 0;
  int _totalSteps = 0;
  Set<int> _comparingIndices = {};
  Set<int> _swappingIndices = {};
  int? _pivotIndex;

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
      _currentNumbers.clear();
      _hasStarted = false;

      for (int i = 0; i < 10; i++) {
        int number = random.nextInt(100) + 1;
        _controllers[i].text = number.toString();
      }
    });
  }

  Future<void> _startSorting() async {
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

    setState(() {
      _originalNumbers = List.from(numbers);
      _currentNumbers = List.from(numbers);
      _hasStarted = true;
      _isAnimating = true;
      _currentStep = 0;
      _totalSteps = 0;
    });

    // Get sorting steps and animate
    List<SortingStep> steps = [];
    switch (widget.algorithmName) {
      case 'Bubble Sort':
        steps =
            AnimatedSortingAlgorithms.bubbleSortSteps(numbers, _isAscending);
        break;
      case 'Selection Sort':
        steps =
            AnimatedSortingAlgorithms.selectionSortSteps(numbers, _isAscending);
        break;
      case 'Insertion Sort':
        steps =
            AnimatedSortingAlgorithms.insertionSortSteps(numbers, _isAscending);
        break;
      case 'Merge Sort':
        steps = AnimatedSortingAlgorithms.mergeSortSteps(numbers, _isAscending);
        break;
      case 'Quick Sort':
        steps = AnimatedSortingAlgorithms.quickSortSteps(numbers, _isAscending);
        break;
    }

    setState(() {
      _totalSteps = steps.length;
    });

    // Animate each step
    for (int i = 0; i < steps.length; i++) {
      if (!_isAnimating) break;

      final step = steps[i];
      setState(() {
        _currentStep = i + 1;
        _currentNumbers = List.from(step.array);
        _comparingIndices = step.comparing;
        _swappingIndices = step.swapping;
        _pivotIndex = step.pivot;
      });

      await Future.delayed(const Duration(milliseconds: 600));
    }

    setState(() {
      _isAnimating = false;
      _comparingIndices = {};
      _swappingIndices = {};
      _pivotIndex = null;
    });
  }

  void _stopSorting() {
    setState(() {
      _isAnimating = false;
      _comparingIndices = {};
      _swappingIndices = {};
      _pivotIndex = null;
    });
  }

  void _reset() {
    setState(() {
      for (var controller in _controllers) {
        controller.clear();
      }
      _originalNumbers.clear();
      _currentNumbers.clear();
      _hasStarted = false;
      _isAnimating = false;
      _currentStep = 0;
      _totalSteps = 0;
      _comparingIndices = {};
      _swappingIndices = {};
      _pivotIndex = null;
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

  String _getStepDescription() {
    if (_comparingIndices.isNotEmpty) {
      return 'Membandingkan elemen...';
    } else if (_swappingIndices.isNotEmpty) {
      return 'Menukar posisi...';
    } else if (_pivotIndex != null) {
      return 'Pivot: ${_currentNumbers[_pivotIndex!]}';
    }
    return 'Proses sorting...';
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
                            onPressed:
                                _hasStarted ? null : _generateRandomNumbers,
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
                            enabled: !_hasStarted,
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
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.3),
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
                              color: _hasStarted ? Colors.grey : color,
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
                              enabled: !_hasStarted,
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
                              enabled: !_hasStarted,
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

              // Animation Visualization
              if (_hasStarted) ...[
                _AnimationCard(
                  numbers: _currentNumbers,
                  comparingIndices: _comparingIndices,
                  swappingIndices: _swappingIndices,
                  pivotIndex: _pivotIndex,
                  color: color,
                ),
                const SizedBox(height: 16),

                // Progress Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _getStepDescription(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                            ),
                            Text(
                              'Step $_currentStep/$_totalSteps',
                              style: TextStyle(
                                fontSize: 14,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value:
                              _totalSteps > 0 ? _currentStep / _totalSteps : 0,
                          backgroundColor: color.withOpacity(0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Control Buttons
              if (!_hasStarted) ...[
                ElevatedButton(
                  onPressed: _startSorting,
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
                      Icon(Icons.play_arrow),
                      SizedBox(width: 8),
                      Text(
                        'Mulai Animasi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                if (_isAnimating)
                  ElevatedButton(
                    onPressed: _stopSorting,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
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
                        Icon(Icons.pause),
                        SizedBox(width: 8),
                        Text(
                          'Stop Animasi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],

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

              // Legend
              if (_hasStarted) ...[
                const SizedBox(height: 20),
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
                          'Keterangan Warna',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _LegendItem(
                          color: Colors.blue,
                          label: 'Sedang dibandingkan',
                        ),
                        const SizedBox(height: 8),
                        _LegendItem(
                          color: Colors.red,
                          label: 'Sedang ditukar',
                        ),
                        const SizedBox(height: 8),
                        _LegendItem(
                          color: Colors.purple,
                          label: 'Pivot (Quick Sort)',
                        ),
                      ],
                    ),
                  ),
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
  final bool enabled;
  final Color color;
  final VoidCallback onTap;

  const _OrderOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.enabled,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withOpacity(enabled ? 0.1 : 0.05)
              : Colors.grey[100],
          border: Border.all(
            color: isSelected
                ? (enabled ? color : Colors.grey)
                : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected && enabled ? color : Colors.grey,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected && enabled ? color : Colors.grey[700],
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: isSelected && enabled
                    ? color.withOpacity(0.7)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimationCard extends StatelessWidget {
  final List<int> numbers;
  final Set<int> comparingIndices;
  final Set<int> swappingIndices;
  final int? pivotIndex;
  final Color color;

  const _AnimationCard({
    required this.numbers,
    required this.comparingIndices,
    required this.swappingIndices,
    required this.pivotIndex,
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
                Icon(Icons.visibility, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Visualisasi Sorting',
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
              children: List.generate(numbers.length, (index) {
                Color itemColor;
                if (swappingIndices.contains(index)) {
                  itemColor = Colors.red;
                } else if (comparingIndices.contains(index)) {
                  itemColor = Colors.blue;
                } else if (pivotIndex == index) {
                  itemColor = Colors.purple;
                } else {
                  itemColor = color;
                }

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: itemColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: itemColor,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    numbers[index].toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: itemColor,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF616161),
          ),
        ),
      ],
    );
  }
}

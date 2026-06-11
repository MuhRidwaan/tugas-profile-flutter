import 'package:flutter/material.dart';
import 'animated_sorting_visualizer.dart';

class SortingAlgorithmsPage extends StatelessWidget {
  const SortingAlgorithmsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final algorithms = [
      {
        'name': 'Bubble Sort',
        'icon': Icons.bubble_chart,
        'color': const Color(0xFF1565C0),
        'description': 'Membandingkan elemen bersebelahan',
      },
      {
        'name': 'Selection Sort',
        'icon': Icons.select_all,
        'color': const Color(0xFF7B1FA2),
        'description': 'Memilih elemen terkecil/terbesar',
      },
      {
        'name': 'Insertion Sort',
        'icon': Icons.input,
        'color': const Color(0xFFFF6F00),
        'description': 'Memasukkan elemen ke posisi tepat',
      },
      {
        'name': 'Merge Sort',
        'icon': Icons.merge,
        'color': const Color(0xFF00695C),
        'description': 'Membagi dan menggabungkan array',
      },
      {
        'name': 'Quick Sort',
        'icon': Icons.speed,
        'color': const Color(0xFFC62828),
        'description': 'Menggunakan pivot untuk partisi',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Algoritma Sorting',
          style: TextStyle(
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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF1565C0), Color(0xFF7B1FA2)],
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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1565C0).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.info_outline,
                          color: Color(0xFF1565C0),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          'Pilih algoritma sorting untuk mengurutkan 10 angka',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF424242),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: algorithms.length,
                itemBuilder: (context, index) {
                  final algorithm = algorithms[index];
                  return _AlgorithmCard(
                    name: algorithm['name'] as String,
                    description: algorithm['description'] as String,
                    icon: algorithm['icon'] as IconData,
                    color: algorithm['color'] as Color,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AnimatedSortingVisualizer(
                            algorithmName: algorithm['name'] as String,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlgorithmCard extends StatelessWidget {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _AlgorithmCard({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
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
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF757575),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: color.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'quiz_poll/quiz_poll_page.dart';
import 'calculator/calc_page.dart';
import 'conditional_branching/conditional_branching_page.dart';
import 'number_series/number_series_page.dart';
import 'sorting/sorting_algorithms_page.dart';
import 'zodiac/zodiac_page.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    final allFeatures = [
      {
        'title': 'Quiz & Poll',
        'description': 'Ikuti kuis interaktif dan berpartisipasi dalam polling',
        'icon': Icons.quiz,
        'color': const Color(0xFF1565C0),
        'page': const QuizPollPage(),
        'permission': 'view_quiz_poll',
      },
      {
        'title': 'Calculator',
        'description':
            'Gunakan kalkulator untuk membantu perhitungan sehari-hari',
        'icon': Icons.new_releases,
        'color': const Color(0xFF7B1FA2),
        'page': const CalcPage(),
        'permission': 'view_calculator',
      },
      {
        'title': 'Latihan Percabangan',
        'description':
            'Pelajari konsep percabangan kondisional melalui latihan interaktif',
        'icon': Icons.account_tree,
        'color': const Color(0xFFFF6F00),
        'page': const ConditionalBranchingPage(),
        'permission': 'view_conditional',
      },
      {
        'title': 'Latihan Bilangan',
        'description':
            'Pelajari konsep perulangan melalui visualisasi deret bilangan',
        'icon': Icons.format_list_numbered,
        'color': const Color(0xFF00695C),
        'page': const NumberSeriesPage(),
        'permission': 'view_number_series',
      },
      {
        'title': 'Algoritma Sorting',
        'description':
            'Pelajari berbagai algoritma pengurutan data dengan visualisasi',
        'icon': Icons.sort,
        'color': const Color(0xFFD32F2F),
        'page': const SortingAlgorithmsPage(),
        'permission': 'view_sorting',
      },
      {
        'title': 'Zodiac Info',
        'description':
            'Cari informasi zodiak berdasarkan nama atau tanggal lahir',
        'icon': Icons.star_outline,
        'color': const Color(0xFFFF6F00),
        'page': const ZodiacPage(),
        'permission': 'view_zodiac',
      }
    ];

    final features = allFeatures
        .where((f) => auth.hasPermission(f['permission'] as String))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore',
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
          itemCount: features.length,
          itemBuilder: (context, index) {
            final feature = features[index];
            return _FeatureCard(
              title: feature['title'] as String,
              description: feature['description'] as String,
              icon: feature['icon'] as IconData,
              color: feature['color'] as Color,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => feature['page'] as Widget,
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

class _FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.title,
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
                      title,
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

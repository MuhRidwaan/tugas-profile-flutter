import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../database/app_database.dart';

class DashboardCharts extends StatelessWidget {
  final List<ClassPoll> data;

  const DashboardCharts({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('Belum ada data polling kelas.'));
    }

    return Column(
      children: [
        _buildChartCard('Distribusi Berat Badan (Line Chart)', _buildWeightLineChart()),
        const SizedBox(height: 16),
        _buildChartCard('Tinggi Badan (Bar Chart)', _buildHeightBarChart()),
        const SizedBox(height: 16),
        _buildChartCard('Ukuran Baju (Pie Chart)', _buildShirtPieChart()),
        const SizedBox(height: 16),
        _buildChartCard('Nomor Sepatu (Bar Chart)', _buildShoeSizeChart()),
        const SizedBox(height: 16),
        _buildChartCard('Usia Mahasiswa (Radar Chart)', _buildAgeRadarChart()),
      ],
    );
  }

  Widget _buildChartCard(String title, Widget chart) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 24),
            SizedBox(height: 250, child: chart),
          ],
        ),
      ),
    );
  }

  // 1. Line Chart: Berat Badan
  Widget _buildWeightLineChart() {
    // Sort data by some metric to make a line, e.g., index or ascending weight
    final sorted = List<ClassPoll>.from(data)..sort((a, b) => a.weight.compareTo(b.weight));
    
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true),
        titlesData: const FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: sorted.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.weight)).toList(),
            isCurved: true,
            color: const Color(0xFF1565C0),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
          ),
        ],
      ),
    );
  }

  // 2. Bar Chart: Tinggi Badan
  Widget _buildHeightBarChart() {
    // Group heights: <160, 160-170, >170
    int short = 0, medium = 0, tall = 0;
    for (var d in data) {
      if (d.height < 160) short++;
      else if (d.height <= 170) medium++;
      else tall++;
    }

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: (data.length.toDouble() + 1),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0: return const Text('< 160');
                  case 1: return const Text('160-170');
                  case 2: return const Text('> 170');
                  default: return const Text('');
                }
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: short.toDouble(), color: Colors.blue)]),
          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: medium.toDouble(), color: Colors.green)]),
          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: tall.toDouble(), color: Colors.orange)]),
        ],
      ),
    );
  }

  // 3. Pie Chart: Ukuran Baju
  Widget _buildShirtPieChart() {
    final counts = <String, int>{};
    for (var d in data) {
      counts[d.shirtSize] = (counts[d.shirtSize] ?? 0) + 1;
    }

    final colors = [Colors.blue, Colors.red, Colors.green, Colors.orange, Colors.purple];
    int colorIdx = 0;

    return PieChart(
      PieChartData(
        sections: counts.entries.map((e) {
          final color = colors[colorIdx++ % colors.length];
          return PieChartSectionData(
            color: color,
            value: e.value.toDouble(),
            title: '${e.key} (${e.value})',
            radius: 60,
            titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          );
        }).toList(),
      ),
    );
  }

  // 4. Scatter Chart or Bar Chart: Nomor Sepatu
  Widget _buildShoeSizeChart() {
    final counts = <int, int>{};
    for (var d in data) {
      counts[d.shoeSize] = (counts[d.shoeSize] ?? 0) + 1;
    }
    
    final sortedKeys = counts.keys.toList()..sort();

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: (data.length.toDouble() + 1),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx >= 0 && idx < sortedKeys.length) {
                  return Text(sortedKeys[idx].toString());
                }
                return const Text('');
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barGroups: sortedKeys.asMap().entries.map((e) {
          return BarChartGroupData(
            x: e.key,
            barRods: [BarChartRodData(toY: counts[e.value]!.toDouble(), color: Colors.indigo)],
          );
        }).toList(),
      ),
    );
  }

  // 5. Radar Chart: Usia
  Widget _buildAgeRadarChart() {
    // We group by age groups
    int g1 = 0, g2 = 0, g3 = 0, g4 = 0;
    for (var d in data) {
      if (d.age < 18) g1++;
      else if (d.age <= 20) g2++;
      else if (d.age <= 22) g3++;
      else g4++;
    }

    return RadarChart(
      RadarChartData(
        dataSets: [
          RadarDataSet(
            dataEntries: [
              RadarEntry(value: g1.toDouble()),
              RadarEntry(value: g2.toDouble()),
              RadarEntry(value: g3.toDouble()),
              RadarEntry(value: g4.toDouble()),
            ],
            borderColor: Colors.purple,
            fillColor: Colors.purple.withOpacity(0.2),
          ),
        ],
        getTitle: (index, angle) {
          switch (index) {
            case 0: return const RadarChartTitle(text: '< 18');
            case 1: return const RadarChartTitle(text: '18-20');
            case 2: return const RadarChartTitle(text: '21-22');
            case 3: return const RadarChartTitle(text: '> 22');
            default: return const RadarChartTitle(text: '');
          }
        },
        tickCount: 3,
      ),
    );
  }
}

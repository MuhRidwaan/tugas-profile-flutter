import 'package:flutter/material.dart';
import '../models/series_item.dart';

/// Widget grid untuk menampilkan deret angka dalam tata letak yang rapi.
class SeriesGrid extends StatelessWidget {
  final List<SeriesItem> items;
  final Color themeColor;
  final bool showIndex;

  const SeriesGrid({
    super.key,
    required this.items,
    required this.themeColor,
    this.showIndex = true,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _SeriesCell(
          item: items[index],
          themeColor: themeColor,
          showIndex: showIndex,
        );
      },
    );
  }
}

/// Private widget untuk setiap sel dalam SeriesGrid.
class _SeriesCell extends StatelessWidget {
  final SeriesItem item;
  final Color themeColor;
  final bool showIndex;

  const _SeriesCell({
    required this.item,
    required this.themeColor,
    required this.showIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Angka ke-${item.index}: ${item.value}',
      child: Container(
        decoration: BoxDecoration(
          color: themeColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            if (showIndex)
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '${item.index}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              ),
            Center(
              child: Text(
                '${item.value}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

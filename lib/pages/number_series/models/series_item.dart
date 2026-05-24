/// Model for a single item in a number series
class SeriesItem {
  final int index; // 1-based position in the series
  final int value; // The numeric value

  const SeriesItem({
    required this.index,
    required this.value,
  });
}

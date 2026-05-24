import '../models/series_item.dart';

/// Generates 20 sequential integers [1..20] using a for loop
List<int> generateIntegerSeries() {
  final List<int> result = [];
  for (int i = 1; i <= 20; i++) {
    result.add(i);
  }
  return result;
}

/// Generates the first 20 odd numbers using a while loop
List<int> generateOddSeries() {
  final List<int> result = [];
  int number = 1;
  while (result.length < 20) {
    result.add(number);
    number += 2;
  }
  return result;
}

/// Generates the first 20 Fibonacci numbers starting from 0 using a do-while loop
List<int> generateFibonacciSeries() {
  final List<int> result = [];
  int a = 0, b = 1;
  do {
    result.add(a);
    int temp = a + b;
    a = b;
    b = temp;
  } while (result.length < 20);
  return result;
}

/// Generates 20 even numbers [2, 4, ..., 40] using a for loop
List<int> generateEvenSeries() {
  final List<int> result = [];
  for (int i = 2; i <= 40; i += 2) {
    result.add(i);
  }
  return result;
}

/// Converts a List<int> to List<SeriesItem> with 1-based indices
List<SeriesItem> toSeriesItems(List<int> values) {
  return values
      .asMap()
      .entries
      .map((e) => SeriesItem(index: e.key + 1, value: e.value))
      .toList();
}

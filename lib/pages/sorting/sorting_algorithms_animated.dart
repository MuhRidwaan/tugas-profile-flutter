class SortingStep {
  final List<int> array;
  final Set<int> comparing;
  final Set<int> swapping;
  final int? pivot;

  SortingStep({
    required this.array,
    this.comparing = const {},
    this.swapping = const {},
    this.pivot,
  });
}

class AnimatedSortingAlgorithms {
  /// Bubble Sort with animation steps
  static List<SortingStep> bubbleSortSteps(List<int> arr, bool ascending) {
    List<SortingStep> steps = [];
    List<int> result = List.from(arr);
    int n = result.length;

    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        // Comparing step
        steps.add(SortingStep(
          array: List.from(result),
          comparing: {j, j + 1},
        ));

        bool shouldSwap =
            ascending ? result[j] > result[j + 1] : result[j] < result[j + 1];

        if (shouldSwap) {
          // Swapping step
          int temp = result[j];
          result[j] = result[j + 1];
          result[j + 1] = temp;

          steps.add(SortingStep(
            array: List.from(result),
            swapping: {j, j + 1},
          ));
        }
      }
    }

    // Final step
    steps.add(SortingStep(array: List.from(result)));
    return steps;
  }

  /// Selection Sort with animation steps
  static List<SortingStep> selectionSortSteps(List<int> arr, bool ascending) {
    List<SortingStep> steps = [];
    List<int> result = List.from(arr);
    int n = result.length;

    for (int i = 0; i < n - 1; i++) {
      int selectedIndex = i;

      for (int j = i + 1; j < n; j++) {
        // Comparing step
        steps.add(SortingStep(
          array: List.from(result),
          comparing: {selectedIndex, j},
        ));

        bool shouldSelect = ascending
            ? result[j] < result[selectedIndex]
            : result[j] > result[selectedIndex];

        if (shouldSelect) {
          selectedIndex = j;
        }
      }

      if (selectedIndex != i) {
        // Swapping step
        int temp = result[i];
        result[i] = result[selectedIndex];
        result[selectedIndex] = temp;

        steps.add(SortingStep(
          array: List.from(result),
          swapping: {i, selectedIndex},
        ));
      }
    }

    // Final step
    steps.add(SortingStep(array: List.from(result)));
    return steps;
  }

  /// Insertion Sort with animation steps
  static List<SortingStep> insertionSortSteps(List<int> arr, bool ascending) {
    List<SortingStep> steps = [];
    List<int> result = List.from(arr);
    int n = result.length;

    for (int i = 1; i < n; i++) {
      int key = result[i];
      int j = i - 1;

      steps.add(SortingStep(
        array: List.from(result),
        comparing: {i},
      ));

      while (j >= 0) {
        bool shouldMove = ascending ? result[j] > key : result[j] < key;

        if (!shouldMove) break;

        steps.add(SortingStep(
          array: List.from(result),
          comparing: {j, j + 1},
        ));

        result[j + 1] = result[j];
        j--;

        steps.add(SortingStep(
          array: List.from(result),
          swapping: {j + 1, j + 2},
        ));
      }
      result[j + 1] = key;
    }

    // Final step
    steps.add(SortingStep(array: List.from(result)));
    return steps;
  }

  /// Merge Sort with animation steps
  static List<SortingStep> mergeSortSteps(List<int> arr, bool ascending) {
    List<SortingStep> steps = [];
    List<int> result = List.from(arr);
    _mergeSortHelper(result, 0, result.length - 1, ascending, steps);
    steps.add(SortingStep(array: List.from(result)));
    return steps;
  }

  static void _mergeSortHelper(
    List<int> arr,
    int left,
    int right,
    bool ascending,
    List<SortingStep> steps,
  ) {
    if (left < right) {
      int mid = left + (right - left) ~/ 2;

      _mergeSortHelper(arr, left, mid, ascending, steps);
      _mergeSortHelper(arr, mid + 1, right, ascending, steps);
      _merge(arr, left, mid, right, ascending, steps);
    }
  }

  static void _merge(
    List<int> arr,
    int left,
    int mid,
    int right,
    bool ascending,
    List<SortingStep> steps,
  ) {
    List<int> leftArr = arr.sublist(left, mid + 1);
    List<int> rightArr = arr.sublist(mid + 1, right + 1);

    int i = 0, j = 0, k = left;

    while (i < leftArr.length && j < rightArr.length) {
      steps.add(SortingStep(
        array: List.from(arr),
        comparing: {left + i, mid + 1 + j},
      ));

      bool takeLeft =
          ascending ? leftArr[i] <= rightArr[j] : leftArr[i] >= rightArr[j];

      if (takeLeft) {
        arr[k] = leftArr[i];
        i++;
      } else {
        arr[k] = rightArr[j];
        j++;
      }

      steps.add(SortingStep(
        array: List.from(arr),
        swapping: {k},
      ));
      k++;
    }

    while (i < leftArr.length) {
      arr[k] = leftArr[i];
      steps.add(SortingStep(array: List.from(arr), swapping: {k}));
      i++;
      k++;
    }

    while (j < rightArr.length) {
      arr[k] = rightArr[j];
      steps.add(SortingStep(array: List.from(arr), swapping: {k}));
      j++;
      k++;
    }
  }

  /// Quick Sort with animation steps
  static List<SortingStep> quickSortSteps(List<int> arr, bool ascending) {
    List<SortingStep> steps = [];
    List<int> result = List.from(arr);
    _quickSortHelper(result, 0, result.length - 1, ascending, steps);
    steps.add(SortingStep(array: List.from(result)));
    return steps;
  }

  static void _quickSortHelper(
    List<int> arr,
    int low,
    int high,
    bool ascending,
    List<SortingStep> steps,
  ) {
    if (low < high) {
      int pi = _partition(arr, low, high, ascending, steps);
      _quickSortHelper(arr, low, pi - 1, ascending, steps);
      _quickSortHelper(arr, pi + 1, high, ascending, steps);
    }
  }

  static int _partition(
    List<int> arr,
    int low,
    int high,
    bool ascending,
    List<SortingStep> steps,
  ) {
    int pivot = arr[high];
    steps.add(SortingStep(
      array: List.from(arr),
      pivot: high,
    ));

    int i = low - 1;

    for (int j = low; j < high; j++) {
      steps.add(SortingStep(
        array: List.from(arr),
        comparing: {j, high},
        pivot: high,
      ));

      bool shouldSwap = ascending ? arr[j] < pivot : arr[j] > pivot;

      if (shouldSwap) {
        i++;
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;

        steps.add(SortingStep(
          array: List.from(arr),
          swapping: {i, j},
          pivot: high,
        ));
      }
    }

    int temp = arr[i + 1];
    arr[i + 1] = arr[high];
    arr[high] = temp;

    steps.add(SortingStep(
      array: List.from(arr),
      swapping: {i + 1, high},
    ));

    return i + 1;
  }
}

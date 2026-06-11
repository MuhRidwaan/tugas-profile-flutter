class SortingAlgorithms {
  /// Bubble Sort Algorithm
  static List<int> bubbleSort(List<int> arr, bool ascending) {
    List<int> result = List.from(arr);
    int n = result.length;

    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        bool shouldSwap =
            ascending ? result[j] > result[j + 1] : result[j] < result[j + 1];

        if (shouldSwap) {
          int temp = result[j];
          result[j] = result[j + 1];
          result[j + 1] = temp;
        }
      }
    }
    return result;
  }

  /// Selection Sort Algorithm
  static List<int> selectionSort(List<int> arr, bool ascending) {
    List<int> result = List.from(arr);
    int n = result.length;

    for (int i = 0; i < n - 1; i++) {
      int selectedIndex = i;

      for (int j = i + 1; j < n; j++) {
        bool shouldSelect = ascending
            ? result[j] < result[selectedIndex]
            : result[j] > result[selectedIndex];

        if (shouldSelect) {
          selectedIndex = j;
        }
      }

      if (selectedIndex != i) {
        int temp = result[i];
        result[i] = result[selectedIndex];
        result[selectedIndex] = temp;
      }
    }
    return result;
  }

  /// Insertion Sort Algorithm
  static List<int> insertionSort(List<int> arr, bool ascending) {
    List<int> result = List.from(arr);
    int n = result.length;

    for (int i = 1; i < n; i++) {
      int key = result[i];
      int j = i - 1;

      while (j >= 0) {
        bool shouldMove = ascending ? result[j] > key : result[j] < key;

        if (!shouldMove) break;

        result[j + 1] = result[j];
        j--;
      }
      result[j + 1] = key;
    }
    return result;
  }

  /// Merge Sort Algorithm
  static List<int> mergeSort(List<int> arr, bool ascending) {
    if (arr.length <= 1) return List.from(arr);

    int mid = arr.length ~/ 2;
    List<int> left = mergeSort(arr.sublist(0, mid), ascending);
    List<int> right = mergeSort(arr.sublist(mid), ascending);

    return _merge(left, right, ascending);
  }

  static List<int> _merge(List<int> left, List<int> right, bool ascending) {
    List<int> result = [];
    int i = 0, j = 0;

    while (i < left.length && j < right.length) {
      bool takeLeft = ascending ? left[i] <= right[j] : left[i] >= right[j];

      if (takeLeft) {
        result.add(left[i]);
        i++;
      } else {
        result.add(right[j]);
        j++;
      }
    }

    result.addAll(left.sublist(i));
    result.addAll(right.sublist(j));

    return result;
  }

  /// Quick Sort Algorithm
  static List<int> quickSort(List<int> arr, bool ascending) {
    List<int> result = List.from(arr);
    _quickSortHelper(result, 0, result.length - 1, ascending);
    return result;
  }

  static void _quickSortHelper(
      List<int> arr, int low, int high, bool ascending) {
    if (low < high) {
      int pi = _partition(arr, low, high, ascending);
      _quickSortHelper(arr, low, pi - 1, ascending);
      _quickSortHelper(arr, pi + 1, high, ascending);
    }
  }

  static int _partition(List<int> arr, int low, int high, bool ascending) {
    int pivot = arr[high];
    int i = low - 1;

    for (int j = low; j < high; j++) {
      bool shouldSwap = ascending ? arr[j] < pivot : arr[j] > pivot;

      if (shouldSwap) {
        i++;
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
      }
    }

    int temp = arr[i + 1];
    arr[i + 1] = arr[high];
    arr[high] = temp;

    return i + 1;
  }

  /// Get algorithm description
  static String getDescription(String algorithmName) {
    switch (algorithmName) {
      case 'Bubble Sort':
        return 'Algoritma sorting yang membandingkan elemen bersebelahan dan menukarnya jika urutannya salah. Proses ini diulang hingga tidak ada lagi pertukaran.';
      case 'Selection Sort':
        return 'Algoritma yang mencari elemen terkecil/terbesar dari array dan menempatkannya di posisi awal, lalu ulangi untuk sisa array.';
      case 'Insertion Sort':
        return 'Algoritma yang membangun array terurut satu per satu dengan memasukkan setiap elemen ke posisi yang tepat.';
      case 'Merge Sort':
        return 'Algoritma divide-and-conquer yang membagi array menjadi dua bagian, mengurutkan masing-masing, lalu menggabungkannya.';
      case 'Quick Sort':
        return 'Algoritma divide-and-conquer yang memilih pivot dan mempartisi array sehingga elemen lebih kecil di kiri dan lebih besar di kanan.';
      default:
        return '';
    }
  }

  /// Get time complexity
  static String getTimeComplexity(String algorithmName) {
    switch (algorithmName) {
      case 'Bubble Sort':
        return 'O(n²)';
      case 'Selection Sort':
        return 'O(n²)';
      case 'Insertion Sort':
        return 'O(n²)';
      case 'Merge Sort':
        return 'O(n log n)';
      case 'Quick Sort':
        return 'O(n log n) average, O(n²) worst';
      default:
        return '';
    }
  }
}

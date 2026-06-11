# Fitur Sorting Algorithms (dengan Animasi)

Fitur ini menyediakan visualisasi **animasi step-by-step** dan implementasi 5 algoritma sorting yang umum digunakan.

## Algoritma yang Tersedia

### 1. Bubble Sort
- **Deskripsi**: Membandingkan elemen bersebelahan dan menukarnya jika urutannya salah
- **Kompleksitas Waktu**: O(n²)
- **Cocok untuk**: Data kecil, pembelajaran konsep dasar

### 2. Selection Sort
- **Deskripsi**: Mencari elemen terkecil/terbesar dan menempatkannya di posisi awal
- **Kompleksitas Waktu**: O(n²)
- **Cocok untuk**: Data kecil, mudah dipahami

### 3. Insertion Sort
- **Deskripsi**: Membangun array terurut satu per satu dengan memasukkan elemen ke posisi tepat
- **Kompleksitas Waktu**: O(n²)
- **Cocok untuk**: Data hampir terurut, data kecil

### 4. Merge Sort
- **Deskripsi**: Divide-and-conquer, membagi array menjadi dua bagian dan menggabungkannya
- **Kompleksitas Waktu**: O(n log n)
- **Cocok untuk**: Data besar, memerlukan stabilitas

### 5. Quick Sort
- **Deskripsi**: Divide-and-conquer, menggunakan pivot untuk mempartisi array
- **Kompleksitas Waktu**: O(n log n) average, O(n²) worst case
- **Cocok untuk**: Data besar, performa tinggi

## Fitur

- ✅ Input 10 angka (manual atau random)
- ✅ Sorting Ascending (kecil ke besar)
- ✅ Sorting Descending (besar ke kecil)
- ✅ **Animasi step-by-step proses sorting**
- ✅ **Highlight elemen yang sedang dibandingkan (biru)**
- ✅ **Highlight elemen yang sedang ditukar (merah)**
- ✅ **Highlight pivot untuk Quick Sort (ungu)**
- ✅ Progress bar dengan step counter
- ✅ Tombol Play/Stop untuk kontrol animasi
- ✅ Tampilan data asli dan hasil sorting
- ✅ Informasi algoritma dan kompleksitas waktu
- ✅ UI yang menarik dan responsif

## Cara Menggunakan

1. Buka menu **Explore** di bottom navigation
2. Pilih **Algoritma Sorting**
3. Pilih salah satu dari 5 algoritma yang tersedia
4. Input 10 angka (atau gunakan tombol **Acak** untuk generate random)
5. Pilih urutan sorting (Ascending/Descending)
6. Klik tombol **Mulai Animasi**
7. Lihat animasi proses sorting secara step-by-step! 🎬
8. Perhatikan kode warna:
   - **Biru**: Elemen sedang dibandingkan
   - **Merah**: Elemen sedang ditukar
   - **Ungu**: Pivot (Quick Sort)
9. Gunakan tombol **Stop** untuk menghentikan animasi
10. Klik **Reset** untuk mulai dari awal

## Struktur File

```
lib/pages/sorting/
├── sorting_algorithms_page.dart           # Halaman pemilihan algoritma
├── animated_sorting_visualizer.dart       # Halaman animasi dan visualisasi (BARU!)
├── sorting_algorithms_animated.dart       # Implementasi algoritma dengan tracking steps (BARU!)
├── sorting_visualizer_page.dart           # Halaman input tanpa animasi (legacy)
├── sorting_algorithms.dart                # Implementasi algoritma standar
└── README.md                              # Dokumentasi
```

## Teknologi

- Flutter
- Dart
- Material Design 3
- AnimatedContainer untuk smooth transitions
- Step-by-step algorithm visualization
- Real-time progress tracking

## Cara Kerja Animasi

Setiap algoritma sorting di-track step-by-step menggunakan class `SortingStep` yang mencatat:
- State array saat ini
- Indeks elemen yang sedang dibandingkan
- Indeks elemen yang sedang ditukar
- Indeks pivot (untuk Quick Sort)

Animasi berjalan dengan interval 600ms per step, memberikan visualisasi yang jelas dan mudah dipahami tentang bagaimana setiap algoritma bekerja.

### Highlight Warna:
- 🔵 **Biru**: Elemen sedang dibandingkan
- 🔴 **Merah**: Elemen sedang ditukar posisi
- 🟣 **Ungu**: Pivot element (Quick Sort)
- 🟢 **Hijau** (sesuai tema): Elemen normal

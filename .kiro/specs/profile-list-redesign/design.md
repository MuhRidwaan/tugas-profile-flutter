# Dokumen Desain: Redesign Halaman Daftar Profil

## Ikhtisar

Dokumen ini menjelaskan desain teknis untuk redesign halaman daftar profil (`HomePage`) pada aplikasi Flutter `profile_tugas`. Tujuan utama adalah meningkatkan estetika visual kartu profil, memperkaya informasi yang ditampilkan, dan menambahkan elemen interaksi yang lebih modern — tanpa mengubah alur navigasi yang sudah ada.

Perubahan berfokus sepenuhnya pada file `lib/pages/home_page.dart`. Tidak ada package baru yang ditambahkan; semua implementasi menggunakan widget bawaan Flutter (Material Design).

---

## Arsitektur

Arsitektur halaman ini tetap menggunakan pola **StatelessWidget** karena tidak ada state yang perlu dikelola di level `HomePage`. Data profil didefinisikan sebagai list statis di dalam widget.

```
MyApp
  └── HomePage (StatelessWidget)
        ├── Scaffold
        │     ├── PreferredSize (AppBar dengan gradasi)
        │     └── Container (latar belakang abu-abu)
        │           └── GridView.builder
        │                 └── ProfileCard (widget terpisah, StatelessWidget)
        │                       ├── Hero (membungkus gambar)
        │                       ├── CircleAvatar (foto profil)
        │                       ├── Text (nama)
        │                       └── Chip (pekerjaan + ikon)
        └── Navigator → ProfileAlfan / ProfileRidwan
```

### Keputusan Desain

1. **Ekstraksi `ProfileCard` sebagai widget terpisah**: Memisahkan logika kartu dari `HomePage` meningkatkan keterbacaan dan kemudahan pengujian.
2. **Data profil tetap statis**: Tidak ada perubahan pada sumber data; list profil tetap didefinisikan langsung di `HomePage`.
3. **Tidak ada package tambahan**: Semua fitur (gradasi, Hero, InkWell, Chip) menggunakan widget bawaan Flutter.
4. **AppBar dengan gradasi menggunakan `FlexibleSpaceBar` + `Container`**: Karena `AppBar.backgroundColor` tidak mendukung gradasi langsung, digunakan `flexibleSpace` dengan `Container` berdekorasi `LinearGradient`.

---

## Komponen dan Antarmuka

### 1. `HomePage` (dimodifikasi)

**File:** `lib/pages/home_page.dart`

**Tanggung jawab:**
- Mendefinisikan data profil (nama, pekerjaan, gambar, halaman tujuan, warna gradasi, ikon pekerjaan)
- Merender `AppBar` bergradasi
- Merender `GridView` dengan `ProfileCard` untuk setiap profil

**Struktur data profil:**
```dart
final List<Map<String, dynamic>> profiles = [
  {
    "name": "Alfan Nurkhasani",
    "job": "Mahasiswa",
    "image": "assets/images/alfan.jpg",
    "page": const ProfileAlfan(),
    "gradientColors": [Color(0xFF1565C0), Color(0xFF7B1FA2)], // biru-ungu
    "jobIcon": Icons.school,
  },
  {
    "name": "M. Ridwan",
    "job": "Programmer",
    "image": "assets/images/ridwan.jpg",
    "page": const ProfileRidwan(),
    "gradientColors": [Color(0xFF2E7D32), Color(0xFF00695C)], // hijau-teal
    "jobIcon": Icons.code,
  },
];
```

### 2. `ProfileCard` (widget baru)

**File:** `lib/pages/home_page.dart` (didefinisikan dalam file yang sama)

**Parameter:**
```dart
class ProfileCard extends StatelessWidget {
  final String name;
  final String job;
  final String image;
  final Widget page;
  final List<Color> gradientColors;
  final IconData jobIcon;

  const ProfileCard({
    super.key,
    required this.name,
    required this.job,
    required this.image,
    required this.page,
    required this.gradientColors,
    required this.jobIcon,
  });
}
```

**Tanggung jawab:**
- Merender kartu profil dengan gradasi, foto, nama, dan chip pekerjaan
- Menangani tap dengan `InkWell` (ripple effect)
- Membungkus gambar dengan `Hero` untuk animasi transisi
- Menampilkan fallback icon jika gambar gagal dimuat

---

## Model Data

Tidak ada model data baru yang diperkenalkan. Data profil tetap menggunakan `List<Map<String, dynamic>>` yang sudah ada, dengan penambahan dua field baru:

| Field | Tipe | Deskripsi |
|---|---|---|
| `name` | `String` | Nama lengkap profil |
| `job` | `String` | Label pekerjaan/status |
| `image` | `String` | Path aset gambar profil |
| `page` | `Widget` | Halaman tujuan navigasi |
| `gradientColors` | `List<Color>` | Dua warna untuk gradasi kartu |
| `jobIcon` | `IconData` | Ikon Material Design untuk pekerjaan |

---

## Diagram Tata Letak

```
┌─────────────────────────────────────┐
│  AppBar (gradasi biru → ungu)       │
│       "Daftar Profil"               │
├─────────────────────────────────────┤
│  Background: Color(0xFFF5F5F5)      │
│  ┌──────────────┐ ┌──────────────┐  │
│  │  Kartu 1     │ │  Kartu 2     │  │
│  │ ┌──────────┐ │ │ ┌──────────┐ │  │
│  │ │ Gradasi  │ │ │ │ Gradasi  │ │  │
│  │ │ biru-ungu│ │ │ │ hijau-   │ │  │
│  │ │          │ │ │ │ teal     │ │  │
│  │ │  [foto]  │ │ │ │  [foto]  │ │  │
│  │ │  Nama    │ │ │ │  Nama    │ │  │
│  │ │ [🎓 Job] │ │ │ │ [💻 Job] │ │  │
│  │ └──────────┘ │ │ └──────────┘ │  │
│  └──────────────┘ └──────────────┘  │
└─────────────────────────────────────┘
```

---

## Properti Kebenaran

*Sebuah properti adalah karakteristik atau perilaku yang harus berlaku di semua eksekusi valid suatu sistem — pada dasarnya, pernyataan formal tentang apa yang seharusnya dilakukan sistem. Properti berfungsi sebagai jembatan antara spesifikasi yang dapat dibaca manusia dan jaminan kebenaran yang dapat diverifikasi secara otomatis.*

### Properti 1: Kartu menampilkan data profil yang sesuai

*Untuk setiap* profil dalam daftar, kartu yang dirender harus menampilkan nama dan label pekerjaan yang sesuai dengan data profil tersebut.

**Memvalidasi: Persyaratan 3.3, 3.4**

### Properti 2: Gradasi kartu sesuai dengan data profil

*Untuk setiap* profil dalam daftar, gradasi warna yang ditampilkan pada kartu harus sesuai dengan `gradientColors` yang didefinisikan untuk profil tersebut.

**Memvalidasi: Persyaratan 3.2**

### Properti 3: Ikon pekerjaan sesuai dengan data profil

*Untuk setiap* profil dalam daftar, ikon yang ditampilkan di dalam Chip harus sesuai dengan `jobIcon` yang didefinisikan untuk profil tersebut.

**Memvalidasi: Persyaratan 4.1**

### Properti 4: Navigasi menuju halaman yang benar

*Untuk setiap* profil dalam daftar, menekan kartu harus menavigasi ke halaman profil yang sesuai dengan field `page` profil tersebut.

**Memvalidasi: Persyaratan 5.2**

### Properti 5: HeroTag unik untuk setiap profil

*Untuk setiap* pasangan profil yang berbeda dalam daftar, `heroTag` yang digunakan pada widget `Hero` harus berbeda satu sama lain.

**Memvalidasi: Persyaratan 5.3**

### Properti 6: GridView menampilkan semua profil

*Untuk setiap* daftar profil dengan ukuran berapa pun, jumlah item yang dirender oleh `GridView` harus sama dengan jumlah profil dalam daftar tersebut.

**Memvalidasi: Persyaratan 6.3**

### Properti 7: SemanticLabel gambar sesuai nama profil

*Untuk setiap* profil dalam daftar, `semanticLabel` pada widget gambar profil harus sama dengan nama profil tersebut.

**Memvalidasi: Persyaratan 7.2**

---

## Penanganan Error

### Gambar Gagal Dimuat

Jika `AssetImage` gagal dimuat (misalnya file tidak ditemukan), `ProfileCard` menampilkan fallback menggunakan `errorBuilder` pada `Image.asset` atau dengan menggunakan `CircleAvatar` dengan `child: Icon(Icons.person, size: 50)` sebagai fallback.

Implementasi menggunakan pendekatan `CircleAvatar` dengan `onBackgroundImageError`:

```dart
CircleAvatar(
  radius: 50,
  backgroundImage: AssetImage(image),
  onBackgroundImageError: (_, __) {},
  child: /* ditampilkan hanya jika gambar gagal */,
)
```

Karena `CircleAvatar` tidak mendukung `errorBuilder` secara langsung, pendekatan yang digunakan adalah membungkus dengan `Image.asset` yang memiliki `errorBuilder`, atau menggunakan `FadeInImage` dengan placeholder.

Solusi yang dipilih: menggunakan `Stack` dengan `CircleAvatar` berisi `Icon(Icons.person)` sebagai layer bawah, dan `CircleAvatar` dengan gambar sebagai layer atas. Jika gambar gagal, layer bawah (ikon) akan terlihat.

### Data Profil Kosong

Jika list `profiles` kosong, `GridView.builder` akan merender grid kosong tanpa error — ini adalah perilaku default Flutter yang sudah aman.

---

## Strategi Pengujian

### Pendekatan Pengujian Ganda

Fitur ini menggunakan dua pendekatan pengujian yang saling melengkapi:

1. **Unit Test / Widget Test (Contoh Spesifik)**: Memverifikasi konfigurasi statis dan perilaku spesifik.
2. **Property-Based Test**: Memverifikasi properti universal yang berlaku untuk semua input.

### Library Property-Based Testing

Gunakan package **`fast_check`** (Dart) atau pendekatan manual dengan loop iterasi untuk property-based testing di Flutter. Karena ekosistem Dart belum memiliki library PBT yang matang seperti QuickCheck, pengujian properti dilakukan dengan:
- Membuat generator data profil acak
- Menjalankan minimal 100 iterasi per properti
- Memverifikasi invariant pada setiap iterasi

### Widget Tests (Contoh Spesifik)

| Test | Persyaratan |
|---|---|
| AppBar menampilkan teks "Daftar Profil" | 1.2 |
| AppBar memiliki elevation 0 | 1.3 |
| Body memiliki warna latar `Color(0xFFF5F5F5)` | 2.1 |
| GridView memiliki padding 16px | 2.2 |
| Kartu memiliki borderRadius 24px | 3.5 |
| InkWell ada pada setiap kartu | 5.1 |
| Fallback icon ditampilkan saat gambar gagal | 7.3 |

### Property-Based Tests

Setiap property test harus dijalankan minimal **100 iterasi** dengan data profil yang digenerate secara acak.

**Tag format:** `// Feature: profile-list-redesign, Property {nomor}: {teks properti}`

| Property | Persyaratan |
|---|---|
| P1: Kartu menampilkan data profil yang sesuai | 3.3, 3.4 |
| P2: Gradasi kartu sesuai data profil | 3.2 |
| P3: Ikon pekerjaan sesuai data profil | 4.1 |
| P4: Navigasi menuju halaman yang benar | 5.2 |
| P5: HeroTag unik untuk setiap profil | 5.3 |
| P6: GridView menampilkan semua profil | 6.3 |
| P7: SemanticLabel gambar sesuai nama profil | 7.2 |

# Dokumen Persyaratan

## Pendahuluan

Fitur ini bertujuan untuk mendesain ulang tampilan halaman daftar profil (`HomePage`) pada aplikasi Flutter `profile_tugas` agar lebih menarik secara visual dan memberikan pengalaman pengguna yang lebih baik. Saat ini, halaman menampilkan grid 2 kolom dengan kartu profil sederhana yang hanya memuat foto bulat, nama, dan status pekerjaan. Redesign ini akan meningkatkan estetika kartu profil, memperkaya informasi yang ditampilkan, dan menambahkan elemen visual yang lebih modern tanpa mengubah alur navigasi yang sudah ada.

## Glosarium

- **HomePage**: Halaman utama aplikasi yang menampilkan daftar kartu profil.
- **ProfileCard**: Widget kartu yang merepresentasikan satu profil pengguna di dalam grid.
- **AppBar**: Bilah navigasi atas pada halaman.
- **GridView**: Widget Flutter yang menampilkan item dalam tata letak grid.
- **Hero Animation**: Animasi transisi bawaan Flutter yang menghubungkan widget antara dua halaman.
- **Gradient**: Efek warna gradasi yang diaplikasikan pada latar belakang atau elemen UI.
- **Avatar**: Gambar profil berbentuk lingkaran atau persegi panjang yang mewakili pengguna.
- **Badge/Chip**: Elemen kecil yang menampilkan label atau status pada kartu profil.
- **Ripple Effect**: Efek animasi gelombang yang muncul saat pengguna menekan sebuah elemen.

---

## Persyaratan

### Persyaratan 1: Desain Visual AppBar yang Lebih Menarik

**User Story:** Sebagai pengguna, saya ingin melihat AppBar yang lebih menarik secara visual, sehingga kesan pertama saat membuka aplikasi terasa lebih profesional.

#### Kriteria Penerimaan

1. THE `HomePage` SHALL menampilkan `AppBar` dengan latar belakang warna gradasi dari warna primer ke warna sekunder tema aplikasi.
2. THE `HomePage` SHALL menampilkan judul "Daftar Profil" pada `AppBar` dengan ukuran font 20sp, rata tengah, dan berwarna putih.
3. THE `HomePage` SHALL menampilkan `AppBar` tanpa bayangan (`elevation: 0`) untuk tampilan yang lebih bersih dan modern.

---

### Persyaratan 2: Latar Belakang Halaman yang Lebih Menarik

**User Story:** Sebagai pengguna, saya ingin latar belakang halaman daftar profil terlihat lebih menarik, sehingga tampilan keseluruhan aplikasi terasa lebih hidup.

#### Kriteria Penerimaan

1. THE `HomePage` SHALL menampilkan latar belakang `body` dengan warna abu-abu muda (`Color(0xFFF5F5F5)`) agar kartu profil terlihat kontras dan menonjol.
2. THE `GridView` SHALL memiliki padding sebesar 16 piksel di semua sisi.

---

### Persyaratan 3: Desain Ulang ProfileCard dengan Tampilan Modern

**User Story:** Sebagai pengguna, saya ingin kartu profil terlihat lebih modern dan informatif, sehingga saya dapat dengan mudah mengenali setiap profil.

#### Kriteria Penerimaan

1. THE `ProfileCard` SHALL menampilkan gambar profil dengan ukuran radius 50 piksel dan diberi border berwarna putih dengan ketebalan 3 piksel.
2. THE `ProfileCard` SHALL menampilkan latar belakang kartu dengan efek gradasi warna yang berbeda untuk setiap profil (misalnya, biru-ungu untuk profil pertama, hijau-teal untuk profil kedua).
3. THE `ProfileCard` SHALL menampilkan nama profil dengan ukuran font 15sp, tebal (`FontWeight.bold`), berwarna putih, dan rata tengah.
4. THE `ProfileCard` SHALL menampilkan label pekerjaan dalam bentuk `Chip` atau `Badge` kecil dengan latar belakang putih semi-transparan dan teks berwarna putih berukuran 11sp.
5. THE `ProfileCard` SHALL memiliki sudut membulat (`borderRadius`) sebesar 24 piksel.
6. THE `ProfileCard` SHALL menampilkan bayangan (`boxShadow`) dengan `blurRadius` 12 piksel, `spreadRadius` 2 piksel, dan warna bayangan sesuai warna gradasi kartu dengan opasitas 40%.

---

### Persyaratan 4: Ikon Dekoratif pada Kartu Profil

**User Story:** Sebagai pengguna, saya ingin melihat ikon yang relevan dengan pekerjaan setiap profil pada kartu, sehingga informasi profil lebih mudah dipahami secara visual.

#### Kriteria Penerimaan

1. THE `ProfileCard` SHALL menampilkan ikon Material Design yang relevan dengan bidang pekerjaan profil (contoh: `Icons.school` untuk Mahasiswa, `Icons.code` untuk Programmer).
2. THE `ProfileCard` SHALL menampilkan ikon tersebut berukuran 16 piksel di sebelah kiri teks label pekerjaan di dalam `Chip`.

---

### Persyaratan 5: Animasi dan Interaksi Kartu Profil

**User Story:** Sebagai pengguna, saya ingin kartu profil memberikan respons visual saat saya menekannya, sehingga interaksi terasa lebih responsif dan menyenangkan.

#### Kriteria Penerimaan

1. WHEN pengguna menekan `ProfileCard`, THE `HomePage` SHALL menampilkan efek `InkWell` dengan `Ripple Effect` berwarna putih semi-transparan sebelum berpindah halaman.
2. WHEN pengguna menekan `ProfileCard`, THE `HomePage` SHALL menavigasi ke halaman profil yang sesuai menggunakan `Navigator.push` dengan `MaterialPageRoute`.
3. WHERE animasi `Hero` diaktifkan, THE `ProfileCard` SHALL membungkus gambar profil dengan widget `Hero` menggunakan `heroTag` unik berdasarkan nama profil, sehingga transisi antar halaman terasa mulus.

---

### Persyaratan 6: Tata Letak Grid yang Responsif

**User Story:** Sebagai pengguna, saya ingin daftar profil ditampilkan dalam tata letak yang rapi dan proporsional, sehingga tampilan nyaman dilihat di berbagai ukuran layar.

#### Kriteria Penerimaan

1. THE `GridView` SHALL menampilkan profil dalam 2 kolom dengan `crossAxisSpacing` 16 piksel dan `mainAxisSpacing` 16 piksel.
2. THE `GridView` SHALL menggunakan `childAspectRatio` sebesar 0.75 agar kartu memiliki proporsi tinggi yang cukup untuk menampilkan semua elemen visual.
3. THE `GridView` SHALL menampilkan seluruh daftar profil yang tersedia tanpa pemotongan konten pada kartu.

---

### Persyaratan 7: Konsistensi dan Aksesibilitas

**User Story:** Sebagai pengguna, saya ingin tampilan kartu profil konsisten dan mudah dibaca, sehingga saya tidak kesulitan memahami informasi yang ditampilkan.

#### Kriteria Penerimaan

1. THE `ProfileCard` SHALL menampilkan teks nama profil dengan kontras warna yang memenuhi standar keterbacaan (teks putih di atas latar gradasi gelap).
2. THE `ProfileCard` SHALL menampilkan gambar profil dengan `semanticLabel` yang sesuai dengan nama profil untuk mendukung aksesibilitas pembaca layar.
3. IF gambar profil gagal dimuat, THEN THE `ProfileCard` SHALL menampilkan ikon pengganti (`Icons.person`) dengan ukuran 50 piksel sebagai fallback.

# Rencana Implementasi: Redesign Halaman Daftar Profil

## Tasks

- [x] 1. Refaktor struktur data profil di `HomePage`
  - [x] 1.1 Tambahkan field `gradientColors` (List<Color>) ke setiap entri profil
  - [x] 1.2 Tambahkan field `jobIcon` (IconData) ke setiap entri profil
  - [x] 1.3 Pastikan data profil Alfan menggunakan gradasi biru-ungu dan ikon `Icons.school`
  - [x] 1.4 Pastikan data profil Ridwan menggunakan gradasi hijau-teal dan ikon `Icons.code`

- [x] 2. Redesign `AppBar` di `HomePage`
  - [x] 2.1 Ganti `AppBar` standar dengan `AppBar` yang menggunakan `flexibleSpace` berisi `Container` dengan `LinearGradient`
  - [x] 2.2 Set `elevation: 0` pada `AppBar`
  - [x] 2.3 Set judul "Daftar Profil" dengan `fontSize: 20`, `color: Colors.white`, dan `centerTitle: true`

- [x] 3. Redesign latar belakang `body` di `HomePage`
  - [x] 3.1 Bungkus `GridView` dengan `Container` yang memiliki `color: Color(0xFFF5F5F5)`
  - [x] 3.2 Set padding `GridView` menjadi `EdgeInsets.all(16)`

- [x] 4. Update konfigurasi `GridView`
  - [x] 4.1 Set `crossAxisSpacing: 16` dan `mainAxisSpacing: 16`
  - [x] 4.2 Set `childAspectRatio: 0.75`
  - [x] 4.3 Pastikan `itemCount` sesuai dengan panjang list profil

- [x] 5. Buat widget `ProfileCard` terpisah
  - [x] 5.1 Definisikan class `ProfileCard extends StatelessWidget` dengan parameter: `name`, `job`, `image`, `page`, `gradientColors`, `jobIcon`
  - [x] 5.2 Implementasikan `Container` dengan `BoxDecoration` gradasi, `borderRadius: 24`, dan `boxShadow` sesuai spesifikasi
  - [x] 5.3 Implementasikan `InkWell` dengan `splashColor: Colors.white30` dan `borderRadius: 24` untuk ripple effect
  - [x] 5.4 Implementasikan `Hero` widget membungkus gambar profil dengan `heroTag: name`
  - [x] 5.5 Implementasikan `CircleAvatar` dengan `radius: 50`, border putih 3px, dan fallback `Icons.person` saat gambar gagal
  - [x] 5.6 Implementasikan `Text` nama profil dengan `fontSize: 15`, `FontWeight.bold`, `color: Colors.white`, `textAlign: TextAlign.center`
  - [x] 5.7 Implementasikan `Chip` untuk label pekerjaan dengan `avatar: Icon(jobIcon, size: 16)`, latar belakang putih semi-transparan, dan teks putih 11sp
  - [x] 5.8 Implementasikan navigasi `Navigator.push` dengan `MaterialPageRoute` saat kartu ditekan
  - [x] 5.9 Tambahkan `semanticLabel` pada gambar profil sesuai nama profil

- [x] 6. Integrasikan `ProfileCard` ke dalam `GridView` di `HomePage`
  - [x] 6.1 Ganti `GestureDetector` + `Container` lama dengan widget `ProfileCard` baru
  - [x] 6.2 Pastikan semua parameter diteruskan dengan benar dari data profil ke `ProfileCard`

- [x] 7. Verifikasi hasil implementasi
  - [x] 7.1 Pastikan tidak ada error kompilasi (`flutter analyze`)
  - [x] 7.2 Pastikan navigasi ke `ProfileAlfan` dan `ProfileRidwan` masih berfungsi
  - [x] 7.3 Pastikan tampilan kartu sesuai dengan spesifikasi desain

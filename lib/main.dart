import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyProfileApp());
}

class MyProfileApp extends StatelessWidget {
  const MyProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile M Ridwan',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late VideoPlayerController _controller;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _showOverlay = true;
  Timer? _overlayTimer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/videos/video_perkenalan.mp4',
    )..initialize().then((_) {
        setState(() {});
        _controller.addListener(() {
          if (_controller.value.isPlaying && _showOverlay) {
            _overlayTimer?.cancel();
            _overlayTimer = Timer(const Duration(seconds: 2), () {
              if (mounted) setState(() => _showOverlay = false);
            });
          }
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _overlayTimer?.cancel();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
      Navigator.pop(context);
    }
  }

  void _showEditPhotoOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Ganti Foto Profil', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Kamera'),
              onTap: () => _pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeri'),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade900, Colors.blue.shade50],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              
              // --- FOTO PROFILE ---
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!) as ImageProvider
                            : const AssetImage('assets/images/ridwan.jpg'),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _showEditPhotoOptions,
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Icon(Icons.edit, color: Colors.blue, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text('M Ridwan', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
              const Text('Universitas Al-Azhar Indonesia', style: TextStyle(fontSize: 16, color: Colors.white70)),

              const SizedBox(height: 25),

              // --- DATA AKADEMIK & INFO ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _infoRow(Icons.badge, 'NIM', '0112523022'),
                        const Divider(),
                        _infoRow(Icons.school, 'Status', 'Mahasiswa Teknik Informatika'),
                        const Divider(),
                        _infoRow(Icons.email, 'Email', 'mridwan07072002@gmail.com'),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // --- SOSIAL MEDIA ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialBtn('LinkedIn', 'https://www.linkedin.com/in/muhammad-ridwan-8aa23726a/', const Color(0xFF0077B5)),
                  const SizedBox(width: 15),
                  _socialBtn('Instagram', 'https://www.instagram.com/muhridwaan_/', const Color(0xFFE4405F)),
                ],
              ),

              const SizedBox(height: 30),
              
              // --- VIDEO SECTION ---
              _videoSection(),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue.shade700),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _socialBtn(String label, String url, Color color) {
    return ActionChip(
      avatar: Icon(Icons.link, color: color, size: 18),
      label: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      onPressed: () => launchUrl(Uri.parse(url)),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

 Widget _videoSection() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Video Perkenalan', 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        
        // Bungkus dengan AspectRatio agar ukurannya pas dengan video
        if (_controller.value.isInitialized)
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                alignment: Alignment.center, // Ini kunci biar tombol di tengah
                children: [
                  // 1. Layer Video
                  VideoPlayer(_controller),

                  // 2. Layer Tombol (Hanya muncul kalau di-tap)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showOverlay = !_showOverlay;
                      });
                    },
                    child: AnimatedOpacity(
                      opacity: _showOverlay ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        color: Colors.black38, // Background gelap transparan
                        child: Center(
                          child: IconButton(
                            iconSize: 64,
                            icon: Icon(
                              _controller.value.isPlaying 
                                  ? Icons.pause_circle_filled 
                                  : Icons.play_circle_filled,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                  _showOverlay = true;
                                } else {
                                  _controller.play();
                                  // Tombol otomatis hilang nanti via Timer di initState
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    ),
  );
}
}
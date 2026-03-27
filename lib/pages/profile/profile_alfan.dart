import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ProfileAlfan extends StatefulWidget {
  const ProfileAlfan({super.key});

  @override
  State<ProfileAlfan> createState() => _ProfileAlfanState();
}

class _ProfileAlfanState extends State<ProfileAlfan> {
  File? _imageFile;
  File? _videoFile;
  VideoPlayerController? _controller;

  final ImagePicker _picker = ImagePicker();

  // 📸 Ambil Foto
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // 🎥 Ambil Video
  Future<void> pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      _videoFile = File(pickedFile.path);

      _controller = VideoPlayerController.file(_videoFile!)
        ..initialize().then((_) {
          setState(() {});
          _controller!.play();
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Alfan"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 🔥 FOTO PROFILE
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : const AssetImage("assets/images/alfan.jpg")
                        as ImageProvider,
              ),
            ),

            const SizedBox(height: 10),
            const Text("Tap untuk ganti foto"),

            const SizedBox(height: 20),

            const Text(
              "Alfan Nurkhasani",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text("Fullstack Developer"),

            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Mahasiswa Informatika yang tertarik pada pengembangan web dan keamanan siber.",
                textAlign: TextAlign.center,
              ),
            ),

            const Divider(),

            // 🎥 VIDEO SECTION
            const Text(
              "Upload Video",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: pickVideo,
              icon: const Icon(Icons.video_library),
              label: const Text("Pilih Video"),
            ),

            const SizedBox(height: 20),

            // 🔥 PREVIEW VIDEO
            if (_controller != null && _controller!.value.isInitialized)
              AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

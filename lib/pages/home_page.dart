import 'package:flutter/material.dart';
import '../pages/profile/Alfan.dart';
import '../pages/profile/Ridwan.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Map<String, dynamic>> profiles = [
    {
      "name": "Alfan Nurkhasani",
      "job": "Mahasiswa",
      "image": "assets/images/alfan.jpg",
      "page": ProfileAlfan(),
    },
    {
      "name": "M. Ridwan",
      "job": "Programmer",
      "image": "assets/images/ridwan.jpg",
      "page": ProfileRidwan(),
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Profile"),
        centerTitle: true,
        elevation: 2,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: profiles.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 kolom
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final profile = profiles[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => profile["page"],
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black12,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(profile["image"]),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    profile["name"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile["job"],
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../pages/profile/profile_alfan.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> profiles = [
      {
        "name": "Alfan Nurkhasani",
        "job": "Fullstack Developer",
        "image": "assets/images/alfan.jpg",
        "page": ProfileAlfan(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Profile"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];

          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage(profile["image"]),
              ),
              title: Text(
                profile["name"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(profile["job"]),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => profile["page"],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

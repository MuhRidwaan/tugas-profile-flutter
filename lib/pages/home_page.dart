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
      "page": const ProfileAlfan(),
      "gradientColors": [const Color(0xFF1565C0), const Color(0xFF7B1FA2)],
      "jobIcon": Icons.school,
    },
    {
      "name": "M. Ridwan",
      "job": "Programmer",
      "image": "assets/images/ridwan.jpg",
      "page": const ProfileRidwan(),
      "gradientColors": [const Color(0xFF2E7D32), const Color(0xFF00695C)],
      "jobIcon": Icons.code,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar Profil",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF1565C0), Color(0xFF7B1FA2)],
            ),
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFF5F5F5),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: profiles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final profile = profiles[index];
            return ProfileCard(
              name: profile["name"] as String,
              job: profile["job"] as String,
              image: profile["image"] as String,
              page: profile["page"] as Widget,
              gradientColors: profile["gradientColors"] as List<Color>,
              jobIcon: profile["jobIcon"] as IconData,
            );
          },
        ),
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              spreadRadius: 2,
              color: gradientColors[0].withOpacity(0.4),
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          splashColor: Colors.white30,
          highlightColor: Colors.white10,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => page),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Foto profil dengan Hero animation
                Hero(
                  tag: name,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white24,
                      child: ClipOval(
                        child: Image.asset(
                          image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          semanticLabel: name,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Nama profil
                Text(
                  name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                // Chip pekerjaan
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        jobIcon,
                        size: 14,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        job,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

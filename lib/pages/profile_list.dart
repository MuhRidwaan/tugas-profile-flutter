import 'package:flutter/material.dart';
import '../profile/Alfan.dart';
import '../profile/Ridwan.dart';
import '../profile/Nia.dart';
import '../profile/Azzam.dart';

class ProfileList extends StatelessWidget {
  const ProfileList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Our Team",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF6A11CB),  // Ungu elegan
                Color(0xFF2575FC),  // Biru
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5F0FF),  // Putih ungu soft
              Color(0xFFE8E2F5),  // Lavender soft
            ],
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            final profiles = [
              {
                "name": "Alfan Nurkhasani",
                "job": "UI/UX Designer",
                "image": "assets/images/alfan.jpg",
                "page": const ProfileAlfan(),
                "gradientColors": const [
                  Color(0xFFFF6B6B),  // Coral
                  Color(0xFFFF8E53),  // Orange
                  Color(0xFFFFB347),  // Yellow Orange
                ],
                "jobIcon": Icons.palette,
              },
              {
                "name": "M. Ridwan",
                "job": "Programmer",
                "image": "assets/images/ridwan.jpg",
                "page": const ProfileRidwan(),
                "gradientColors": const [
                  Color(0xFF4FACFE),  // Blue
                  Color(0xFF00F2FE),  // Cyan
                  Color(0xFF43E97B),  // Green
                ],
                "jobIcon": Icons.code,
              },
              {
                "name": "Nia Astuti",
                "job": "Data Analyst",
                "image": "assets/images/nia.jpeg",
                "page": const ProfileNia(),
                "gradientColors": const [
                  Color(0xFFFA709A),  // Pink
                  Color(0xFFFEE140),  // Yellow
                  Color(0xFFC471F5),  // Purple
                ],
                "jobIcon": Icons.analytics,
              },
              {
                "name": "Azzam Abdullah Umar",
                "job": "Network Engineer",
                "image": "assets/images/azzam.jpeg",
                "page": const ProfileAzzam(),
                "gradientColors": const [
                  Color(0xFF5EE7DF),  // Teal
                  Color(0xFFB490CA),  // Lavender
                  Color(0xFFD4A5A5),  // Soft Pink
                ],
                "jobIcon": Icons.wifi,
              },
            ];
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
            stops: const [0.0, 0.5, 1.0],
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              spreadRadius: 2,
              color: gradientColors[0].withOpacity(0.5),
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1.5,
          ),
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
                Hero(
                  tag: name,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
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
                const SizedBox(height: 12),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black26,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        jobIcon,
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        job,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
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
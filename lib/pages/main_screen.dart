import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'explore_page.dart';
import 'profile_list.dart';
import 'settings_page.dart';
import 'dashboard/dashboard_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    
    final List<Widget> pages = [];
    final List<BottomNavigationBarItem> items = [];

    // Check dashboard permission
    if (auth.hasPermission('view_dashboard')) {
      pages.add(const DashboardPage());
      items.add(const BottomNavigationBarItem(
        icon: Icon(Icons.dashboard_outlined),
        activeIcon: Icon(Icons.dashboard),
        label: 'Dashboard',
      ));
    }

    // Profile page (no specific permission mentioned, let's show it by default or 'view_profile')
    // We'll show it if they have view_dashboard or just always show for now.
    // Actually, maybe no specific permission for profile and explore? Let's show them for now.
    pages.add(const ProfileList());
    items.add(const BottomNavigationBarItem(
      icon: Icon(Icons.people_outline),
      activeIcon: Icon(Icons.people),
      label: 'Profil',
    ));

    pages.add(const ExplorePage());
    items.add(const BottomNavigationBarItem(
      icon: Icon(Icons.explore_outlined),
      activeIcon: Icon(Icons.explore),
      label: 'Explore',
    ));

    // Settings page
    pages.add(const SettingsPage());
    items.add(const BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      activeIcon: Icon(Icons.settings),
      label: 'Pengaturan',
    ));

    // Prevent index out of bounds if permissions change
    if (_currentIndex >= pages.length) {
      _currentIndex = 0;
    }

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: items.length > 1 ? BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: const Color(0xFF1565C0),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        elevation: 12,
        items: items,
      ) : null,
    );
  }
}

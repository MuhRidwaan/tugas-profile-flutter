import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'users/user_management_page.dart';
import 'roles/role_management_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengaturan',
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
      body: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              if (auth.hasPermission('manage_users'))
                ListTile(
                  leading: const Icon(Icons.people),
                  title: const Text('Manajemen Pengguna'),
                  subtitle: const Text('Tambah, hapus, dan atur role pengguna'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const UserManagementPage()),
                    );
                  },
                ),
              if (auth.hasPermission('manage_users'))
                const Divider(),
              
              if (auth.hasPermission('manage_roles'))
                ListTile(
                  leading: const Icon(Icons.admin_panel_settings),
                  title: const Text('Manajemen Role'),
                  subtitle: const Text('Tambah role dan atur hak akses'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RoleManagementPage()),
                    );
                  },
                ),
              if (auth.hasPermission('manage_roles'))
                const Divider(),

              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Logout', style: TextStyle(color: Colors.red)),
                onTap: () {
                  auth.logout();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

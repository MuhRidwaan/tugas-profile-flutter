import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/role_provider.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().fetchUsers();
      context.read<RoleProvider>().fetchRolesAndPermissions();
    });
  }

  void _showAddUserDialog() {
    final usernameCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    int? selectedRoleId;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            final roles = context.watch<RoleProvider>().roles;
            return AlertDialog(
              title: const Text('Tambah User Baru'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: usernameCtrl,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: passwordCtrl,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  DropdownButtonFormField<int>(
                    value: selectedRoleId,
                    decoration: const InputDecoration(labelText: 'Role'),
                    items: roles.map((r) => DropdownMenuItem(
                      value: r.id,
                      child: Text(r.roleName),
                    )).toList(),
                    onChanged: (val) {
                      setStateDialog(() => selectedRoleId = val);
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<UserProvider>().createUser(
                      usernameCtrl.text,
                      passwordCtrl.text,
                      selectedRoleId,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Simpan'),
                )
              ],
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProv = context.watch<UserProvider>();
    final roleProv = context.watch<RoleProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen User'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddUserDialog,
        child: const Icon(Icons.add),
      ),
      body: userProv.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: userProv.users.length,
              itemBuilder: (context, index) {
                final user = userProv.users[index];
                final role = roleProv.roles.where((r) => r.id == user.roleId).firstOrNull;
                
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(user.username),
                  subtitle: Text(role?.roleName ?? 'Tanpa Role'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      userProv.deleteUser(user.id);
                    },
                  ),
                );
              },
            ),
    );
  }
}

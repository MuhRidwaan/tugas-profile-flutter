import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/role_provider.dart';

class EditRolePermissionsPage extends StatefulWidget {
  final int roleId;
  final String roleName;

  const EditRolePermissionsPage({
    super.key,
    required this.roleId,
    required this.roleName,
  });

  @override
  State<EditRolePermissionsPage> createState() => _EditRolePermissionsPageState();
}

class _EditRolePermissionsPageState extends State<EditRolePermissionsPage> {
  List<int> _selectedPermissions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPermissions();
  }

  Future<void> _loadPermissions() async {
    final roleProv = context.read<RoleProvider>();
    final pIds = await roleProv.getRolePermissionIds(widget.roleId);
    setState(() {
      _selectedPermissions = pIds;
      _isLoading = false;
    });
  }

  String _formatPermissionName(String raw) {
    switch (raw) {
      case 'manage_users': return 'Manajemen Pengguna';
      case 'manage_roles': return 'Manajemen Role';
      case 'view_dashboard': return 'Akses Dashboard';
      case 'view_zodiac': return 'Lihat Info Zodiak';
      case 'edit_zodiac': return 'Edit Data Zodiak';
      case 'view_quiz_poll': return 'Akses Quiz & Poll';
      case 'view_calculator': return 'Akses Kalkulator';
      case 'view_conditional': return 'Akses Latihan Percabangan';
      case 'view_number_series': return 'Akses Latihan Bilangan';
      case 'view_sorting': return 'Akses Algoritma Sorting';
      default: return raw.replaceAll('_', ' ').toUpperCase();
    }
  }

  IconData _getPermissionIcon(String raw) {
    switch (raw) {
      case 'manage_users': return Icons.people;
      case 'manage_roles': return Icons.admin_panel_settings;
      case 'view_dashboard': return Icons.dashboard;
      case 'view_zodiac':
      case 'edit_zodiac': return Icons.star;
      case 'view_quiz_poll': return Icons.quiz;
      case 'view_calculator': return Icons.calculate;
      case 'view_conditional': return Icons.account_tree;
      case 'view_number_series': return Icons.format_list_numbered;
      case 'view_sorting': return Icons.sort;
      default: return Icons.lock;
    }
  }

  @override
  Widget build(BuildContext context) {
    final roleProv = context.watch<RoleProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Edit Hak Akses',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Header Profil Role
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1565C0).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.security,
                          size: 48,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.roleName.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Pilih fitur yang dapat diakses oleh role ini',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // List Permissions
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: roleProv.allPermissions.length,
                    itemBuilder: (context, index) {
                      final perm = roleProv.allPermissions[index];
                      final isSelected = _selectedPermissions.contains(perm.id);

                      return Card(
                        elevation: isSelected ? 4 : 1,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: isSelected ? const Color(0xFF1565C0) : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedPermissions.remove(perm.id);
                              } else {
                                _selectedPermissions.add(perm.id);
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: CheckboxListTile(
                              title: Text(
                                _formatPermissionName(perm.permissionName),
                                style: TextStyle(
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              secondary: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isSelected 
                                      ? const Color(0xFF1565C0).withOpacity(0.1)
                                      : Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  _getPermissionIcon(perm.permissionName),
                                  color: isSelected ? const Color(0xFF1565C0) : Colors.grey,
                                ),
                              ),
                              value: isSelected,
                              activeColor: const Color(0xFF1565C0),
                              checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  if (val == true) {
                                    _selectedPermissions.add(perm.id);
                                  } else {
                                    _selectedPermissions.remove(perm.id);
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -5),
            )
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: _isLoading ? null : () async {
              setState(() => _isLoading = true);
              await roleProv.updateRolePermissions(widget.roleId, _selectedPermissions);
              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Hak akses berhasil disimpan!')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: const Color(0xFF1565C0),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: const Text(
              'Simpan Perubahan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

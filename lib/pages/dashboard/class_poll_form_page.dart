import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/class_poll_provider.dart';

class ClassPollFormPage extends StatefulWidget {
  const ClassPollFormPage({super.key});

  @override
  State<ClassPollFormPage> createState() => _ClassPollFormPageState();
}

class _ClassPollFormPageState extends State<ClassPollFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _shoeSizeController = TextEditingController();
  final _ageController = TextEditingController();

  String? _selectedShirtSize;
  final List<String> _shirtSizes = ['S', 'M', 'L', 'XL', 'XXL'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadExistingData();
    });
  }

  void _loadExistingData() async {
    final authProvider = context.read<AuthProvider>();
    final pollProvider = context.read<ClassPollProvider>();
    final userId = authProvider.currentUser?.id;

    if (userId != null) {
      await pollProvider.loadUserPoll(userId);
      final data = pollProvider.currentUserData;
      if (data != null && mounted) {
        setState(() {
          _weightController.text = data.weight.toString();
          _heightController.text = data.height.toString();
          _shoeSizeController.text = data.shoeSize.toString();
          _ageController.text = data.age.toString();
          _selectedShirtSize = data.shirtSize;
        });
      }
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _shoeSizeController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedShirtSize != null) {
      final authProvider = context.read<AuthProvider>();
      final pollProvider = context.read<ClassPollProvider>();
      final userId = authProvider.currentUser?.id;

      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Anda harus login terlebih dahulu')),
        );
        return;
      }

      pollProvider.submitPoll(
        userId: userId,
        weight: double.parse(_weightController.text),
        height: double.parse(_heightController.text),
        shirtSize: _selectedShirtSize!,
        shoeSize: int.parse(_shoeSizeController.text),
        age: int.parse(_ageController.text),
      ).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data polling berhasil disimpan!')),
        );
        Navigator.pop(context);
      });
    } else {
      if (_selectedShirtSize == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pilih ukuran baju Anda!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isi Data Polling Kelas'),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lengkapi Data Anda',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Data ini akan digunakan secara anonim untuk menampilkan statistik grafik kelas di Dashboard.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),

              _buildNumberField(
                controller: _weightController,
                label: 'Berat Badan (kg)',
                icon: Icons.monitor_weight,
              ),
              const SizedBox(height: 16),

              _buildNumberField(
                controller: _heightController,
                label: 'Tinggi Badan (cm)',
                icon: Icons.height,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedShirtSize,
                decoration: const InputDecoration(
                  labelText: 'Ukuran Baju',
                  prefixIcon: Icon(Icons.checkroom),
                  border: OutlineInputBorder(),
                ),
                items: _shirtSizes.map((size) {
                  return DropdownMenuItem(
                    value: size,
                    child: Text(size),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedShirtSize = val;
                  });
                },
              ),
              const SizedBox(height: 16),

              _buildNumberField(
                controller: _shoeSizeController,
                label: 'Nomor Sepatu',
                icon: Icons.do_not_step,
              ),
              const SizedBox(height: 16),

              _buildNumberField(
                controller: _ageController,
                label: 'Usia',
                icon: Icons.cake,
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1565C0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Simpan Data'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Mohon isi $label';
        }
        if (double.tryParse(value) == null) {
          return 'Masukkan angka yang valid';
        }
        return null;
      },
    );
  }
}

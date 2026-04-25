import 'package:flutter/material.dart';
import 'utils/rumus.dart';
import 'widgets/input_field.dart';

class CalcPage extends StatefulWidget {
  const CalcPage({super.key});

  @override
  State<CalcPage> createState() => _CalcPageState();
}

class _CalcPageState extends State<CalcPage> {
  static const Color _primaryBlue = Color(0xFF1565C0);
  static const Color _accentPurple = Color(0xFF7B1FA2);

  String selectedRumus = 'Luas Segitiga';

  final input1 = TextEditingController();
  final input2 = TextEditingController();

  double hasil = 0;

  Map<String, dynamic> get _activeMeta {
    switch (selectedRumus) {
      case 'Luas Segitiga':
        return {
          'icon': Icons.change_history,
          'subtitle': 'L = 1/2 x alas x tinggi',
          'unit': 'cm2',
        };
      case 'Isi Tabung':
        return {
          'icon': Icons.stacked_line_chart,
          'subtitle': 'V = pi x r x r x t',
          'unit': 'cm3',
        };
      case 'Luas Kotak':
        return {
          'icon': Icons.crop_square,
          'subtitle': 'L = sisi x sisi',
          'unit': 'cm2',
        };
      case 'Luas Lingkaran':
        return {
          'icon': Icons.circle_outlined,
          'subtitle': 'L = pi x r x r',
          'unit': 'cm2',
        };
      default:
        return {
          'icon': Icons.calculate_outlined,
          'subtitle': '',
          'unit': '',
        };
    }
  }

  @override
  void dispose() {
    input1.dispose();
    input2.dispose();
    super.dispose();
  }

  void hitung() {
    double a = double.tryParse(input1.text) ?? 0;
    double b = double.tryParse(input2.text) ?? 0;

    if (selectedRumus == 'Luas Segitiga') {
      hasil = luasSegitiga(a, b);
    } else if (selectedRumus == 'Luas Kotak') {
      hasil = luasKotak(a);
    } else if (selectedRumus == 'Luas Lingkaran') {
      hasil = luasLingkaran(a);
    } else if (selectedRumus == 'Isi Tabung') {
      hasil = volumeTabung(a, b);
    }

    setState(() {});
  }

  String getLabel1() {
    if (selectedRumus == 'Luas Segitiga') return 'Alas';
    if (selectedRumus == 'Isi Tabung') return 'Jari-jari';
    if (selectedRumus == 'Luas Kotak') return 'Sisi';
    if (selectedRumus == 'Luas Lingkaran') return 'Jari-jari';
    return 'Input 1';
  }

  String getLabel2() {
    if (selectedRumus == 'Luas Segitiga') return 'Tinggi';
    if (selectedRumus == 'Isi Tabung') return 'Tinggi';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final meta = _activeMeta;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(
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
              colors: [_primaryBlue, _accentPurple],
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
              Color(0xFFF5F7FA),
              Color(0xFFE8EAF6),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 14,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _accentPurple.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:
                          Icon(meta['icon'] as IconData, color: _accentPurple),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedRumus,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF263238),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            meta['subtitle'] as String,
                            style: const TextStyle(
                              color: Color(0xFF607D8B),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Card(
                elevation: 3,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: selectedRumus,
                        decoration: InputDecoration(
                          labelText: 'Pilih rumus',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: [
                          'Luas Segitiga',
                          'Isi Tabung',
                          'Luas Kotak',
                          'Luas Lingkaran'
                        ].map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedRumus = val!;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      InputField(
                        label: getLabel1(),
                        hint: 'Masukkan ${getLabel1().toLowerCase()}',
                        icon: Icons.straighten,
                        controller: input1,
                      ),
                      if (selectedRumus == 'Luas Segitiga' ||
                          selectedRumus == 'Isi Tabung')
                        InputField(
                          label: getLabel2(),
                          hint: 'Masukkan ${getLabel2().toLowerCase()}',
                          icon: Icons.height,
                          controller: input2,
                        ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: hitung,
                          icon: const Icon(Icons.calculate_outlined),
                          label: const Text(
                            'Hitung',
                            style: TextStyle(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _accentPurple,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_primaryBlue, _accentPurple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text(
                      'HASIL PERHITUNGAN',
                      style: TextStyle(
                        color: Colors.white70,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${hasil.toStringAsFixed(2)} ${meta['unit']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class GeometryCalculator extends StatefulWidget {
  const GeometryCalculator({super.key});

  @override
  State<GeometryCalculator> createState() => _GeometryCalculatorState();
}

class _GeometryCalculatorState extends State<GeometryCalculator> {
  int _selectedIndex = 0;
  
  final TextEditingController _input1 = TextEditingController();
  final TextEditingController _input2 = TextEditingController();
  
  double _hasil = 0;
  bool _isCalculated = false;
  String _rumus = "";
  String _satuan = "cm²";

  final List<Map<String, dynamic>> _menus = [
    {
      "name": "Luas Segitiga",
      "icon": Icons.change_history,
      "inputs": [
        {"label": "Alas (cm)", "hint": "Masukkan panjang alas"},
        {"label": "Tinggi (cm)", "hint": "Masukkan tinggi segitiga"},
      ],
      "rumus": "L = ½ × alas × tinggi",
      "satuan": "cm²",
    },
    {
      "name": "Isi Tabung",
      "icon": Icons.speed,
      "inputs": [
        {"label": "Jari-jari (cm)", "hint": "Masukkan jari-jari"},
        {"label": "Tinggi (cm)", "hint": "Masukkan tinggi tabung"},
      ],
      "rumus": "V = π × r² × t",
      "satuan": "cm³",
    },
    {
      "name": "Luas Kotak",
      "icon": Icons.crop_square,
      "inputs": [
        {"label": "Panjang (cm)", "hint": "Masukkan panjang"},
        {"label": "Lebar (cm)", "hint": "Masukkan lebar"},
      ],
      "rumus": "L = p × l",
      "satuan": "cm²",
    },
    {
      "name": "Luas Lingkaran",
      "icon": Icons.radio_button_unchecked,
      "inputs": [
        {"label": "Jari-jari (cm)", "hint": "Masukkan jari-jari"},
      ],
      "rumus": "L = π × r²",
      "satuan": "cm²",
    },
  ];

  void _hitung() {
    double nilai1 = double.tryParse(_input1.text) ?? 0;
    double nilai2 = double.tryParse(_input2.text) ?? 0;
    double hasil = 0;

    switch (_selectedIndex) {
      case 0:
        hasil = 0.5 * nilai1 * nilai2;
        break;
      case 1:
        hasil = 3.14159 * nilai1 * nilai1 * nilai2;
        break;
      case 2:
        hasil = nilai1 * nilai2;
        break;
      case 3:
        hasil = 3.14159 * nilai1 * nilai1;
        break;
    }

    setState(() {
      _hasil = hasil;
      _isCalculated = true;
      _rumus = _menus[_selectedIndex]["rumus"];
      _satuan = _menus[_selectedIndex]["satuan"];
    });
  }

  void _reset() {
    _input1.clear();
    _input2.clear();
    setState(() {
      _hasil = 0;
      _isCalculated = false;
    });
  }

  void _changeMenu(int index) {
    setState(() {
      _selectedIndex = index;
      _reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentMenu = _menus[_selectedIndex];
    final inputs = currentMenu["inputs"] as List;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kalkulator Geometri",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1B8E3E),  // Hijau Zakat
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9),  // Hijau sangat muda
              Color(0xFFC8E6C9),  // Hijau muda
              Color(0xFFA5D6A7),  // Hijau soft
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_menus.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: FilterChip(
                        selected: _selectedIndex == index,
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(_menus[index]["icon"], size: 18),
                            const SizedBox(width: 8),
                            Text(_menus[index]["name"]),
                          ],
                        ),
                        onSelected: (_) => _changeMenu(index),
                        backgroundColor: Colors.white,
                        selectedColor: const Color(0xFF2E7D32),  // Hijau tua
                        labelStyle: TextStyle(
                          color: _selectedIndex == index ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(currentMenu["icon"], size: 60, color: const Color(0xFF2E7D32)),
                    const SizedBox(height: 16),
                    Text(currentMenu["name"], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                    const SizedBox(height: 8),
                    Text(currentMenu["rumus"], style: const TextStyle(fontSize: 14, color: Colors.grey, fontStyle: FontStyle.italic)),
                    const SizedBox(height: 24),
                    for (int i = 0; i < inputs.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: TextField(
                          controller: i == 0 ? _input1 : _input2,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: inputs[i]["label"],
                            hintText: inputs[i]["hint"],
                            prefixIcon: const Icon(Icons.edit),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _hitung,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E7D32),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text("Hitung", style: TextStyle(fontSize: 16, color: Colors.white)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _reset,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text("Reset"),
                          ),
                        ),
                      ],
                    ),
                    if (_isCalculated) ...[
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 10)],
                        ),
                        child: Column(
                          children: [
                            const Text("Hasil Perhitungan:", style: TextStyle(fontSize: 16)),
                            const SizedBox(height: 8),
                            Text("${_hasil.toStringAsFixed(2)} $_satuan", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                            const SizedBox(height: 8),
                            Text(_rumus, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../database/app_database.dart';
import '../../services/zodiac_service.dart';
import 'constants/zodiac_constants.dart';
import 'widgets/query_by_name_tab.dart';
import 'widgets/query_by_date_tab.dart';

class ZodiacPage extends StatefulWidget {
  final ZodiacService? service;
  final AppDatabase? database;

  const ZodiacPage({super.key, this.service, this.database});

  @override
  State<ZodiacPage> createState() => _ZodiacPageState();
}

class _ZodiacPageState extends State<ZodiacPage> {
  late final AppDatabase _database;
  late final ZodiacService _service;
  late final bool _isTesting;

  @override
  void initState() {
    super.initState();
    _isTesting = widget.database != null || widget.service != null;
    _database = widget.database ?? AppDatabase();
    _service = widget.service ?? ZodiacService(_database);
  }

  @override
  void dispose() {
    if (!_isTesting) {
      _database.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ZodiacConstants.backgroundColor,
        appBar: AppBar(
          title: const Text(
            ZodiacConstants.appTitle,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
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
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3.0,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 15),
            tabs: [
              Tab(
                icon: Icon(Icons.abc),
                text: 'Nama Zodiak',
              ),
              Tab(
                icon: Icon(Icons.calendar_month),
                text: 'Tanggal Lahir',
              ),
            ],
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
          child: TabBarView(
            children: [
              QueryByNameTab(service: _service),
              QueryByDateTab(service: _service),
            ],
          ),
        ),
      ),
    );
  }
}

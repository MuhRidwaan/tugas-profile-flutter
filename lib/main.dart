import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database/app_database.dart';
import 'pages/main_screen.dart';
import 'pages/auth/login_page.dart';
import 'providers/poll_provider.dart';
import 'providers/quiz_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/role_provider.dart';
import 'providers/user_provider.dart';
import 'repositories/poll_repository.dart';
import 'repositories/quiz_repository.dart';
import 'repositories/auth_repository.dart';
import 'repositories/role_repository.dart';
import 'repositories/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final db = AppDatabase();
  
  final authRepository = AuthRepository(db);
  final roleRepository = RoleRepository(db);
  final userRepository = UserRepository(db);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => QuizProvider(QuizRepository(prefs)),
        ),
        ChangeNotifierProvider(
          create: (_) => PollProvider(PollRepository(prefs)),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(authRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => RoleProvider(roleRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(userRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return MaterialApp(
          title: 'MiniProject',
          home: auth.isAuthenticated ? const MainScreen() : const LoginPage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

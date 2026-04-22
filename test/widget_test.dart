import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:profile_tugas/main.dart';
import 'package:profile_tugas/providers/poll_provider.dart';
import 'package:profile_tugas/providers/quiz_provider.dart';
import 'package:profile_tugas/repositories/poll_repository.dart';
import 'package:profile_tugas/repositories/quiz_repository.dart';

void main() {
  testWidgets('App loads and shows profile list', (WidgetTester tester) async {
    // Initialize SharedPreferences for testing
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    // Build our app with providers
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => QuizProvider(QuizRepository(prefs)),
          ),
          ChangeNotifierProvider(
            create: (_) => PollProvider(PollRepository(prefs)),
          ),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify that the app shows the profile list (Our Team)
    expect(find.text('Our Team'), findsOneWidget);

    // Verify that bottom navigation bar exists
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Verify navigation items exist
    expect(find.text('Profil'), findsOneWidget);
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('Quiz & Poll'), findsOneWidget);
    expect(find.text('Pengaturan'), findsOneWidget);
  });
}

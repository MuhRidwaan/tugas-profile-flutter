import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_tugas/pages/zodiac/widgets/description_section.dart';

void main() {
  testWidgets('DescriptionSection renders title, content, and icon correctly', (WidgetTester tester) async {
    const title = 'Asmara';
    const content = 'Asmara Aries dipenuhi dengan gairah.';
    const icon = Icons.favorite;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DescriptionSection(
            title: title,
            content: content,
            icon: icon,
          ),
        ),
      ),
    );

    expect(find.text(title), findsOneWidget);
    expect(find.text(content), findsOneWidget);
    expect(find.byIcon(icon), findsOneWidget);
  });

  testWidgets('DescriptionSection returns empty SizedBox when content is empty', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DescriptionSection(
            title: 'Title',
            content: '',
            icon: Icons.star,
          ),
        ),
      ),
    );

    expect(find.byType(Card), findsNothing);
  });
}

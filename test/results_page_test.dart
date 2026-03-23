import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mvp/widgets/results_page.dart';

void main() {
  testWidgets('ResultsPage shows filters and result cards', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ResultsPage()));
    await tester.pumpAndSettle();

    expect(find.text('Results'), findsOneWidget);
    expect(find.text('Select Game'), findsOneWidget);
    expect(find.text('Quiniela - Morning'), findsOneWidget);
    expect(find.text('Quiniela - Afternoon'), findsOneWidget);
    expect(find.text('Quini6 - Traditional'), findsOneWidget);
    expect(find.text('Check If I Won'), findsNWidgets(2));
  });

  testWidgets('ResultsPage lets you change the selected date', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ResultsPage()));
    await tester.pumpAndSettle();

    final today = _formatDate(DateTime.now());
    final yesterday = _formatDate(DateTime.now().subtract(const Duration(days: 1)));

    expect(find.text(today), findsWidgets);

    await tester.tap(find.text('Yesterday'));
    await tester.pumpAndSettle();

    expect(find.text('Yesterday'), findsOneWidget);
    expect(find.text(yesterday), findsWidgets);
  });
}

String _formatDate(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}

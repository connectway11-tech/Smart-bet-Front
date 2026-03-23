import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mvp/widgets/app_shell.dart';

void main() {
  testWidgets('AppShell navigates between top sections', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AppShell()));
    await tester.pumpAndSettle();

    expect(find.text('¿Qué querés jugar hoy?'), findsOneWidget);

    await tester.tap(find.text('Mis Números'));
    await tester.pumpAndSettle();
    expect(find.text('Mis Números'), findsAtLeastNWidgets(1));
    expect(find.text('Tus combinaciones guardadas para jugar más rápido'), findsOneWidget);
    expect(find.text('Combinaciones Guardadas'), findsOneWidget);
    expect(find.text('Agregar Nueva'), findsOneWidget);
    expect(find.text('Selección activa'), findsOneWidget);

    await tester.tap(find.text('Brinco').first);
    await tester.pumpAndSettle();
    expect(find.text('Rápidas para Brinco'), findsOneWidget);
    expect(find.text('Jugar esta'), findsOneWidget);

    await tester.tap(find.text('Historial'));
    await tester.pumpAndSettle();
    expect(find.text('Revisá tus últimas jugadas y su estado'), findsOneWidget);
    expect(find.text('Ganados'), findsOneWidget);
    expect(find.text('Invertido'), findsOneWidget);

    await tester.tap(find.text('Pendientes'));
    await tester.pumpAndSettle();
    expect(find.text('Sortea a las 21:15 hs'), findsOneWidget);

    await tester.tap(find.text('Resultados'));
    await tester.pumpAndSettle();
    expect(find.text('Select Game'), findsOneWidget);
    expect(find.text('Results'), findsOneWidget);
  });
}

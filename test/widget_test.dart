import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mvp/widgets/app_shell.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  testWidgets('MyApp shell renders the main navigation', (WidgetTester tester) async {
    GoogleFonts.config.allowRuntimeFetching = false;

    await tester.pumpWidget(const MaterialApp(home: AppShell()));
    await tester.pumpAndSettle();

    expect(find.text('Inicio'), findsOneWidget);
    expect(find.text('Mis Números'), findsOneWidget);
    expect(find.text('Historial'), findsOneWidget);
    expect(find.text('Resultados'), findsOneWidget);
    expect(find.text('¿Qué querés jugar hoy?'), findsOneWidget);
  });
}

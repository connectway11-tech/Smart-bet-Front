import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/widgets/home_page.dart';

void main() {
  testWidgets('HomePage shows 6 game cards with "Ver" (6 real games)', (WidgetTester tester) async {
    // Avoid using MyApp which loads google_fonts; instantiate HomePage within a basic MaterialApp
  await tester.pumpWidget(MaterialApp(home: HomePage()));
    await tester.pumpAndSettle();

    // Each real game card displays the word 'Ver' in the bottom-right; the "Más Juegos" card doesn't.
    final verFinder = find.text('Ver');
    expect(verFinder, findsNWidgets(6));
  });

  testWidgets('SVG assets are present as SvgPicture widgets', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: HomePage()));
  await tester.pumpAndSettle();

    final svgFinder = find.byType(SvgPicture);
    // We expect at least one SvgPicture per real game (6)
    expect(svgFinder, findsAtLeastNWidgets(6));
  });
}

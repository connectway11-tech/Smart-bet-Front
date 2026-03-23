import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/widgets/home_page.dart';

void main() {
  testWidgets('HomePage shows 6 real game cards plus more games card', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));
    await tester.pumpAndSettle();

    expect(find.byType(GameCard), findsNWidgets(6));
    expect(find.byType(MoreGamesCard), findsOneWidget);
  });

  testWidgets('Game logos render as svg or raster assets', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));
    await tester.pumpAndSettle();

    final logoFinder = find.byWidgetPredicate(
      (widget) => widget is SvgPicture || widget is Image,
    );
    expect(logoFinder, findsAtLeastNWidgets(6));
  });
}

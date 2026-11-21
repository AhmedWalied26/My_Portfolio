import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/constants/app_strings.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('PortfolioApp renders correctly on desktop',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text(AppStrings.name), findsWidgets);
    expect(find.text('Built with Flutter Web by Ahmed Walied'), findsOneWidget);
    expect(find.text('All Projects (7)'), findsOneWidget);
    expect(find.text('smart_empty_state'), findsWidgets);
  });

  testWidgets('PortfolioApp renders correctly on mobile',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text(AppStrings.name), findsWidgets);
    expect(find.byIcon(Icons.menu_rounded), findsOneWidget);
    expect(find.text('Built with Flutter Web by Ahmed Walied'), findsOneWidget);
  });
}

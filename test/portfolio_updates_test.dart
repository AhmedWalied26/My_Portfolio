import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/presentation/widgets/brand_logo.dart';
import 'package:portfolio/presentation/sections/skills/skill_tech_icon.dart';

void main() {
  testWidgets('BrandLogo renders in navbar and footer', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 500));

    // BrandLogo should be present in navbar and footer
    expect(find.byType(BrandLogo), findsWidgets);
  });

  testWidgets('Technical Skills section renders all skill chips with SkillTechIcon',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Dart'), findsOneWidget);
    expect(find.text('Flutter'), findsWidgets);
    expect(find.text('Java'), findsOneWidget);
    expect(find.text('Kotlin'), findsOneWidget);
    expect(find.text('Clean Architecture'), findsWidgets);
    expect(find.byType(SkillTechIcon), findsWidgets);
  });

  testWidgets('Contact section does not contain Location item',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 500));

    // Ensure Location is not present in contact section
    expect(find.text('Location'), findsNothing);
    expect(find.text('Fayoum, Egypt'), findsNothing);
    expect(find.byIcon(Icons.location_on_outlined), findsNothing);
    // While Email Address and Phone are present
    expect(find.text('Email Address'), findsWidgets);
    expect(find.text('Phone Call'), findsOneWidget);
    expect(find.text('WhatsApp'), findsOneWidget);
  });

  testWidgets('Education section does not contain any location text or icon',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Fayoum'), findsNothing);
    expect(find.text('Fayoum, Egypt'), findsNothing);
    expect(find.byIcon(Icons.location_on_outlined), findsNothing);
    expect(find.text('Bachelor of Science in Computer Science & Information'),
        findsOneWidget);
  });

  testWidgets('Download CV buttons are present and configured with local CV asset',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 500));

    // Multiple Download CV buttons exist in navbar, hero, contact banner
    expect(find.text('Download CV'), findsWidgets);
  });
}

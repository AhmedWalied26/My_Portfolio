import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Renders a reliable vector icon for every listed technical skill.
/// Brand icons (Dart, Java, Kotlin, Firebase, Android, Flutter) use authentic
/// vector rendering and exact colors for a sharp, premium developer presentation.
class SkillTechIcon extends StatelessWidget {
  final String skill;
  final double size;
  final Color? defaultColor;

  const SkillTechIcon({
    super.key,
    required this.skill,
    this.size = 16,
    this.defaultColor,
  });

  @override
  Widget build(BuildContext context) {
    final lower = skill.toLowerCase();

    // 1. Dart
    if (lower == 'dart') {
      return SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: const _DartLogoPainter(),
        ),
      );
    }

    // 2. Kotlin
    if (lower == 'kotlin') {
      return SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: const _KotlinLogoPainter(),
        ),
      );
    }

    // 3. Java
    if (lower == 'java') {
      return SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: const _JavaLogoPainter(),
        ),
      );
    }

    // 4. Flutter
    if (lower.contains('flutter')) {
      return Icon(
        Icons.flutter_dash,
        size: size,
        color: const Color(0xFF00D2FF),
      );
    }

    // 5. Android
    if (lower.contains('android')) {
      return Icon(
        Icons.android_rounded,
        size: size,
        color: const Color(0xFF3DDC84),
      );
    }

    // 6. Firebase & Cloud Firestore
    if (lower.contains('firebase') || lower.contains('firestore')) {
      return ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Color(0xFFFFCA28), Color(0xFFF57C00)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(bounds),
        child: Icon(
          Icons.local_fire_department_rounded,
          size: size,
          color: Colors.white,
        ),
      );
    }

    // 7. Clean Architecture
    if (lower.contains('clean architecture')) {
      return Icon(
        Icons.layers_rounded,
        size: size,
        color: const Color(0xFF8B5CF6),
      );
    }

    // 8. Dependency Injection
    if (lower.contains('dependency injection') || lower.contains('di')) {
      return Icon(
        Icons.hub_rounded,
        size: size,
        color: const Color(0xFFA78BFA),
      );
    }

    // 9. State Management (BLoC/Cubit)
    if (lower.contains('bloc') || lower.contains('cubit') || lower.contains('state management')) {
      return Icon(
        Icons.sync_alt_rounded,
        size: size,
        color: const Color(0xFF8B5CF6),
      );
    }

    // 10. Provider
    if (lower.contains('provider')) {
      return Icon(
        Icons.stream_rounded,
        size: size,
        color: const Color(0xFF60A5FA),
      );
    }

    // 11. MVVM Pattern
    if (lower.contains('mvvm')) {
      return Icon(
        Icons.dashboard_customize_rounded,
        size: size,
        color: const Color(0xFFC084FC),
      );
    }

    // 12. REST API Integration
    if (lower.contains('api') || lower.contains('rest')) {
      return Icon(
        Icons.api_rounded,
        size: size,
        color: const Color(0xFF00D2FF),
      );
    }

    // 13. Authentication & Session Handling
    if (lower.contains('auth') || lower.contains('session')) {
      return Icon(
        Icons.lock_outline_rounded,
        size: size,
        color: const Color(0xFF34D399),
      );
    }

    // 14. Local Storage (Hive, Cache)
    if (lower.contains('storage') || lower.contains('hive') || lower.contains('cache')) {
      return Icon(
        Icons.storage_rounded,
        size: size,
        color: const Color(0xFF10B981),
      );
    }

    // 15. AI-Assisted Development
    if (lower.contains('ai-assisted')) {
      return Icon(
        Icons.psychology_rounded,
        size: size,
        color: const Color(0xFFF472B6),
      );
    }

    // 16. Prompt Engineering
    if (lower.contains('prompt')) {
      return Icon(
        Icons.terminal_rounded,
        size: size,
        color: const Color(0xFFEC4899),
      );
    }

    // 17. AI Tools for Code Generation
    if (lower.contains('code generation') || lower.contains('generation')) {
      return Icon(
        Icons.smart_toy_rounded,
        size: size,
        color: const Color(0xFFFB7185),
      );
    }

    // 18. Debugging & Code Review
    if (lower.contains('debugging') || lower.contains('review')) {
      return Icon(
        Icons.bug_report_rounded,
        size: size,
        color: const Color(0xFFF43F5E),
      );
    }

    // 19. Problem Solving
    if (lower.contains('problem solving')) {
      return Icon(
        Icons.lightbulb_outline_rounded,
        size: size,
        color: const Color(0xFFFBBF24),
      );
    }

    // 20. UI/UX Implementation
    if (lower.contains('ui/ux')) {
      return Icon(
        Icons.palette_outlined,
        size: size,
        color: const Color(0xFFF59E0B),
      );
    }

    // 21. Responsive Design
    if (lower.contains('responsive')) {
      return Icon(
        Icons.devices_rounded,
        size: size,
        color: const Color(0xFFF59E0B),
      );
    }

    // 22. Package Development & Publishing
    if (lower.contains('package')) {
      return Icon(
        Icons.widgets_rounded,
        size: size,
        color: const Color(0xFF00D2FF),
      );
    }

    // Fallback
    return Icon(
      Icons.code_rounded,
      size: size,
      color: defaultColor ?? const Color(0xFF00D2FF),
    );
  }
}

/// Authentic Dart vector logo painter
class _DartLogoPainter extends CustomPainter {
  const _DartLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final paintMain = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF00D2FF), Color(0xFF01579B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    final path = Path()
      ..moveTo(w * 0.12, h * 0.88)
      ..lineTo(w * 0.45, h * 0.88)
      ..lineTo(w * 0.88, h * 0.45)
      ..lineTo(w * 0.55, h * 0.12)
      ..lineTo(w * 0.12, h * 0.55)
      ..close();
    canvas.drawPath(path, paintMain);

    final paintAccent = Paint()..color = const Color(0xFF40C4FF);
    final pathAccent = Path()
      ..moveTo(w * 0.28, h * 0.72)
      ..lineTo(w * 0.58, h * 0.42)
      ..lineTo(w * 0.44, h * 0.28)
      ..lineTo(w * 0.14, h * 0.58)
      ..close();
    canvas.drawPath(pathAccent, paintAccent);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Authentic Kotlin geometric vector logo painter
class _KotlinLogoPainter extends CustomPainter {
  const _KotlinLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Top-left triangle with purple/violet gradient
    final p1 = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF7F52FF), Color(0xFFC711E1)],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    final path1 = Path()
      ..moveTo(0, 0)
      ..lineTo(w, 0)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(path1, p1);

    // Bottom-right triangle with orange/coral gradient
    final p2 = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFE4485D), Color(0xFFF18E33)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    final path2 = Path()
      ..moveTo(w, 0)
      ..lineTo(0, h)
      ..lineTo(w, h)
      ..close();
    canvas.drawPath(path2, p2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Authentic Java coffee cup vector painter
class _JavaLogoPainter extends CustomPainter {
  const _JavaLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Cup body in warm Java amber/orange
    final cupPaint = Paint()
      ..color = const Color(0xFFF89820)
      ..style = PaintingStyle.fill;

    final cupPath = Path()
      ..moveTo(w * 0.15, h * 0.45)
      ..lineTo(w * 0.72, h * 0.45)
      ..lineTo(w * 0.65, h * 0.82)
      ..quadraticBezierTo(w * 0.62, h * 0.90, w * 0.52, h * 0.90)
      ..lineTo(w * 0.35, h * 0.90)
      ..quadraticBezierTo(w * 0.22, h * 0.90, w * 0.20, h * 0.82)
      ..close();
    canvas.drawPath(cupPath, cupPaint);

    // Cup handle
    final handlePaint = Paint()
      ..color = const Color(0xFFF89820)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.11;
    canvas.drawArc(
      Rect.fromLTWH(w * 0.60, h * 0.50, w * 0.28, h * 0.26),
      -math.pi / 2,
      math.pi,
      false,
      handlePaint,
    );

    // Steam waves in blue/cyan
    final steamPaint = Paint()
      ..color = const Color(0xFF5382A1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.09
      ..strokeCap = StrokeCap.round;

    final steam1 = Path()
      ..moveTo(w * 0.35, h * 0.36)
      ..quadraticBezierTo(w * 0.30, h * 0.22, w * 0.38, h * 0.10);
    canvas.drawPath(steam1, steamPaint);

    final steam2 = Path()
      ..moveTo(w * 0.52, h * 0.36)
      ..quadraticBezierTo(w * 0.48, h * 0.22, w * 0.56, h * 0.10);
    canvas.drawPath(steam2, steamPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

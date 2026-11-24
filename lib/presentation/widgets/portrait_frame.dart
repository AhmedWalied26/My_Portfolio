import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// Decorative treatment around the hero portrait: a rotating conic
/// gradient arc, a softly pulsing glow and a few orbiting sparkles.
/// Falls back to a static arrangement when reduced motion is requested.
class PortraitFrame extends StatefulWidget {
  final Widget child;
  const PortraitFrame({super.key, required this.child});

  @override
  State<PortraitFrame> createState() => _PortraitFrameState();
}

class _PortraitFrameState extends State<PortraitFrame>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _reduceMotion = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (MediaQuery.disableAnimationsOf(context)) {
        setState(() => _reduceMotion = true);
      } else {
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final t = _reduceMotion ? 0.0 : _controller.value;
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _PortraitGlowPainter(progress: t),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(26),
              child: child,
            ),
          ],
        );
      },
    );
  }
}

class _PortraitGlowPainter extends CustomPainter {
  final double progress;
  _PortraitGlowPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final rx = size.width / 2;
    final ry = size.height / 2;

    // Pulsing elliptical glow behind the portrait.
    final pulse = 0.5 + 0.5 * math.sin(progress * 2 * math.pi);
    final glowRect = Rect.fromCenter(
      center: center,
      width: size.width * (0.98 + 0.04 * pulse),
      height: size.height * (0.98 + 0.04 * pulse),
    );
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.primary.withValues(alpha: 0.26 + 0.10 * pulse),
          AppColors.secondary.withValues(alpha: 0.12),
          AppColors.primary.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(glowRect);
    canvas.drawOval(glowRect, glowPaint);

    // Rotating conic arc ring hugging the portrait.
    final ringRect = Rect.fromCenter(
      center: center,
      width: size.width * 0.94,
      height: size.height * 0.94,
    );
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: progress * 2 * math.pi,
        endAngle: (progress + 1) * 2 * math.pi,
        colors: [
          AppColors.primary.withValues(alpha: 0.0),
          AppColors.primary.withValues(alpha: 0.9),
          AppColors.secondary.withValues(alpha: 0.9),
          AppColors.secondary.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.35, 0.6, 1.0],
      ).createShader(ringRect);
    canvas.drawArc(ringRect, 0, 2 * math.pi, false, ringPaint);

    // Orbiting sparkles.
    final sparklePaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.95)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    for (var i = 0; i < 4; i++) {
      final angle = progress * 2 * math.pi + i * (math.pi / 2);
      final dot = Offset(
        center.dx + rx * 0.86 * math.cos(angle),
        center.dy + ry * 0.86 * math.sin(angle),
      );
      canvas.drawCircle(dot, i.isEven ? 2.6 : 1.8, sparklePaint);
    }
  }

  @override
  bool shouldRepaint(_PortraitGlowPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AmbientBackground extends StatefulWidget {
  final Widget child;

  const AmbientBackground({super.key, required this.child});

  @override
  State<AmbientBackground> createState() => _AmbientBackgroundState();
}

class _AmbientBackgroundState extends State<AmbientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animate = !MediaQuery.disableAnimationsOf(context) && MediaQuery.sizeOf(context).width >= 900;
    return Stack(
      children: [
        Container(color: AppColors.background),
        Positioned.fill(
          child: !animate ? CustomPaint(painter: _AmbientGlowPainter(animationValue: 0)) : AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _AmbientGlowPainter(animationValue: _controller.value),
              );
            },
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _AmbientGlowPainter extends CustomPainter {
  final double animationValue;

  _AmbientGlowPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final t = animationValue * 2 * math.pi;

    final orb1Center = Offset(
      size.width * 0.8 + math.sin(t) * 50,
      size.height * 0.15 + math.cos(t) * 40,
    );
    final paint1 = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.primary.withOpacity(0.08),
          AppColors.primary.withOpacity(0.0),
        ],
        radius: 0.6,
      ).createShader(Rect.fromCircle(center: orb1Center, radius: 450));
    canvas.drawCircle(orb1Center, 450, paint1);

    final orb2Center = Offset(
      size.width * 0.15 + math.cos(t) * 40,
      size.height * 0.45 + math.sin(t) * 60,
    );
    final paint2 = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.secondary.withOpacity(0.06),
          AppColors.accentPurple.withOpacity(0.0),
        ],
        radius: 0.6,
      ).createShader(Rect.fromCircle(center: orb2Center, radius: 400));
    canvas.drawCircle(orb2Center, 400, paint2);

    final orb3Center = Offset(
      size.width * 0.75 + math.sin(t + 1) * 35,
      size.height * 0.85 + math.cos(t + 1) * 35,
    );
    final paint3 = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.primary.withOpacity(0.05),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: orb3Center, radius: 350));
    canvas.drawCircle(orb3Center, 350, paint3);
  }

  @override
  bool shouldRepaint(covariant _AmbientGlowPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}

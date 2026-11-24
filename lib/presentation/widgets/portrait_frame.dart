import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// Decorative treatment around the hero portrait in the classic
/// portfolio style: a clean rounded photo lifted by a soft shadow,
/// backed by an offset gradient panel and a faint ambient glow.
/// Fully static, so it is identical under reduced motion.
class PortraitFrame extends StatelessWidget {
  final Widget child;
  final double borderRadius;

  const PortraitFrame({
    super.key,
    required this.child,
    this.borderRadius = 24,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final offset = (constraints.maxWidth * 0.045).clamp(5.0, 15.0);
        return Stack(
          alignment: Alignment.center,
          children: [
            // Faint ambient glow behind the whole composition.
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.95,
                    colors: [
                      AppColors.primary.withValues(alpha: 0.14),
                      AppColors.secondary.withValues(alpha: 0.05),
                      AppColors.primary.withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.55, 1.0],
                  ),
                ),
              ),
            ),
            // Offset gradient panel peeking out bottom-right.
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(left: offset, top: offset),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withValues(alpha: 0.9),
                        AppColors.secondary.withValues(alpha: 0.9),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // The photo itself, lifted above the panel.
            Padding(
              padding: EdgeInsets.only(right: offset, bottom: offset),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.10),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 26,
                      offset: Offset(0, 14),
                    ),
                  ],
                ),
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }
}

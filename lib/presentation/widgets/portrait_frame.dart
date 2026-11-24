import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';

/// Hero portrait treatment: a clean rounded photo with a thin gradient
/// edge and soft shadow, carrying small about-me info cards like the
/// site's earlier design - a status chip on the photo and a glass fact
/// card overlapping its bottom edge. Fully static, so it is identical
/// under reduced motion.
class PortraitFrame extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final bool compact;

  const PortraitFrame({
    super.key,
    required this.child,
    this.borderRadius = 24,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardHeight = compact ? 40.0 : 52.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Faint ambient glow behind the photo.
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
            // Photo with a thin gradient edge and a soft shadow.
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: AppColors.primaryGradient,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 26,
                    offset: Offset(0, 14),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(2),
              child: child,
            ),
            // Status chip on the photo, top-right.
            Positioned(
              top: compact ? 7 : 12,
              right: compact ? 7 : 12,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: compact ? 7 : 10,
                  vertical: compact ? 3 : 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.90),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.35),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: compact ? 5 : 6,
                      height: compact ? 5 : 6,
                      decoration: const BoxDecoration(
                        color: AppColors.accentGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: compact ? 4 : 6),
                    Text(
                      'MOBILE ENG',
                      style: GoogleFonts.firaCode(
                        fontSize: compact ? 7.5 : 9,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // About-me fact card overlapping the photo's bottom edge.
            Positioned(
              bottom: -cardHeight / 2,
              child: _InfoCard(compact: compact),
            ),
          ],
        ),
        // Reserve layout room for the half of the card that overlaps
        // below the photo.
        SizedBox(height: cardHeight / 2 + (compact ? 6 : 10)),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final bool compact;

  const _InfoCard({required this.compact});

  @override
  Widget build(BuildContext context) {
    const accent = AppColors.accentGreen;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 9 : 14,
        vertical: compact ? 5 : 9,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(compact ? 4 : 7),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.phone_iphone_rounded,
              size: compact ? 11 : 16,
              color: accent,
            ),
          ),
          SizedBox(width: compact ? 6 : 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Building mobile apps',
                style: GoogleFonts.inter(
                  fontSize: compact ? 8.5 : 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'Flutter · Dart · Kotlin',
                style: GoogleFonts.inter(
                  fontSize: compact ? 7 : 10,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

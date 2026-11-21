import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// A sleek, minimal developer branding icon used consistently
/// across the top navbar, mobile drawer, and footer.
class BrandLogo extends StatelessWidget {
  final double size;
  final IconData icon;

  const BrandLogo({
    super.key,
    this.size = 36,
    this.icon = Icons.terminal_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = (size * 0.55).clamp(14.0, 24.0);
    final borderRadius = BorderRadius.circular(size * 0.28);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withOpacity(0.85),
        borderRadius: borderRadius,
        border: Border.all(
          color: AppColors.primary.withOpacity(0.35),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.18),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF00D2FF), Color(0xFF3B82F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Icon(
            icon,
            size: iconSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

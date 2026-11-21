import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

enum ModernButtonVariant {
  primaryGradient,
  outlined,
  ghost,
}

class ModernButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onTap;
  final ModernButtonVariant variant;
  final double? width;
  final double height;
  final bool isGlowing;

  const ModernButton({
    super.key,
    required this.text,
    this.icon,
    required this.onTap,
    this.variant = ModernButtonVariant.primaryGradient,
    this.width,
    this.height = 48,
    this.isGlowing = false,
  });

  @override
  State<ModernButton> createState() => _ModernButtonState();
}

class _ModernButtonState extends State<ModernButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          width: widget.width,
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: 22),
          decoration: _buildDecoration(),
          transform: _isHovered
              ? (Matrix4.identity()..translate(0, -3, 0))
              : Matrix4.identity(),
          child: Row(
            mainAxisSize:
                widget.width == null ? MainAxisSize.min : MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 18,
                  color: _getTextColor(),
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _getTextColor(),
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTextColor() {
    switch (widget.variant) {
      case ModernButtonVariant.primaryGradient:
        return const Color(0xFF0A0E17);
      case ModernButtonVariant.outlined:
        return _isHovered ? AppColors.primary : AppColors.textPrimary;
      case ModernButtonVariant.ghost:
        return _isHovered ? AppColors.primary : AppColors.textSecondary;
    }
  }

  BoxDecoration _buildDecoration() {
    switch (widget.variant) {
      case ModernButtonVariant.primaryGradient:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: _isHovered
                ? [const Color(0xFF38BDF8), const Color(0xFF00D2FF)]
                : [const Color(0xFF00D2FF), const Color(0xFF3B82F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(
                _isHovered ? 0.45 : (widget.isGlowing ? 0.3 : 0.15),
              ),
              blurRadius: _isHovered ? 20 : 12,
              offset: Offset(0, _isHovered ? 6 : 4),
            ),
          ],
        );
      case ModernButtonVariant.outlined:
        return BoxDecoration(
          color: _isHovered
              ? AppColors.primary.withOpacity(0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered ? AppColors.primary : AppColors.borderLight,
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.18),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        );
      case ModernButtonVariant.ghost:
        return BoxDecoration(
          color: _isHovered
              ? AppColors.surfaceVariant.withOpacity(0.5)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        );
    }
  }
}

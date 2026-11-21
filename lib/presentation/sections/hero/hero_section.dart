import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/download_helper.dart';
import '../../../core/utils/url_launcher_helper.dart';
import '../../controllers/navigation_controller.dart';
import '../../widgets/animated_reveal.dart';
import '../../widgets/modern_button.dart';
import '../../widgets/responsive_layout.dart';
import '../../widgets/typing_name_text.dart';

class HeroSection extends StatefulWidget {
  final NavigationController navController;

  const HeroSection({super.key, required this.navController});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final size = MediaQuery.sizeOf(context);

    return Container(
      constraints: BoxConstraints(
        minHeight: isDesktop ? size.height - 72 : 0,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _floatController,
              builder: (context, _) {
                return CustomPaint(
                  painter: _HeroBackgroundPainter(
                    progress: _floatController.value,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 64 : 24,
              vertical: isDesktop ? 70 : 45,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: isDesktop
                    ? _buildDesktopLayout(context)
                    : _buildMobileLayout(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: _buildHeroContent(context, isDesktop: true),
        ),
        const SizedBox(width: 48),
        Expanded(
          flex: 5,
          child: Center(
            child: _buildProfileVisual(size: 380),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        _buildProfileVisual(size: 220, isMobile: true),
        const SizedBox(height: 36),
        _buildHeroContent(context, isDesktop: false),
      ],
    );
  }

  Widget _buildHeroContent(BuildContext context, {required bool isDesktop}) {
    final align =
        isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center;
    final textAlign = isDesktop ? TextAlign.start : TextAlign.center;

    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedReveal(
          slideOffset: 15,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.accentGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'OPEN TO OPPORTUNITIES',
                  style: GoogleFonts.firaCode(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        AnimatedReveal(
          delay: const Duration(milliseconds: 100),
          child: Text(
            AppStrings.heroGreeting,
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 22 : 18,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedReveal(
          delay: const Duration(milliseconds: 180),
          child: TypingNameText(
            text: AppStrings.name,
            textAlign: textAlign,
            style: GoogleFonts.outfit(
              fontSize: isDesktop ? 52 : 36,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -1,
              height: 1.15,
            ),
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFE0F2FE),
                Color(0xFF00D2FF),
              ],
              stops: [0.0, 0.6, 1.0],
            ).createShader(bounds),
          ),
        ),
        const SizedBox(height: 12),
        AnimatedReveal(
          delay: const Duration(milliseconds: 260),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 24,
                height: 2,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  AppStrings.title,
                  textAlign: textAlign,
                  style: GoogleFonts.outfit(
                    fontSize: isDesktop ? 24 : 19,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        AnimatedReveal(
          delay: const Duration(milliseconds: 340),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580),
            child: Text(
              AppStrings.heroIntro,
              textAlign: textAlign,
              style: GoogleFonts.inter(
                fontSize: isDesktop ? 16 : 14,
                color: AppColors.textSecondary,
                height: 1.68,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        AnimatedReveal(
          delay: const Duration(milliseconds: 420),
          child: Wrap(
            spacing: 14,
            runSpacing: 14,
            alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
            children: [
              ModernButton(
                text: AppStrings.ctaDownloadCv,
                icon: Icons.download_rounded,
                variant: ModernButtonVariant.primaryGradient,
                isGlowing: true,
                onTap: () => downloadCv(),
              ),
              ModernButton(
                text: AppStrings.ctaViewProjects,
                icon: Icons.layers_outlined,
                variant: ModernButtonVariant.outlined,
                onTap: () => widget.navController
                    .scrollToSection(PortfolioSection.projects),
              ),
              ModernButton(
                text: AppStrings.ctaContactMe,
                icon: Icons.mail_outline_rounded,
                variant: ModernButtonVariant.ghost,
                onTap: () => widget.navController
                    .scrollToSection(PortfolioSection.contact),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        AnimatedReveal(
          delay: const Duration(milliseconds: 500),
          child: Wrap(
            spacing: 12,
            runSpacing: 10,
            alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
            children: [
              _SocialIconButton(
                icon: Icons.business_center_rounded,
                label: 'LinkedIn',
                tooltip: 'Connect on LinkedIn (ahmed-w-hassan)',
                onTap: () => UrlHelper.launchURL(AppStrings.linkedinUrl),
              ),
              _SocialIconButton(
                icon: Icons.widgets_rounded,
                label: 'pub.dev Package',
                tooltip: 'smart_empty_state on pub.dev',
                onTap: () => UrlHelper.launchURL(AppStrings.pubDevPackageUrl),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileVisual({required double size, bool isMobile = false}) {
    // 3:4 aspect ratio matching the 896x1195 profile photo (0.75 ratio)
    final frameWidth = isMobile ? 240.0 : 315.0;
    final frameHeight = isMobile ? 320.0 : 420.0;

    final outerRadius = BorderRadius.circular(isMobile ? 20 : 24);
    final innerRadius = BorderRadius.circular(isMobile ? 18 : 22);

    return AnimatedReveal(
      delay: const Duration(milliseconds: 250),
      child: AnimatedBuilder(
        animation: _floatController,
        builder: (context, _) {
          final t = _floatController.value * math.pi * 2;
          final floatOffset = math.sin(t) * 5;
          final counterOffset = math.cos(t) * 3;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: frameWidth + (isMobile ? 24 : 70),
                height: frameHeight + (isMobile ? 16 : 40),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Layer 1: Ambient soft aura glow
                    Positioned(
                      top: 10 + floatOffset * 0.4,
                      child: Container(
                        width: frameWidth * 0.94,
                        height: frameHeight * 0.94,
                        decoration: BoxDecoration(
                          borderRadius: outerRadius,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.24),
                              blurRadius: 65,
                              spreadRadius: 4,
                            ),
                            BoxShadow(
                              color: AppColors.accentPurple.withOpacity(0.18),
                              blurRadius: 75,
                              offset: const Offset(10, 18),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Layer 2: Rotating orbital tech accent ring
                    Positioned(
                      top: 8 + counterOffset * 0.4,
                      child: SizedBox(
                        width: frameWidth + (isMobile ? 20 : 44),
                        height: frameHeight + (isMobile ? 14 : 32),
                        child: CustomPaint(
                          painter: _OrbitalRingPainter(
                            progress: _floatController.value,
                          ),
                        ),
                      ),
                    ),

                    // Layer 3: Glass backdrop card layer for depth
                    Positioned(
                      top: 14 - counterOffset * 0.3,
                      left: isMobile ? 18 : 40,
                      child: Container(
                        width: frameWidth,
                        height: frameHeight,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant.withOpacity(0.4),
                          borderRadius: outerRadius,
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.18),
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),

                    // Layer 4: Primary frame with full, uncropped profile image (BoxFit.contain)
                    Positioned(
                      top: 6 + floatOffset,
                      left: isMobile ? 10 : 28,
                      child: Container(
                        width: frameWidth,
                        height: frameHeight,
                        decoration: BoxDecoration(
                          borderRadius: outerRadius,
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF00D2FF),
                              Color(0xFF3B82F6),
                              Color(0xFF8B5CF6),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 28,
                              offset: const Offset(0, 14),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: innerRadius,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Full profile image without any cropping or zooming
                              Image.asset(
                                AppAssets.profileImage,
                                fit: BoxFit.contain,
                                filterQuality: FilterQuality.high,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.surfaceVariant,
                                    child: const Icon(
                                      Icons.person_rounded,
                                      size: 90,
                                      color: AppColors.primary,
                                    ),
                                  );
                                },
                              ),
                              // Top status badge in the foliage area
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface.withOpacity(0.88),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: AppColors.primary.withOpacity(0.35),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          color: AppColors.accentGreen,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'MOBILE ENG',
                                        style: GoogleFonts.firaCode(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primary,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Layer 5: Desktop Floating Badges with gentle independent oscillation
                    if (!isMobile) ...[
                      Positioned(
                        bottom: 12 + floatOffset * 1.1,
                        right: -10,
                        child: const _FloatingBadge(
                          icon: Icons.flutter_dash,
                          title: 'Flutter & Native Android',
                          subtitle: 'Clean Architecture & MVVM',
                          accentColor: AppColors.primary,
                        ),
                      ),
                      Positioned(
                        top: 24 - floatOffset * 1.0,
                        left: -8,
                        child: const _FloatingBadge(
                          icon: Icons.verified_rounded,
                          title: 'Open Source Author',
                          subtitle: 'smart_empty_state on pub.dev',
                          accentColor: AppColors.accentGreen,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Mobile complementary floating badges
              if (isMobile) ...[
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: const [
                    _FloatingBadge(
                      icon: Icons.flutter_dash,
                      title: 'Flutter & Native Android',
                      subtitle: 'Clean Architecture',
                      accentColor: AppColors.primary,
                    ),
                    _FloatingBadge(
                      icon: Icons.verified_rounded,
                      title: 'Open Source Author',
                      subtitle: 'smart_empty_state',
                      accentColor: AppColors.accentGreen,
                    ),
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

/// Subtle orbital accent painter around the profile image composition
class _OrbitalRingPainter extends CustomPainter {
  final double progress;

  const _OrbitalRingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.max(size.width, size.height) * 0.52;

    final ringPaint = Paint()
      ..color = AppColors.primary.withOpacity(0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    canvas.drawCircle(center, radius, ringPaint);

    final arcPaint = Paint()
      ..shader = SweepGradient(
        colors: [
          AppColors.primary.withOpacity(0.0),
          AppColors.primary.withOpacity(0.4),
          AppColors.accentPurple.withOpacity(0.5),
          AppColors.primary.withOpacity(0.0),
        ],
        transform: GradientRotation(progress * math.pi * 2),
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      progress * math.pi * 2,
      math.pi * 0.75,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _OrbitalRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _HeroBackgroundPainter extends CustomPainter {
  final double progress;

  _HeroBackgroundPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress * math.pi;

    final orb1Center = Offset(
      size.width * 0.25 + math.sin(t) * 30,
      size.height * 0.35 + math.cos(t) * 25,
    );
    final paint1 = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.primary.withOpacity(0.09),
          Colors.transparent,
        ],
        radius: 0.6,
      ).createShader(Rect.fromCircle(center: orb1Center, radius: 300));
    canvas.drawCircle(orb1Center, 300, paint1);

    final orb2Center = Offset(
      size.width * 0.80 + math.cos(t) * 35,
      size.height * 0.45 + math.sin(t) * 30,
    );
    final paint2 = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.secondary.withOpacity(0.08),
          Colors.transparent,
        ],
        radius: 0.6,
      ).createShader(Rect.fromCircle(center: orb2Center, radius: 320));
    canvas.drawCircle(orb2Center, 320, paint2);

    final dotPaint = Paint()..color = AppColors.primary.withOpacity(0.25);
    final crossPaint = Paint()
      ..color = AppColors.secondary.withOpacity(0.20)
      ..strokeWidth = 1.5;

    final dots = [
      Offset(size.width * 0.08, size.height * 0.22 + math.sin(t) * 10),
      Offset(size.width * 0.48, size.height * 0.15 + math.cos(t) * 8),
      Offset(size.width * 0.92, size.height * 0.28 + math.sin(t) * 12),
      Offset(size.width * 0.12, size.height * 0.78 + math.cos(t) * 10),
      Offset(size.width * 0.58, size.height * 0.82 + math.sin(t) * 8),
    ];

    for (final dot in dots) {
      canvas.drawCircle(dot, 2.5, dotPaint);
    }

    final crosses = [
      Offset(size.width * 0.42, size.height * 0.68 + math.sin(t) * 12),
      Offset(size.width * 0.88, size.height * 0.72 + math.cos(t) * 10),
    ];

    for (final cross in crosses) {
      canvas.drawLine(
        Offset(cross.dx - 4, cross.dy),
        Offset(cross.dx + 4, cross.dy),
        crossPaint,
      );
      canvas.drawLine(
        Offset(cross.dx, cross.dy - 4),
        Offset(cross.dx, cross.dy + 4),
        crossPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HeroBackgroundPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _SocialIconButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String tooltip;
  final VoidCallback onTap;

  const _SocialIconButton({
    required this.icon,
    required this.label,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppColors.primary.withOpacity(0.12)
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _isHovered ? AppColors.primary : AppColors.border,
                width: 1,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      )
                    ]
                  : null,
            ),
            transform: _isHovered
                ? (Matrix4.identity()..translate(0, -2, 0))
                : Matrix4.identity(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icon,
                  size: 16,
                  color:
                      _isHovered ? AppColors.primary : AppColors.textSecondary,
                ),
                const SizedBox(width: 7),
                Text(
                  widget.label,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color:
                        _isHovered ? AppColors.textPrimary : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingBadge extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accentColor;

  const _FloatingBadge({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.94),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: accentColor.withOpacity(0.35),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: accentColor),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 10,
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

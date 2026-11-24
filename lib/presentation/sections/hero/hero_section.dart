import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/download_helper.dart';
import '../../controllers/navigation_controller.dart';
import '../../widgets/animated_reveal.dart';
import '../../widgets/modern_button.dart';
import '../../widgets/portrait_frame.dart';
import '../../widgets/typing_name_text.dart';

class HeroSection extends StatelessWidget {
  final NavigationController navController;
  const HeroSection({super.key, required this.navController});
  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: AppColors.accentGreen,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 9),
            Text(
              'OPEN TO OPPORTUNITIES',
              style: GoogleFonts.inter(
                color: AppColors.textSecondary,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          "Hello, I'm",
          style: GoogleFonts.inter(
            color: AppColors.textSecondary,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 9),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: 'Ahmed Walied\n'),
              TextSpan(
                text: 'Hassan.',
                style: TextStyle(color: AppColors.primary),
              ),
            ],
          ),
          style: GoogleFonts.outfit(
            fontSize: wide ? 64 : 42,
            fontWeight: FontWeight.w700,
            height: 1.05,
            letterSpacing: -1.7,
          ),
        ),
        const SizedBox(height: 20),
        TypingNameText(
          text: AppStrings.title,
          suffix: 'Developer',
          suffixColor: AppColors.primary,
          style: GoogleFonts.outfit(
            fontSize: wide ? 26 : 22,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            'I build mobile apps with Flutter and native Android. From client projects to open-source packages, I focus on clean code and thoughtful interfaces.',
            style: GoogleFonts.inter(
              fontSize: wide ? 15 : 13,
              height: 1.8,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: 26),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ModernButton(
              text: AppStrings.ctaViewProjects,
              icon: Icons.arrow_outward_rounded,
              variant: ModernButtonVariant.primaryGradient,
              onTap: () =>
                  navController.scrollToSection(PortfolioSection.projects),
            ),
            ModernButton(
              text: AppStrings.ctaDownloadCv,
              icon: Icons.download_rounded,
              variant: ModernButtonVariant.outlined,
              onTap: downloadCv,
            ),
          ],
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 18,
          runSpacing: 10,
          children: [
            _proof('Client project delivered'),
            _proof('Published on pub.dev'),
          ],
        ),
      ],
    );
    final portrait = PortraitFrame(
      borderRadius: wide ? 24 : 16,
      compact: !wide,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(wide ? 24 : 16),
        child: Image.asset(
          'images/2-portrait.webp',
          width: wide ? 315 : 112,
          height: wide ? 390 : 145,
          fit: BoxFit.cover,
          semanticLabel: 'Ahmed Walied Hassan',
        ),
      ),
    );
    final visual = wide
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [portrait, const SizedBox(height: 17), _caption()],
          )
        : Row(
            children: [
              portrait,
              const SizedBox(width: 20),
              Expanded(child: _caption()),
            ],
          );
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: wide ? 64 : 24,
        vertical: wide ? 88 : 32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: wide
              ? Row(
                  children: [
                    Expanded(flex: 6, child: AnimatedReveal(child: copy)),
                    const SizedBox(width: 60),
                    Expanded(
                      flex: 4,
                      child: AnimatedReveal(
                        delay: const Duration(milliseconds: 120),
                        child: visual,
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedReveal(child: copy),
                    const SizedBox(height: 30),
                    AnimatedReveal(
                      delay: const Duration(milliseconds: 120),
                      child: visual,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _proof(String text) => Text(
    '✓  $text',
    style: GoogleFonts.inter(color: AppColors.textSecondary, fontSize: 10),
  );
  Widget _caption() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Flutter + Native Android',
        style: GoogleFonts.outfit(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
      ),
      const SizedBox(height: 6),
      Text(
        'Dart, Kotlin & Java\nFourth-year CS student',
        style: GoogleFonts.inter(
          fontSize: 11,
          height: 1.7,
          color: AppColors.textSecondary,
        ),
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/url_launcher_helper.dart';
import '../../controllers/navigation_controller.dart';
import '../../widgets/brand_logo.dart';
import '../../widgets/responsive_layout.dart';

class FooterSection extends StatelessWidget {
  final NavigationController navController;

  const FooterSection({super.key, required this.navController});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
        vertical: 36,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () =>
                              navController.scrollToSection(PortfolioSection.home),
                          borderRadius: BorderRadius.circular(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const BrandLogo(size: 32),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  AppStrings.name,
                                  style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Mobile App Developer • Flutter & Native Android',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: () =>
                        navController.scrollToSection(PortfolioSection.home),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.surfaceVariant,
                      side: const BorderSide(color: AppColors.border),
                    ),
                    icon: const Icon(
                      Icons.arrow_upward_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    tooltip: 'Back to top',
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(color: AppColors.border),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                runSpacing: 10,
                children: [
                  Text(
                    'Built with Flutter Web by Ahmed Walied',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      _FooterLink(
                        label: AppStrings.email,
                        onTap: () => UrlHelper.launchEmail(AppStrings.email),
                      ),
                      _FooterLink(
                        label: 'GitHub',
                        onTap: () => UrlHelper.launchURL(AppStrings.githubUrl),
                      ),
                      _FooterLink(
                        label: 'LinkedIn',
                        onTap: () =>
                            UrlHelper.launchURL(AppStrings.linkedinUrl),
                      ),
                      _FooterLink(
                        label: 'pub.dev',
                        onTap: () =>
                            UrlHelper.launchURL(AppStrings.pubDevPackageUrl),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _FooterLink({required this.label, required this.onTap});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _isHovered ? AppColors.primary : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

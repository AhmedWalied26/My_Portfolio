import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/download_helper.dart';
import '../../controllers/navigation_controller.dart';
import '../../widgets/brand_logo.dart';
import '../../widgets/modern_button.dart';
import '../../widgets/responsive_layout.dart';

class TopNavbar extends StatelessWidget {
  final NavigationController navController;
  final VoidCallback onOpenDrawer;

  const TopNavbar({
    super.key,
    required this.navController,
    required this.onOpenDrawer,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isScrolled = navController.isScrolled;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 72,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 32 : 16,
          ),
          decoration: BoxDecoration(
            color: isScrolled
                ? AppColors.surface.withOpacity(0.85)
                : AppColors.background.withOpacity(0.65),
            border: Border(
              bottom: BorderSide(
                color: isScrolled ? AppColors.border : Colors.transparent,
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () =>
                    navController.scrollToSection(PortfolioSection.home),
                borderRadius: BorderRadius.circular(10),
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const BrandLogo(size: 36),
                      const SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Ahmed',
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            TextSpan(
                              text: '.dev',
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isDesktop) ...[
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _NavLink(
                          title: AppStrings.navHome,
                          isSelected: navController.currentSection ==
                              PortfolioSection.home,
                          onTap: () => navController
                              .scrollToSection(PortfolioSection.home),
                        ),
                        _NavLink(
                          title: AppStrings.navAbout,
                          isSelected: navController.currentSection ==
                              PortfolioSection.about,
                          onTap: () => navController
                              .scrollToSection(PortfolioSection.about),
                        ),
                        _NavLink(
                          title: AppStrings.navSkills,
                          isSelected: navController.currentSection ==
                              PortfolioSection.skills,
                          onTap: () => navController
                              .scrollToSection(PortfolioSection.skills),
                        ),
                        _NavLink(
                          title: AppStrings.navProjects,
                          isSelected: navController.currentSection ==
                              PortfolioSection.projects,
                          onTap: () => navController
                              .scrollToSection(PortfolioSection.projects),
                        ),
                        _NavLink(
                          title: AppStrings.navExperience,
                          isSelected: navController.currentSection ==
                              PortfolioSection.experience,
                          onTap: () => navController
                              .scrollToSection(PortfolioSection.experience),
                        ),
                        _NavLink(
                          title: AppStrings.navEducation,
                          isSelected: navController.currentSection ==
                              PortfolioSection.education,
                          onTap: () => navController
                              .scrollToSection(PortfolioSection.education),
                        ),
                        _NavLink(
                          title: AppStrings.navContact,
                          isSelected: navController.currentSection ==
                              PortfolioSection.contact,
                          onTap: () => navController
                              .scrollToSection(PortfolioSection.contact),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                ModernButton(
                  text: 'Download CV',
                  icon: Icons.download_rounded,
                  height: 42,
                  variant: ModernButtonVariant.primaryGradient,
                  onTap: () => downloadCv(),
                ),
              ] else ...[
                IconButton(
                  onPressed: onOpenDrawer,
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: AppColors.textPrimary,
                    size: 28,
                  ),
                  tooltip: 'Open navigation',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavLink({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isSelected || _isHovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: active
                ? AppColors.primary.withOpacity(0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                  color: active ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: active ? 22 : 0,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: active
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.55),
                            blurRadius: 6,
                            offset: const Offset(0, 1),
                          )
                        ]
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

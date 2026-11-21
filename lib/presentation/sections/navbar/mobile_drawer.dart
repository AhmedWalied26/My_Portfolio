import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/download_helper.dart';
import '../../controllers/navigation_controller.dart';
import '../../widgets/brand_logo.dart';
import '../../widgets/modern_button.dart';

class MobileDrawer extends StatelessWidget {
  final NavigationController navController;

  const MobileDrawer({
    super.key,
    required this.navController,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      navController.scrollToSection(PortfolioSection.home);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Row(
                      children: [
                        const BrandLogo(size: 34),
                        const SizedBox(width: 10),
                        Text(
                          'Ahmed Walied',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(color: AppColors.border),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _DrawerItem(
                      icon: Icons.home_rounded,
                      title: AppStrings.navHome,
                      isSelected: navController.currentSection ==
                          PortfolioSection.home,
                      onTap: () {
                        Navigator.of(context).pop();
                        navController.scrollToSection(PortfolioSection.home);
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.person_rounded,
                      title: AppStrings.navAbout,
                      isSelected: navController.currentSection ==
                          PortfolioSection.about,
                      onTap: () {
                        Navigator.of(context).pop();
                        navController.scrollToSection(PortfolioSection.about);
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.code_rounded,
                      title: AppStrings.navSkills,
                      isSelected: navController.currentSection ==
                          PortfolioSection.skills,
                      onTap: () {
                        Navigator.of(context).pop();
                        navController.scrollToSection(PortfolioSection.skills);
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.layers_rounded,
                      title: AppStrings.navProjects,
                      isSelected: navController.currentSection ==
                          PortfolioSection.projects,
                      onTap: () {
                        Navigator.of(context).pop();
                        navController
                            .scrollToSection(PortfolioSection.projects);
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.work_outline_rounded,
                      title: AppStrings.navExperience,
                      isSelected: navController.currentSection ==
                          PortfolioSection.experience,
                      onTap: () {
                        Navigator.of(context).pop();
                        navController
                            .scrollToSection(PortfolioSection.experience);
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.school_rounded,
                      title: AppStrings.navEducation,
                      isSelected: navController.currentSection ==
                          PortfolioSection.education,
                      onTap: () {
                        Navigator.of(context).pop();
                        navController
                            .scrollToSection(PortfolioSection.education);
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.mail_outline_rounded,
                      title: AppStrings.navContact,
                      isSelected: navController.currentSection ==
                          PortfolioSection.contact,
                      onTap: () {
                        Navigator.of(context).pop();
                        navController.scrollToSection(PortfolioSection.contact);
                      },
                    ),
                  ],
                ),
              ),
              ModernButton(
                text: 'Download CV',
                icon: Icons.download_rounded,
                width: double.infinity,
                variant: ModernButtonVariant.primaryGradient,
                onTap: () {
                  Navigator.of(context).pop();
                  downloadCv();
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary.withOpacity(0.12)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
          size: 20,
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
        onTap: onTap,
        dense: true,
      ),
    );
  }
}

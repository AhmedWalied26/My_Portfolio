import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/models/portfolio_models.dart';
import '../../../data/portfolio_data.dart';
import '../../widgets/animated_reveal.dart';
import '../../widgets/responsive_layout.dart';
import '../../widgets/section_title.dart';
import 'project_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  int _selectedFilterIndex = 0;

  final List<String> _filters = [
    'All Projects (7)',
    'Featured & Client (2)',
    'Mobile Applications (5)',
  ];

  List<ProjectModel> _getFilteredProjects() {
    switch (_selectedFilterIndex) {
      case 1:
        return PortfolioData.projects.where((p) => p.isFeatured).toList();
      case 2:
        return PortfolioData.projects.where((p) => !p.isFeatured).toList();
      default:
        return PortfolioData.projects;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final filtered = _getFilteredProjects();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 20,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionTitle(
                tag: 'Portfolio',
                title: AppStrings.projectsTitle,
                subtitle: AppStrings.projectsSubtitle,
              ),
              _buildFilterChips(),
              const SizedBox(height: 36),
              LayoutBuilder(
                builder: (context, constraints) {
                  final useTwoColumns = constraints.maxWidth >= 960;

                  if (!useTwoColumns) {
                    return Column(
                      children: List.generate(filtered.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: AnimatedReveal(
                            delay: Duration(milliseconds: 70 * (index % 5)),
                            child: ProjectCard(project: filtered[index]),
                          ),
                        );
                      }),
                    );
                  }

                  final leftCol = <ProjectModel>[];
                  final rightCol = <ProjectModel>[];

                  for (int i = 0; i < filtered.length; i++) {
                    if (i % 2 == 0) {
                      leftCol.add(filtered[i]);
                    } else {
                      rightCol.add(filtered[i]);
                    }
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: List.generate(leftCol.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: AnimatedReveal(
                                delay: Duration(milliseconds: 70 * index),
                                child: ProjectCard(project: leftCol[index]),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          children: List.generate(rightCol.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: AnimatedReveal(
                                delay: Duration(milliseconds: 70 * index + 35),
                                child: ProjectCard(project: rightCol[index]),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_filters.length, (index) {
          final isSelected = _selectedFilterIndex == index;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: InkWell(
              onTap: () {
                setState(() => _selectedFilterIndex = index);
              },
              borderRadius: BorderRadius.circular(24),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.surfaceVariant.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.border,
                    width: 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  _filters[index],
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? const Color(0xFF0A0E17)
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

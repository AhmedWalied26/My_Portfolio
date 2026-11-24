import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/models/portfolio_models.dart';
import '../../../data/portfolio_data.dart';
import '../../widgets/animated_reveal.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/responsive_layout.dart';
import '../../widgets/section_title.dart';
import 'skill_tech_icon.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
        vertical: 70,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionTitle(
                tag: 'Expertise',
                title: AppStrings.skillsTitle,
                subtitle: AppStrings.skillsSubtitle,
              ),
              _buildResponsiveLayout(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveLayout(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final categories = PortfolioData.skillCategories;

        final columns = constraints.maxWidth >= 1000
            ? 3
            : constraints.maxWidth >= 640
            ? 2
            : 1;
        final width = (constraints.maxWidth - (columns - 1) * 20) / columns;
        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: List.generate(
            categories.length,
            (index) => SizedBox(
              width: width,
              child: AnimatedReveal(
                delay: Duration(milliseconds: 40 * (index % 3)),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: columns == 1 ? 0 : 235,
                  ),
                  child: _CompactCategoryCard(category: categories[index]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildColumn(List<SkillCategory> list, {required int startIndex}) {
    return Column(
      children: list.asMap().entries.map((entry) {
        final index = startIndex + entry.key;
        final category = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: AnimatedReveal(
            delay: Duration(milliseconds: 70 * index),
            child: _CompactCategoryCard(category: category),
          ),
        );
      }).toList(),
    );
  }
}

class _CompactCategoryCard extends StatelessWidget {
  final SkillCategory category;

  const _CompactCategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      hoverBorderColor: category.color.withOpacity(0.55),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: category.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: category.color.withOpacity(0.35),
                    width: 1,
                  ),
                ),
                child: Icon(category.icon, size: 17, color: category.color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  category.name,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: category.color.withOpacity(0.25),
                    width: 1,
                  ),
                ),
                child: Text(
                  '${category.skills.length}',
                  style: GoogleFonts.firaCode(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: category.color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: category.skills
                .map(
                  (skill) => _CompactSkillChip(
                    label: skill,
                    accentColor: category.color,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _CompactSkillChip extends StatefulWidget {
  final String label;
  final Color accentColor;

  const _CompactSkillChip({required this.label, required this.accentColor});

  @override
  State<_CompactSkillChip> createState() => _CompactSkillChipState();
}

class _CompactSkillChipState extends State<_CompactSkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.accentColor.withOpacity(0.18)
              : AppColors.surfaceVariant.withOpacity(0.55),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isHovered
                ? widget.accentColor.withOpacity(0.7)
                : AppColors.border,
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.accentColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        transform: _isHovered
            ? (Matrix4.identity()..translate(0, -1.5, 0))
            : Matrix4.identity(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SkillTechIcon(
              skill: widget.label,
              size: 15,
              defaultColor: widget.accentColor,
            ),
            const SizedBox(width: 7),
            Text(
              widget.label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                color: _isHovered
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

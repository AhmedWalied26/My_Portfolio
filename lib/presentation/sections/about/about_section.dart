import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/animated_reveal.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/responsive_layout.dart';
import '../../widgets/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionTitle(
                tag: 'Overview',
                title: AppStrings.aboutTitle,
                subtitle: AppStrings.aboutSubtitle,
              ),
              _buildMetricsGrid(context),
              const SizedBox(height: 48),
              _buildSummaryPoints(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricsGrid(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    final metrics = [
      _MetricData(
        value: '4th Year',
        label: 'CS & Info Student',
        sub: 'EELU (GPA 3.38/4.0)',
        icon: Icons.school_rounded,
        color: AppColors.primary,
      ),
      _MetricData(
        value: 'Freelance',
        label: 'Client Project Delivered',
        sub: 'Mazra3ty Flutter App',
        icon: Icons.work_rounded,
        color: AppColors.secondary,
      ),
      _MetricData(
        value: 'Open Source',
        label: 'Published on pub.dev',
        sub: 'smart_empty_state package',
        icon: Icons.card_giftcard_rounded,
        color: AppColors.accentGreen,
      ),
      _MetricData(
        value: 'Certified',
        label: 'Route Academy & ITI',
        sub: 'Flutter & Software Engineering',
        icon: Icons.workspace_premium_rounded,
        color: AppColors.accentPurple,
      ),
    ];

    if (isDesktop) {
      return Row(
        children: metrics.asMap().entries.map((entry) {
          final index = entry.key;
          final m = entry.value;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? 0 : 8,
                right: index == metrics.length - 1 ? 0 : 8,
              ),
              child: AnimatedReveal(
                delay: Duration(milliseconds: 100 * index),
                child: _buildMetricCard(m),
              ),
            ),
          );
        }).toList(),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossCount = constraints.maxWidth > 550 ? 2 : 1;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            mainAxisExtent: 140,
          ),
          itemCount: metrics.length,
          itemBuilder: (context, index) {
            return AnimatedReveal(
              delay: Duration(milliseconds: 80 * index),
              child: _buildMetricCard(metrics[index]),
            );
          },
        );
      },
    );
  }

  Widget _buildMetricCard(_MetricData m) {
    return GlassCard(
      hoverBorderColor: m.color.withOpacity(0.55),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.white, m.color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  m.value,
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: m.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: m.color.withOpacity(0.3),
                  ),
                ),
                child: Icon(m.icon, size: 20, color: m.color),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            m.label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            m.sub,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryPoints(BuildContext context) {
    final points = AppStrings.summaryPoints;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;
        final half = (points.length / 2).ceil();
        final col1 = points.sublist(0, half);
        final col2 = points.sublist(half);

        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: col1
                      .asMap()
                      .entries
                      .map((e) => _buildPointItem(e.value, e.key))
                      .toList(),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  children: col2
                      .asMap()
                      .entries
                      .map((e) => _buildPointItem(e.value, half + e.key))
                      .toList(),
                ),
              ),
            ],
          );
        }

        return Column(
          children: points
              .asMap()
              .entries
              .map((e) => _buildPointItem(e.value, e.key))
              .toList(),
        );
      },
    );
  }

  Widget _buildPointItem(String text, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AnimatedReveal(
        delay: Duration(milliseconds: 60 * index),
        child: GlassCard(
          hoverBorderColor: AppColors.primary.withOpacity(0.4),
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.3),
                  ),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 14,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricData {
  final String value;
  final String label;
  final String sub;
  final IconData icon;
  final Color color;

  const _MetricData({
    required this.value,
    required this.label,
    required this.sub,
    required this.icon,
    required this.color,
  });
}

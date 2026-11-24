import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/url_launcher_helper.dart';
import '../../../data/models/portfolio_models.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  const ProjectCard({super.key, required this.project});
  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool hover = false;
  static const media = {
    'Mazra3ty': '3-mazra3ty',
    'smart_empty_state': '4-package',
    'E-Commerce App': '5-ecommerce',
    'Movie App': '6-movies',
    'Evently': '7-evently',
    'News App': '8-news',
    'Islami App': '9-islami',
  };
  void openImage() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.surface,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: InteractiveViewer(
                child: Image.asset(
                  'images/${media[widget.project.title]}.webp',
                  fit: BoxFit.contain,
                  semanticLabel: '${widget.project.title} app screen',
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                tooltip: 'Close image',
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final reduced = MediaQuery.disableAnimationsOf(context);
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: reduced ? 0 : 180),
        transform: Matrix4.translationValues(0, hover && !reduced ? -4 : 0, 0),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: hover
                ? p.accentColor.withValues(alpha: .6)
                : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              button: true,
              label: 'Enlarge ${p.title} screenshot',
              child: InkWell(
                onTap: openImage,
                child: Container(
                  height: 280,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        p.accentColor.withValues(alpha: .2),
                        AppColors.surfaceVariant,
                      ],
                      radius: 1.2,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 22, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 25,
                                  offset: Offset(0, 12),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              'images/${media[p.title]}.webp',
                              fit: BoxFit.contain,
                              semanticLabel:
                                  '${p.title}: actual app screenshot',
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.background.withValues(alpha: .9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            p.isFeatured ? p.subtitle : '${p.title} · Flutter',
                            style: GoogleFonts.inter(
                              fontSize: 9,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        right: 14,
                        bottom: 14,
                        child: Icon(
                          Icons.open_in_full_rounded,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.subtitle.toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: p.accentColor,
                      letterSpacing: .8,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    p.title,
                    style: GoogleFonts.outfit(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    p.description,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      height: 1.8,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 7,
                    runSpacing: 8,
                    children: p.technologies
                        .take(3)
                        .map(
                          (t) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              t,
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 14),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: Material(
                      color: Colors.transparent,
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        childrenPadding: const EdgeInsets.only(bottom: 12),
                        iconColor: AppColors.textSecondary,
                        collapsedIconColor: AppColors.textSecondary,
                        title: Text(
                          'Engineering details',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        children: p.highlights
                            .map(
                              (t) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  '• $t',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    height: 1.7,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  if (p.externalUrl != null)
                    TextButton.icon(
                      onPressed: () => UrlHelper.launchURL(p.externalUrl!),
                      icon: const Icon(Icons.arrow_outward, size: 16),
                      label: Text(p.urlLabel ?? 'View project'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

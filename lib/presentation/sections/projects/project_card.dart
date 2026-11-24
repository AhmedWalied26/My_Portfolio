import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/url_launcher_helper.dart';
import '../../../data/models/portfolio_models.dart';
import '../../widgets/phone_mockup.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  const ProjectCard({super.key, required this.project});
  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool hover = false;
  static const screens = {
    'Mazra3ty': ['1-mazra3ty-1', '2-mazra3ty-2', '3-mazra3ty-3', '4-mazra3ty-4'],
    'smart_empty_state': ['1-23-package-1', '2-24-package-2', '3-25-package-3'],
    'E-Commerce App': ['8-ecommerce-1', '9-ecommerce-2'],
    'Movie App': ['10-movies-1', '11-movies-2', '12-movies-3', '13-movies-4'],
    'Evently': ['14-evently-1', '15-evently-2', '16-evently-3'],
    'News App': ['17-news-1', '18-news-2'],
    'Islami App': ['19-islami-1', '20-islami-2', '21-islami-3', '22-islami-4'],
  };

  List<String> get _assets =>
      (screens[widget.project.title] ?? const <String>[])
          .map((name) => 'images/$name.webp')
          .toList();
  void openGallery() {
    final assets = _assets;
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.surface,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 56, 24, 32),
                child: SizedBox(
                  height: 520,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: assets.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 28),
                    itemBuilder: (context, index) => Center(
                      child: PhoneMockup(
                        assetPath: assets[index],
                        height: 470,
                        semanticLabel:
                            '${widget.project.title} app screen ${index + 1} of ${assets.length}',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 24,
                child: Text(
                  '${widget.project.title} · ${assets.length} screens',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  tooltip: 'Close gallery',
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            ],
          ),
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
              label: 'Open ${p.title} screen gallery',
              child: InkWell(
                onTap: openGallery,
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
                      Positioned.fill(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final assets = _assets;
                            final shown = assets.take(3).toList();
                            final spread =
                                (constraints.maxWidth * 0.24)
                                    .clamp(70.0, 130.0);
                            // Draw side phones first so the center phone
                            // of an odd fan sits on top.
                            final order = [
                              for (var i = 0; i < shown.length; i++) i,
                            ]..sort(
                                (a, b) =>
                                    (b - (shown.length - 1) / 2)
                                        .abs()
                                        .compareTo(
                                          (a - (shown.length - 1) / 2).abs(),
                                        ),
                              );
                            return Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                              for (final i in order)
                                Transform.translate(
                                  offset: Offset(
                                    (i - (shown.length - 1) / 2) * spread,
                                    i == (shown.length - 1) ~/ 2 &&
                                            shown.length.isOdd
                                        ? -4
                                        : 14,
                                  ),
                                  child: Transform.rotate(
                                    angle: shown.length == 1
                                        ? 0
                                        : (i - (shown.length - 1) / 2) * 0.13,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 18),
                                      child: PhoneMockup(
                                        assetPath: shown[i],
                                        height: shown.length == 1 ? 236 : 210,
                                        semanticLabel:
                                            '${p.title}: actual app screenshot ${i + 1}',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
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

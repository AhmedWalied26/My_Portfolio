import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../controllers/navigation_controller.dart';
import '../sections/about/about_section.dart';
import '../sections/contact/contact_section.dart';
import '../sections/education/education_section.dart';
import '../sections/experience/experience_section.dart';
import '../sections/footer/footer_section.dart';
import '../sections/hero/hero_section.dart';
import '../sections/navbar/mobile_drawer.dart';
import '../sections/navbar/top_navbar.dart';
import '../sections/projects/projects_section.dart';
import '../sections/skills/skills_section.dart';
import '../widgets/particle_background.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  late final NavigationController _navController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _navController = NavigationController();
  }

  @override
  void dispose() {
    _navController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      endDrawer: MobileDrawer(navController: _navController),
      body: AmbientBackground(
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _navController.scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 72),
                    Container(
                      key: _navController.sectionKeys[PortfolioSection.home],
                      child: HeroSection(navController: _navController),
                    ),
                    Container(
                      key: _navController.sectionKeys[PortfolioSection.about],
                      child: const AboutSection(),
                    ),
                    Container(
                      key: _navController.sectionKeys[PortfolioSection.skills],
                      child: const SkillsSection(),
                    ),
                    Container(
                      key: _navController.sectionKeys[PortfolioSection.projects],
                      child: const ProjectsSection(),
                    ),
                    Container(
                      key:
                          _navController.sectionKeys[PortfolioSection.experience],
                      child: const ExperienceSection(),
                    ),
                    Container(
                      key:
                          _navController.sectionKeys[PortfolioSection.education],
                      child: const EducationSection(),
                    ),
                    Container(
                      key: _navController.sectionKeys[PortfolioSection.contact],
                      child: const ContactSection(),
                    ),
                    FooterSection(navController: _navController),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _navController,
                builder: (context, _) {
                  return TopNavbar(
                    navController: _navController,
                    onOpenDrawer: () =>
                        _scaffoldKey.currentState?.openEndDrawer(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

enum PortfolioSection {
  home,
  about,
  skills,
  projects,
  experience,
  education,
  contact,
}

class NavigationController extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  final Map<PortfolioSection, GlobalKey> sectionKeys = {
    PortfolioSection.home: GlobalKey(),
    PortfolioSection.about: GlobalKey(),
    PortfolioSection.skills: GlobalKey(),
    PortfolioSection.projects: GlobalKey(),
    PortfolioSection.experience: GlobalKey(),
    PortfolioSection.education: GlobalKey(),
    PortfolioSection.contact: GlobalKey(),
  };

  PortfolioSection _currentSection = PortfolioSection.home;
  PortfolioSection get currentSection => _currentSection;

  bool _isScrolled = false;
  bool get isScrolled => _isScrolled;

  bool _isProgrammaticScroll = false;

  NavigationController() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    final scrolled = scrollController.offset > 40;
    bool didChange = false;

    if (scrolled != _isScrolled) {
      _isScrolled = scrolled;
      didChange = true;
    }

    if (!_isProgrammaticScroll) {
      final detected = _detectCurrentSection();
      if (detected != null && detected != _currentSection) {
        _currentSection = detected;
        didChange = true;
      }
    }

    if (didChange) {
      notifyListeners();
    }
  }

  PortfolioSection? _detectCurrentSection() {
    if (!scrollController.hasClients) return null;

    final scrollOffset = scrollController.offset;
    if (scrollOffset <= 60) {
      return PortfolioSection.home;
    }

    final maxScroll = scrollController.position.maxScrollExtent;
    if (scrollOffset >= maxScroll - 60) {
      return PortfolioSection.contact;
    }

    final viewportHeight = scrollController.position.viewportDimension;
    final detectionPoint = scrollOffset + viewportHeight * 0.35;

    PortfolioSection? bestSection;
    double bestDistance = double.infinity;

    for (final entry in sectionKeys.entries) {
      final key = entry.value;
      if (key.currentContext == null) continue;

      final renderBox = key.currentContext!.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.hasSize) continue;

      final position = renderBox.localToGlobal(Offset.zero);
      final sectionTop = scrollOffset + position.dy;
      final sectionBottom = sectionTop + renderBox.size.height;

      if (detectionPoint >= sectionTop && detectionPoint < sectionBottom) {
        return entry.key;
      }

      final sectionCenter = (sectionTop + sectionBottom) / 2;
      final distance = (detectionPoint - sectionCenter).abs();
      if (distance < bestDistance) {
        bestDistance = distance;
        bestSection = entry.key;
      }
    }

    return bestSection ?? _currentSection;
  }

  void scrollToSection(PortfolioSection section) {
    _currentSection = section;
    _isProgrammaticScroll = true;
    notifyListeners();

    if (!scrollController.hasClients) {
      _isProgrammaticScroll = false;
      return;
    }

    if (section == PortfolioSection.home) {
      scrollController
          .animateTo(
            0.0,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOutCubic,
          )
          .then((_) {
            _isProgrammaticScroll = false;
          });
      return;
    }

    final key = sectionKeys[section];
    final context = key?.currentContext;
    if (context != null) {
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox != null && renderBox.hasSize) {
        final position = renderBox.localToGlobal(Offset.zero);
        final targetOffset = (scrollController.offset + position.dy - 72.0)
            .clamp(0.0, scrollController.position.maxScrollExtent);

        scrollController
            .animateTo(
              targetOffset,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOutCubic,
            )
            .then((_) {
              _isProgrammaticScroll = false;
              final detected = _detectCurrentSection();
              if (detected != null && detected != _currentSection) {
                _currentSection = detected;
                notifyListeners();
              }
            });
        return;
      }
    }

    _isProgrammaticScroll = false;
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }
}

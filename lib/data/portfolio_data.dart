import 'package:flutter/material.dart';
import 'models/portfolio_models.dart';

class PortfolioData {
  static const List<SkillCategory> skillCategories = [
    SkillCategory(
      name: 'Programming Languages',
      icon: Icons.code_rounded,
      color: Color(0xFF00D2FF),
      skills: ['Dart', 'Java', 'Kotlin'],
    ),
    SkillCategory(
      name: 'Frameworks & Platforms',
      icon: Icons.phone_android_rounded,
      color: Color(0xFF3B82F6),
      skills: ['Flutter', 'Android Native'],
    ),
    SkillCategory(
      name: 'Architecture & Patterns',
      icon: Icons.account_tree_rounded,
      color: Color(0xFF8B5CF6),
      skills: [
        'Clean Architecture',
        'Dependency Injection (DI)',
        'State Management (BLoC/Cubit)',
        'Provider',
        'MVVM Pattern',
      ],
    ),
    SkillCategory(
      name: 'Data & Backend',
      icon: Icons.storage_rounded,
      color: Color(0xFF10B981),
      skills: [
        'Firebase & Cloud Firestore',
        'REST API Integration',
        'Authentication & Session Handling',
        'Local Storage (Hive, Cache)',
      ],
    ),
    SkillCategory(
      name: 'AI & Productivity',
      icon: Icons.psychology_rounded,
      color: Color(0xFFEC4899),
      skills: [
        'AI-Assisted Development',
        'Prompt Engineering',
        'AI Tools for Code Generation',
        'Debugging & Code Review',
      ],
    ),
    SkillCategory(
      name: 'Other Competencies',
      icon: Icons.auto_awesome_rounded,
      color: Color(0xFFF59E0B),
      skills: [
        'Problem Solving',
        'UI/UX Implementation',
        'Responsive Design',
        'Package Development & Publishing',
      ],
    ),
  ];

  static const List<ProjectModel> projects = [
    ProjectModel(
      title: 'Mazra3ty',
      subtitle: 'Freelance Client Project',
      description:
          'A production Flutter mobile application delivered as a freelance project for a client, architected for high maintainability, offline capability, and clean separation of concerns.',
      highlights: [
        'Structured the codebase with Clean Architecture, separating data, domain, and presentation layers for scalability.',
        'Applied Dependency Injection to decouple components, facilitating testing and extensibility.',
        'Managed application state with BLoC/Cubit and persisted vital user and business data on the device using local storage.',
      ],
      technologies: [
        'Flutter',
        'Clean Architecture',
        'BLoC / Cubit',
        'Dependency Injection',
        'Local Storage',
      ],
      icon: Icons.agriculture_rounded,
      accentColor: Color(0xFF10B981),
      isFeatured: true,
    ),
    ProjectModel(
      title: 'smart_empty_state',
      subtitle: 'Published Flutter Package on pub.dev',
      description:
          'An open-source, customizable, and responsive empty-state widget package published to pub.dev for Flutter developers worldwide.',
      highlights: [
        'Designed and published a customizable, responsive empty-state widget package for Flutter apps.',
        'Provided built-in states (no data, search not found, no internet, error, permission denied) with customizable icons, titles, messages, actions, and themes.',
        'Maintained the package with thorough documentation, an interactive example app, and an MIT license for community use.',
      ],
      technologies: [
        'Flutter Package',
        'pub.dev',
        'Open Source',
        'Custom Widgets',
        'Responsive UI',
      ],
      externalUrl: 'https://pub.dev/packages/smart_empty_state',
      urlLabel: 'View on pub.dev',
      icon: Icons.widgets_rounded,
      accentColor: Color(0xFF00D2FF),
      isFeatured: true,
    ),
    ProjectModel(
      title: 'E-Commerce App',
      subtitle: 'Personal Flutter Project',
      description:
          'A full-featured e-commerce mobile application consuming REST APIs for real-time authentication, dynamic product catalog, and comprehensive cart operations.',
      highlights: [
        'Implemented secure user authentication (sign up, login, session handling) integrated directly with the backend API.',
        'Developed product listing, rich product detail views, and interactive cart management flows with real-time updates and quantity handling.',
        'Applied structured state management to keep cart, product data, and authentication state consistent across screen sizes.',
      ],
      technologies: [
        'Flutter',
        'REST APIs',
        'User Auth',
        'Cart Management',
        'State Management',
        'Responsive UI',
      ],
      icon: Icons.shopping_bag_rounded,
      accentColor: Color(0xFF3B82F6),
      isFeatured: false,
    ),
    ProjectModel(
      title: 'Movie App',
      subtitle: 'Personal Flutter Project',
      description:
          'A modern entertainment app consuming REST APIs to stream movie data, discover trending titles, and cache media data locally.',
      highlights: [
        'Structured the app with the MVVM pattern to decouple UI, business logic, and data layers for cleaner, more maintainable code.',
        'Managed app state with Cubit/BLoC and stored data locally on the device using Hive.',
        'Integrated Firebase Authentication to handle secure user sign up and login.',
      ],
      technologies: [
        'Flutter',
        'MVVM Pattern',
        'REST API',
        'Cubit / BLoC',
        'Hive Local Storage',
        'Firebase Auth',
      ],
      icon: Icons.movie_filter_rounded,
      accentColor: Color(0xFF8B5CF6),
      isFeatured: false,
    ),
    ProjectModel(
      title: 'Evently',
      subtitle: 'Personal Flutter Project',
      description:
          'An event planning and management mobile application built with Firebase and Cloud Firestore for real-time data storage and cross-device synchronization.',
      highlights: [
        'Integrated Firebase and Cloud Firestore for real-time data storage and continuous synchronization.',
        'Implemented state management to handle dynamic event schedules, updates, and user interactions smoothly.',
        'Designed an intuitive, responsive interface optimized for quick event discovery and management.',
      ],
      technologies: [
        'Flutter',
        'Firebase',
        'Cloud Firestore',
        'Real-time Sync',
        'State Management',
      ],
      icon: Icons.event_available_rounded,
      accentColor: Color(0xFFEC4899),
      isFeatured: false,
    ),
    ProjectModel(
      title: 'News App',
      subtitle: 'Personal Flutter Project',
      description:
          'A responsive news aggregation mobile application delivering up-to-the-minute global news articles via REST APIs.',
      highlights: [
        'Consumed REST APIs for asynchronous fetching and presentation of curated news categories.',
        'Implemented state management using BLoC/Cubit to keep architecture scalable and predictable.',
        'Designed a responsive UI to keep article feeds readable and cleanly laid out across various mobile screen sizes.',
      ],
      technologies: [
        'Flutter',
        'REST API',
        'BLoC / Cubit',
        'News Aggregation',
        'Responsive UI',
      ],
      icon: Icons.newspaper_rounded,
      accentColor: Color(0xFF06B6D4),
      isFeatured: false,
    ),
    ProjectModel(
      title: 'Islami App',
      subtitle: 'Personal Flutter Project',
      description:
          'An Islamic content mobile application reading structured local content files alongside remote REST API services.',
      highlights: [
        'Developed an Islamic content app that reads data from an external file alongside consuming a REST API.',
        'Implemented state management using Provider to manage application state efficiently.',
        'Built with a responsive layout to ensure smooth usability across different device sizes.',
      ],
      technologies: [
        'Flutter',
        'Provider',
        'REST API',
        'Local File I/O',
        'Responsive Layout',
      ],
      icon: Icons.menu_book_rounded,
      accentColor: Color(0xFF10B981),
      isFeatured: false,
    ),
  ];

  static const List<ExperienceModel> experiences = [
    ExperienceModel(
      title: 'Freelance Flutter Developer',
      organization: 'Mazra3ty Project',
      roleType: 'Freelance Client Project',
      descriptionPoints: [
        'Developed and delivered a production Flutter application as a freelance project for a client.',
        'Structured the codebase with Clean Architecture, separating data, domain, and presentation layers for scalability and maintainability.',
        'Applied Dependency Injection to decouple components and make the code easier to test and extend.',
        'Managed app state with BLoC/Cubit and persisted data on the device using local storage.',
      ],
      icon: Icons.work_outline_rounded,
    ),
    ExperienceModel(
      title: 'Open-Source Flutter Package Author',
      organization: 'pub.dev (smart_empty_state)',
      roleType: 'Package Author & Maintainer',
      link: 'https://pub.dev/packages/smart_empty_state',
      descriptionPoints: [
        'Designed and published a customizable, responsive empty-state widget package for Flutter apps on pub.dev.',
        'Provided built-in states (no data, search not found, no internet, error, permission denied) with customizable icons, titles, messages, actions, and themes.',
        'Maintained the package with documentation, an example app, and an MIT license for community use.',
      ],
      icon: Icons.card_giftcard_rounded,
    ),
  ];

  static const List<EducationModel> educationList = [
    EducationModel(
      institution: 'The Egyptian E-Learning University (EELU)',
      degree: 'Bachelor of Science in Computer Science & Information',
      timePeriod: 'Fourth Year — Expected May 2027',
      gpa: 'Cumulative GPA: 3.38 / 4.00',
      icon: Icons.school_rounded,
    ),
  ];

  static const List<ExperienceModel> trainings = [
    ExperienceModel(
      title: "Route Academy's Training Program",
      organization: 'Route Academy',
      period: 'Completed',
      roleType: 'Technical Training',
      descriptionPoints: [
        'Completed a hands-on technical training program to further develop software development skills.',
        'Gained hands-on experience building clean, efficient, and maintainable applications with Flutter.',
      ],
      icon: Icons.verified_rounded,
    ),
    ExperienceModel(
      title: '1-Month Training Certificate',
      organization: 'Information Technology Institute (ITI)',
      period: '1-Month Certificate',
      roleType: 'Professional Training',
      descriptionPoints: [
        'Intensive hands-on technical training focusing on modern software development fundamentals and practical industry practices.',
      ],
      icon: Icons.workspace_premium_rounded,
    ),
  ];
}

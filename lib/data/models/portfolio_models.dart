import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  final String subtitle;
  final String description;
  final List<String> highlights;
  final List<String> technologies;
  final String? externalUrl;
  final String? urlLabel;
  final IconData icon;
  final Color accentColor;
  final bool isFeatured;

  const ProjectModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.highlights,
    required this.technologies,
    this.externalUrl,
    this.urlLabel,
    required this.icon,
    this.accentColor = const Color(0xFF00D2FF),
    this.isFeatured = false,
  });
}

class SkillCategory {
  final String name;
  final IconData icon;
  final List<String> skills;
  final Color color;

  const SkillCategory({
    required this.name,
    required this.icon,
    required this.skills,
    required this.color,
  });
}

class ExperienceModel {
  final String title;
  final String organization;
  final String? period;
  final String roleType;
  final List<String> descriptionPoints;
  final IconData icon;
  final String? link;

  const ExperienceModel({
    required this.title,
    required this.organization,
    this.period,
    required this.roleType,
    required this.descriptionPoints,
    required this.icon,
    this.link,
  });
}

class EducationModel {
  final String institution;
  final String degree;
  final String timePeriod;
  final String? gpa;
  final IconData icon;

  const EducationModel({
    required this.institution,
    required this.degree,
    required this.timePeriod,
    this.gpa,
    required this.icon,
  });
}

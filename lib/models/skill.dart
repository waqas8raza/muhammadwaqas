import 'package:flutter/material.dart';

class Skill {
  final String name;
  final double level; // 0.0 to 1.0 representation
  final IconData icon;

  const Skill({
    required this.name,
    required this.level,
    required this.icon,
  });
}

class SkillCategory {
  final String title;
  final List<Skill> skills;

  const SkillCategory({
    required this.title,
    required this.skills,
  });
}

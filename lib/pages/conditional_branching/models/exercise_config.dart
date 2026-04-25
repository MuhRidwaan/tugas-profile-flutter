import 'package:flutter/material.dart';

/// Configuration model for a conditional branching exercise
class ExerciseConfig {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final Widget page;

  const ExerciseConfig({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.page,
  });
}

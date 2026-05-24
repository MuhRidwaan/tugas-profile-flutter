import 'package:flutter/material.dart';

/// Configuration model for a number series exercise
class ExerciseConfig {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String loopType; // 'for', 'while', 'do-while'
  final Widget page;

  const ExerciseConfig({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.loopType,
    required this.page,
  });
}

import 'package:flutter/material.dart';

/// Represents a single recycling step in the EcoSteps guide.
class RecyclingStep {
  /// The step sequence number (1-based, e.g., 1 to 6).
  final int stepNumber;

  /// Concise step title (e.g., "Collect Waste").
  final String title;

  /// Short summary for preview cards and recaps.
  final String shortDescription;

  /// Detailed, environmentally sound instructions for the user.
  final String detailedInstruction;

  /// Actionable, practical tip for everyday recycling success.
  final String practicalTip;

  /// Primary icon representing the step.
  final IconData icon;

  /// Unique Hero animation tag for screen transitions.
  final String heroTag;

  /// Category tag (e.g., "Collection", "Preparation", "Sorting").
  final String category;

  /// Characteristic color accent for visual differentiation.
  final Color accentColor;

  /// Examples of accepted/recommended materials for this step.
  final List<String> keyItems;

  /// Examples of common contaminants to avoid.
  final List<String> doNotInclude;

  const RecyclingStep({
    required this.stepNumber,
    required this.title,
    required this.shortDescription,
    required this.detailedInstruction,
    required this.practicalTip,
    required this.icon,
    required this.heroTag,
    required this.category,
    required this.accentColor,
    required this.keyItems,
    required this.doNotInclude,
  });
}

import 'package:flutter/material.dart';

/// A reusable [Hero] widget tailored for recycling step icons and illustrations.
///
/// Features unique Hero tags, customizable sizing, rounded container styling,
/// and a smooth [flightShuttleBuilder] to prevent popping during screen transitions.
class HeroRecyclingIcon extends StatelessWidget {
  /// The unique Hero tag identifying this element across routes.
  final String heroTag;

  /// The icon representing the recycling concept.
  final IconData icon;

  /// Diameter of the circular / rounded badge.
  final double size;

  /// Size of the icon inside the container.
  final double iconSize;

  /// Background color of the icon container.
  final Color backgroundColor;

  /// Foreground icon tint.
  final Color iconColor;

  /// Optional custom elevation / shadow.
  final bool showShadow;

  const HeroRecyclingIcon({
    super.key,
    required this.heroTag,
    required this.icon,
    this.size = 64.0,
    this.iconSize = 32.0,
    required this.backgroundColor,
    required this.iconColor,
    this.showShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      flightShuttleBuilder:
          (
            flightContext,
            animation,
            flightDirection,
            fromHeroContext,
            toHeroContext,
          ) {
            // Smoothly interpolate during route transitions
            return AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Material(
                  color: Colors.transparent,
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      shape: BoxShape.circle,
                      boxShadow: showShadow
                          ? [
                              BoxShadow(
                                color: iconColor.withValues(alpha: 0.25),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(icon, size: iconSize, color: iconColor),
                  ),
                );
              },
            );
          },
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            boxShadow: showShadow
                ? [
                    BoxShadow(
                      color: iconColor.withValues(alpha: 0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Icon(icon, size: iconSize, color: iconColor),
        ),
      ),
    );
  }
}

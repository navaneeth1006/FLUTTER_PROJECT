import 'package:flutter/material.dart';
import '../animations/hero_recycling_icon.dart';
import '../models/recycling_step.dart';
import '../theme/app_theme.dart';

/// A card widget that displays a concise preview of a [RecyclingStep] on the home screen.
///
/// Features a unique [HeroRecyclingIcon], category badge, title, short description,
/// and smooth interactive feedback.
class RecyclingStepCard extends StatelessWidget {
  final RecyclingStep step;
  final VoidCallback onTap;
  final bool isCompleted;

  const RecyclingStepCard({
    super.key,
    required this.step,
    required this.onTap,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final badgeBg = isDark
        ? step.accentColor.withValues(alpha: 0.18)
        : step.accentColor.withValues(alpha: 0.12);

    final cardBg = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    return Semantics(
      button: true,
      label: 'Step ${step.stepNumber}: ${step.title}. ${step.shortDescription}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: step.accentColor.withValues(alpha: 0.1),
          highlightColor: step.accentColor.withValues(alpha: 0.05),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isCompleted ? AppTheme.primaryGreen : borderColor,
                width: isCompleted ? 1.6 : 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Icon
                HeroRecyclingIcon(
                  heroTag: step.heroTag,
                  icon: step.icon,
                  size: 56,
                  iconSize: 28,
                  backgroundColor: badgeBg,
                  iconColor: step.accentColor,
                  showShadow: false,
                ),
                const SizedBox(width: 16),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: Step number badge & Category
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: badgeBg,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'STEP ${step.stepNumber}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: step.accentColor,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            step.category,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? AppTheme.textSecondaryDark
                                  : AppTheme.textSecondaryLight,
                            ),
                          ),
                          const Spacer(),
                          if (isCompleted)
                            const Icon(
                              Icons.check_circle_rounded,
                              size: 18,
                              color: AppTheme.primaryGreen,
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Title
                      Text(
                        step.title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppTheme.textPrimaryDark
                              : AppTheme.textPrimaryLight,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Short description
                      Text(
                        step.shortDescription,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: isDark
                              ? AppTheme.textSecondaryDark
                              : AppTheme.textSecondaryLight,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Trailing chevron
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: isDark
                        ? AppTheme.textSecondaryDark
                        : AppTheme.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

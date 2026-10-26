import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// An animated progress indicator displaying the user's progress through the 6 recycling steps.
class RecyclingProgressIndicator extends StatelessWidget {
  /// The current active step number (1-indexed: 1 to [totalSteps]).
  final int currentStep;

  /// Total number of steps (defaults to 6).
  final int totalSteps;

  /// Whether to display individual step indicator dots below the bar.
  final bool showDots;

  /// Optional callback when a step dot is tapped.
  final ValueChanged<int>? onStepTapped;

  const RecyclingProgressIndicator({
    super.key,
    required this.currentStep,
    this.totalSteps = 6,
    this.showDots = true,
    this.onStepTapped,
  });

  @override
  Widget build(BuildContext context) {
    final clampedStep = currentStep.clamp(1, totalSteps);
    final progressFraction = clampedStep / totalSteps;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final barBg = isDark ? const Color(0xFF1E2D28) : const Color(0xFFE2E8F0);
    final activeColor = isDark
        ? AppTheme.primaryGreenLight
        : AppTheme.primaryGreenDark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Top label & percentage
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Step $clampedStep of $totalSteps',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppTheme.textSecondaryDark
                    : AppTheme.textSecondaryLight,
              ),
            ),
            Text(
              '${(progressFraction * 100).toInt()}% Complete',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: activeColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Animated progress track
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 8,
            width: double.infinity,
            color: barBg,
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              tween: Tween<double>(begin: 0, end: progressFraction),
              builder: (context, value, child) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: value,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.primaryGreen, activeColor],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Optional step dots
        if (showDots) ...[
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(totalSteps, (index) {
              final stepNum = index + 1;
              final isCompleted = stepNum < clampedStep;
              final isCurrent = stepNum == clampedStep;

              Color dotBg;
              Color iconColor;

              if (isCurrent) {
                dotBg = activeColor;
                iconColor = isDark ? AppTheme.deepForest : Colors.white;
              } else if (isCompleted) {
                dotBg = isDark
                    ? AppTheme.primaryGreen.withValues(alpha: 0.3)
                    : AppTheme.mintAccent;
                iconColor = isDark
                    ? AppTheme.primaryGreenLight
                    : AppTheme.deepForest;
              } else {
                dotBg = barBg;
                iconColor = isDark
                    ? AppTheme.textSecondaryDark
                    : AppTheme.textSecondaryLight;
              }

              return InkWell(
                onTap: onStepTapped != null
                    ? () => onStepTapped!(stepNum)
                    : null,
                borderRadius: BorderRadius.circular(16),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isCurrent ? 32 : 28,
                  height: isCurrent ? 32 : 28,
                  decoration: BoxDecoration(
                    color: dotBg,
                    shape: BoxShape.circle,
                    border: isCurrent
                        ? Border.all(
                            color: isDark ? Colors.white : AppTheme.deepForest,
                            width: 2,
                          )
                        : null,
                  ),
                  child: Center(
                    child: isCompleted
                        ? Icon(Icons.check, size: 16, color: iconColor)
                        : Text(
                            '$stepNum',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isCurrent
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: iconColor,
                            ),
                          ),
                  ),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../animations/fade_animation.dart';
import '../animations/hero_recycling_icon.dart';
import '../animations/slide_animation.dart';
import '../models/recycling_step.dart';
import '../theme/app_theme.dart';

/// Renders the complete, animated body of a single [RecyclingStep].
///
/// Features large Hero icon, Fade and Slide transitions for text and tips,
/// structured material guidelines, and contamination warnings.
class AnimatedStepContent extends StatelessWidget {
  final RecyclingStep step;

  const AnimatedStepContent({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final badgeBg = isDark
        ? step.accentColor.withValues(alpha: 0.18)
        : step.accentColor.withValues(alpha: 0.12);

    final tipCardBg = isDark ? const Color(0xFF261D0B) : AppTheme.tipAmberLight;

    final tipBorderColor = isDark
        ? const Color(0xFF78350F)
        : AppTheme.tipAmber.withValues(alpha: 0.4);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Center Hero illustration / icon with glowing ambient circle
          Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    step.accentColor.withValues(alpha: isDark ? 0.25 : 0.18),
                    step.accentColor.withValues(alpha: 0.0),
                  ],
                ),
              ),
              child: HeroRecyclingIcon(
                heroTag: step.heroTag,
                icon: step.icon,
                size: 96,
                iconSize: 48,
                backgroundColor: badgeBg,
                iconColor: step.accentColor,
                showShadow: true,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Category & Step Tag (Fade)
          FadeAnimation(
            duration: const Duration(milliseconds: 500),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: step.accentColor.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'STEP ${step.stepNumber} • ${step.category.toUpperCase()}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: step.accentColor,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Title (Fade & Slide)
          SlideAnimation(
            direction: SlideDirection.fromBottom,
            delay: const Duration(milliseconds: 100),
            child: Text(
              step.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: isDark
                    ? AppTheme.textPrimaryDark
                    : AppTheme.textPrimaryLight,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Detailed Instructions Card (Slide)
          SlideAnimation(
            direction: SlideDirection.fromBottom,
            delay: const Duration(milliseconds: 150),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.description_outlined,
                        size: 20,
                        color: step.accentColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Instructions',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppTheme.textPrimaryDark
                              : AppTheme.textPrimaryLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    step.detailedInstruction,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                      color: isDark
                          ? AppTheme.textSecondaryDark
                          : AppTheme.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Practical Tip Card (Slide with amber accent)
          SlideAnimation(
            direction: SlideDirection.fromBottom,
            delay: const Duration(milliseconds: 200),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: tipCardBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: tipBorderColor, width: 1.2),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.tipAmber.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lightbulb_rounded,
                      size: 22,
                      color: AppTheme.tipAmberDark,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Practical Eco Tip',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppTheme.tipAmber
                                : AppTheme.tipAmberDark,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          step.practicalTip,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? const Color(0xFFFEF3C7)
                                : const Color(0xFF78350F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Accepted Key Items Chips
          SlideAnimation(
            direction: SlideDirection.fromBottom,
            delay: const Duration(milliseconds: 250),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                  width: 1.2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline_rounded,
                        size: 20,
                        color: AppTheme.primaryGreen,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'What to Include',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppTheme.textPrimaryDark
                              : AppTheme.textPrimaryLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: step.keyItems.map((item) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppTheme.primaryGreen.withValues(alpha: 0.12)
                              : AppTheme.softMint,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDark
                                ? AppTheme.primaryGreen.withValues(alpha: 0.25)
                                : AppTheme.mintAccent,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppTheme.primaryGreenLight
                                : AppTheme.deepForest,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Contaminants to Avoid
          SlideAnimation(
            direction: SlideDirection.fromBottom,
            delay: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF281414)
                    : const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF7F1D1D)
                      : const Color(0xFFFCA5A5),
                  width: 1.2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.highlight_off_rounded,
                        size: 20,
                        color: Color(0xFFEF4444),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Keep Out (Contaminants)',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? const Color(0xFFFCA5A5)
                              : const Color(0xFF991B1B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...step.doNotInclude.map((warning) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '✕ ',
                            style: TextStyle(
                              color: Color(0xFFEF4444),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              warning,
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.4,
                                color: isDark
                                    ? const Color(0xFFFECACA)
                                    : const Color(0xFF7F1D1D),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

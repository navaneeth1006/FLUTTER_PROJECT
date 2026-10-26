import 'package:flutter/material.dart';
import '../animations/fade_animation.dart';
import '../animations/slide_animation.dart';
import '../data/recycling_steps.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import 'home_screen.dart';
import 'recycling_step_screen.dart';

/// The Completion Screen celebrating the user's successful review
/// of all 6 recycling steps, presenting an actionable summary and replay options.
class CompletionScreen extends StatelessWidget {
  const CompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.close_rounded),
              tooltip: 'Return to Home',
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Celebration Icon with glowing background
                Center(
                  child: FadeAnimation(
                    duration: const Duration(milliseconds: 700),
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            AppTheme.primaryGreenLight,
                            AppTheme.primaryGreenDark,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryGreen.withValues(
                              alpha: 0.35,
                            ),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.verified_rounded,
                        size: 58,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Congratulations Header
                FadeAnimation(
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    'Congratulations!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: isDark
                          ? AppTheme.textPrimaryDark
                          : AppTheme.textPrimaryLight,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                FadeAnimation(
                  delay: const Duration(milliseconds: 300),
                  child: Text(
                    'You are now an EcoSteps Recycling Champion',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppTheme.primaryGreenLight
                          : AppTheme.primaryGreenDark,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Encouraging paragraph
                FadeAnimation(
                  delay: const Duration(milliseconds: 400),
                  child: Text(
                    'By following these 6 everyday principles, you directly prevent toxic pollution, save trees, preserve clean water, and power the circular economy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: isDark
                          ? AppTheme.textSecondaryDark
                          : AppTheme.textSecondaryLight,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Environmental Impact Stat Cards
                SlideAnimation(
                  direction: SlideDirection.fromBottom,
                  delay: const Duration(milliseconds: 450),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.surfaceDark : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark
                            ? AppTheme.borderDark
                            : AppTheme.borderLight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        _ImpactStat(
                          icon: Icons.electric_bolt_rounded,
                          value: '95%',
                          label: 'Energy Saved on Alum.',
                          color: Color(0xFFF59E0B),
                        ),
                        _ImpactStat(
                          icon: Icons.forest_rounded,
                          value: '17',
                          label: 'Trees / Ton Paper',
                          color: Color(0xFF10B981),
                        ),
                        _ImpactStat(
                          icon: Icons.water_drop_rounded,
                          value: '70%',
                          label: 'Less Water Used',
                          color: Color(0xFF06B6D4),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Summary of the Six Steps
                SlideAnimation(
                  direction: SlideDirection.fromBottom,
                  delay: const Duration(milliseconds: 500),
                  child: Text(
                    'Quick 6-Step Recap',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppTheme.textPrimaryDark
                          : AppTheme.textPrimaryLight,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                ...List.generate(kRecyclingSteps.length, (index) {
                  final step = kRecyclingSteps[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SlideAnimation(
                      direction: SlideDirection.fromBottom,
                      delay: Duration(milliseconds: 550 + (index * 60)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.surfaceDark : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDark
                                ? AppTheme.borderDark
                                : AppTheme.borderLight,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: step.accentColor.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                step.icon,
                                size: 18,
                                color: step.accentColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Step ${step.stepNumber}: ${step.title}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: isDark
                                          ? AppTheme.textPrimaryDark
                                          : AppTheme.textPrimaryLight,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    step.shortDescription,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark
                                          ? AppTheme.textSecondaryDark
                                          : AppTheme.textSecondaryLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.check_circle_rounded,
                              size: 20,
                              color: AppTheme.primaryGreen,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 24),

                // Restart Guide button
                SlideAnimation(
                  direction: SlideDirection.fromBottom,
                  delay: const Duration(milliseconds: 850),
                  child: PrimaryButton(
                    label: 'Restart Guide',
                    icon: Icons.refresh_rounded,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) =>
                              const RecyclingStepScreen(stepIndex: 0),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),

                // Return Home button
                SlideAnimation(
                  direction: SlideDirection.fromBottom,
                  delay: const Duration(milliseconds: 900),
                  child: PrimaryButton(
                    label: 'Return to Home',
                    icon: Icons.home_rounded,
                    isOutlined: true,
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (route) => false,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ImpactStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _ImpactStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Icon(icon, size: 24, color: color),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: isDark
                ? AppTheme.textPrimaryDark
                : AppTheme.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: isDark
                ? AppTheme.textSecondaryDark
                : AppTheme.textSecondaryLight,
          ),
        ),
      ],
    );
  }
}

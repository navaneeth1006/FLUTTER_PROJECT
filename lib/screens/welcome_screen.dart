import 'package:flutter/material.dart';
import '../animations/fade_animation.dart';
import '../animations/slide_animation.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import 'home_screen.dart';
import 'recycling_step_screen.dart';
import 'settings_screen.dart';

/// The welcome screen introducing users to EcoSteps.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings & Information',
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 32,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),

                      // Animated hero recycling illustration / logo
                      FadeAnimation(
                        duration: const Duration(milliseconds: 800),
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Outer glowing pulse ring
                              Container(
                                width: 170,
                                height: 170,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      AppTheme.primaryGreen.withValues(
                                        alpha: isDark ? 0.35 : 0.22,
                                      ),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                              // Core icon circle
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppTheme.primaryGreenLight,
                                      AppTheme.primaryGreenDark,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.primaryGreen.withValues(
                                        alpha: 0.35,
                                      ),
                                      blurRadius: 24,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.recycling_rounded,
                                  size: 64,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // App Name
                      FadeAnimation(
                        delay: const Duration(milliseconds: 200),
                        child: Text(
                          'EcoSteps',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width > 600 ? 40 : 34,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.0,
                            color: isDark
                                ? AppTheme.textPrimaryDark
                                : AppTheme.textPrimaryLight,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Subtitle
                      FadeAnimation(
                        delay: const Duration(milliseconds: 300),
                        child: Text(
                          'Learn to Recycle the Right Way',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppTheme.primaryGreenLight
                                : AppTheme.primaryGreenDark,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Description
                      FadeAnimation(
                        delay: const Duration(milliseconds: 400),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Master the simple 6-step recycling workflow. '
                            'From collection to reuse, discover how to reduce landfill waste '
                            'and build sustainable everyday habits.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.55,
                              color: isDark
                                  ? AppTheme.textSecondaryDark
                                  : AppTheme.textSecondaryLight,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Features summary badges
                      FadeAnimation(
                        delay: const Duration(milliseconds: 500),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10,
                          runSpacing: 10,
                          children: const [
                            _FeatureBadge(
                              icon: Icons.check_circle_outline,
                              label: '6 Easy Steps',
                            ),
                            _FeatureBadge(
                              icon: Icons.lightbulb_outline,
                              label: 'Practical Tips',
                            ),
                            _FeatureBadge(
                              icon: Icons.eco_outlined,
                              label: 'Zero-Waste Habits',
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),
                      const SizedBox(height: 24),

                      // Get Started Button
                      SlideAnimation(
                        direction: SlideDirection.fromBottom,
                        delay: const Duration(milliseconds: 600),
                        child: PrimaryButton(
                          label: 'Get Started',
                          icon: Icons.play_arrow_rounded,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    const RecyclingStepScreen(stepIndex: 0),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Browse Overview Button
                      SlideAnimation(
                        direction: SlideDirection.fromBottom,
                        delay: const Duration(milliseconds: 700),
                        child: PrimaryButton(
                          label: 'View All Steps',
                          icon: Icons.grid_view_rounded,
                          isOutlined: true,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const HomeScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _FeatureBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.primaryGreen),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppTheme.textSecondaryDark
                  : AppTheme.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../animations/fade_animation.dart';
import '../animations/slide_animation.dart';
import '../data/recycling_steps.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import '../widgets/recycling_progress.dart';
import '../widgets/recycling_step_card.dart';
import 'recycling_step_screen.dart';
import 'settings_screen.dart';

/// The Home Screen displaying the complete 6-step recycling overview,
/// progress status, and hero card navigation.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Set to track completed steps in local session
  final Set<int> _completedSteps = {};

  void _markCompleted(int stepNumber) {
    if (!_completedSteps.contains(stepNumber)) {
      setState(() {
        _completedSteps.add(stepNumber);
      });
    }
  }

  void _openStep(int index) async {
    final result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (_) => RecyclingStepScreen(
          stepIndex: index,
          completedSteps: _completedSteps,
        ),
      ),
    );

    if (result != null && mounted) {
      _markCompleted(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final totalSteps = kRecyclingSteps.length;
    final completedCount = _completedSteps.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EcoSteps Guide',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: 'App Information',
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            // Welcome Header banner
            FadeAnimation(
              duration: const Duration(milliseconds: 600),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [AppTheme.surfaceElevatedDark, AppTheme.surfaceDark]
                        : [AppTheme.softMint, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isDark
                        ? AppTheme.borderDark
                        : AppTheme.mintAccent.withValues(alpha: 0.6),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppTheme.primaryGreen.withValues(alpha: 0.2)
                                : AppTheme.mintAccent,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.eco_rounded,
                            size: 24,
                            color: isDark
                                ? AppTheme.primaryGreenLight
                                : AppTheme.deepForest,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Everyday Recycling Guide',
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
                                '$completedCount of $totalSteps steps explored',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? AppTheme.primaryGreenLight
                                      : AppTheme.primaryGreenDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Progress indicator
                    RecyclingProgressIndicator(
                      currentStep: completedCount == 0 ? 1 : completedCount,
                      totalSteps: totalSteps,
                      showDots: true,
                      onStepTapped: (stepNum) {
                        _openStep(stepNum - 1);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Section title
            FadeAnimation(
              delay: const Duration(milliseconds: 150),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recycling Steps',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppTheme.textPrimaryDark
                          : AppTheme.textPrimaryLight,
                      letterSpacing: -0.3,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => _openStep(0),
                    icon: const Icon(Icons.play_circle_outline, size: 18),
                    label: const Text(
                      'Start from Step 1',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Staggered animated step cards
            ...List.generate(totalSteps, (index) {
              final step = kRecyclingSteps[index];
              final isCompleted = _completedSteps.contains(step.stepNumber);

              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: SlideAnimation(
                  direction: SlideDirection.fromBottom,
                  delay: Duration(milliseconds: 100 * (index + 1)),
                  child: RecyclingStepCard(
                    step: step,
                    isCompleted: isCompleted,
                    onTap: () => _openStep(index),
                  ),
                ),
              );
            }),

            const SizedBox(height: 16),

            // Bottom CTA
            SlideAnimation(
              direction: SlideDirection.fromBottom,
              delay: const Duration(milliseconds: 700),
              child: PrimaryButton(
                label: completedCount == totalSteps
                    ? 'Review Completed Guide'
                    : 'Continue Interactive Guide',
                icon: Icons.arrow_forward_rounded,
                onPressed: () {
                  // Find next incomplete step or start from 0
                  int nextIdx = 0;
                  for (int i = 0; i < totalSteps; i++) {
                    if (!_completedSteps.contains(i + 1)) {
                      nextIdx = i;
                      break;
                    }
                  }
                  _openStep(nextIdx);
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

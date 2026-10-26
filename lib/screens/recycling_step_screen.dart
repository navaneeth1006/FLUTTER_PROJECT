import 'package:flutter/material.dart';
import '../data/recycling_steps.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_step_content.dart';
import '../widgets/primary_button.dart';
import '../widgets/recycling_progress.dart';
import 'completion_screen.dart';

/// The detailed step screen displaying in-depth recycling guidance,
/// animated content, Hero icon transitions, and Next/Previous navigation.
class RecyclingStepScreen extends StatefulWidget {
  /// Zero-based index of the step to display initially.
  final int stepIndex;

  /// Optional set of previously completed step numbers.
  final Set<int>? completedSteps;

  const RecyclingStepScreen({
    super.key,
    required this.stepIndex,
    this.completedSteps,
  });

  @override
  State<RecyclingStepScreen> createState() => _RecyclingStepScreenState();
}

class _RecyclingStepScreenState extends State<RecyclingStepScreen> {
  late int _currentIndex;
  late final PageController _pageController;
  final Set<int> _completed = {};

  @override
  void initState() {
    super.initState();
    // Validate index safely
    final validIndex = widget.stepIndex.clamp(0, kRecyclingSteps.length - 1);
    _currentIndex = validIndex;
    _pageController = PageController(initialPage: validIndex);

    if (widget.completedSteps != null) {
      _completed.addAll(widget.completedSteps!);
    }
    // Mark current step as visited
    _completed.add(kRecyclingSteps[validIndex].stepNumber);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToStep(int index) {
    if (index < 0 || index >= kRecyclingSteps.length) return;
    setState(() {
      _currentIndex = index;
      _completed.add(kRecyclingSteps[index].stepNumber);
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  void _onNext() {
    if (_currentIndex < kRecyclingSteps.length - 1) {
      _goToStep(_currentIndex + 1);
    } else {
      // Completed all steps! Navigate to Completion Screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const CompletionScreen()),
      );
    }
  }

  void _onPrevious() {
    if (_currentIndex > 0) {
      _goToStep(_currentIndex - 1);
    }
  }

  void _onRestart() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Restart Guide?'),
        content: const Text(
          'This will return you to Step 1: Collect Waste. Would you like to restart?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _goToStep(0);
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final totalSteps = kRecyclingSteps.length;
    final currentStep = kRecyclingSteps[_currentIndex];
    final isFirstStep = _currentIndex == 0;
    final isLastStep = _currentIndex == totalSteps - 1;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        // Return latest completed step
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Step ${_currentIndex + 1} of $totalSteps',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.restart_alt_rounded),
              tooltip: 'Restart Guide',
              onPressed: _onRestart,
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Sticky top progress indicator
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: RecyclingProgressIndicator(
                  currentStep: _currentIndex + 1,
                  totalSteps: totalSteps,
                  showDots: true,
                  onStepTapped: (stepNum) => _goToStep(stepNum - 1),
                ),
              ),
              const Divider(height: 1),

              // PageView body with smooth swipe or programmatic navigation
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: totalSteps,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                      _completed.add(kRecyclingSteps[index].stepNumber);
                    });
                  },
                  itemBuilder: (context, index) {
                    final step = kRecyclingSteps[index];
                    return AnimatedStepContent(
                      key: ValueKey('step_${step.stepNumber}'),
                      step: step,
                    );
                  },
                ),
              ),

              // Sticky Bottom Navigation Controls
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.surfaceDark : Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: isDark
                          ? AppTheme.borderDark
                          : AppTheme.borderLight,
                      width: 1,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDark ? 0.25 : 0.05,
                      ),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Previous Button
                    Expanded(
                      flex: 1,
                      child: PrimaryButton(
                        label: 'Previous',
                        icon: Icons.arrow_back_rounded,
                        isOutlined: true,
                        onPressed: isFirstStep ? null : _onPrevious,
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Next / Complete Button
                    Expanded(
                      flex: 1,
                      child: PrimaryButton(
                        label: isLastStep ? 'Complete' : 'Next Step',
                        icon: isLastStep
                            ? Icons.celebration_rounded
                            : Icons.arrow_forward_rounded,
                        backgroundColor: isLastStep
                            ? const Color(0xFF059669)
                            : currentStep.accentColor,
                        onPressed: _onNext,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

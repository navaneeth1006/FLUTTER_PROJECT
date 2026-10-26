import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/app.dart';
import 'package:flutter_application_1/data/recycling_steps.dart';
import 'package:flutter_application_1/screens/completion_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/recycling_step_screen.dart';

void main() {
  group('EcoSteps Widget Tests', () {
    testWidgets('Welcome screen renders properly with branding and buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const EcoStepsApp());
      await tester.pumpAndSettle();

      // Verify app title and subtitle
      expect(find.text('EcoSteps'), findsOneWidget);
      expect(find.text('Learn to Recycle the Right Way'), findsOneWidget);

      // Verify primary action buttons
      expect(find.text('Get Started'), findsOneWidget);
      expect(find.text('View All Steps'), findsOneWidget);
    });

    testWidgets('Home screen displays all 6 recycling steps', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(800, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Everyday Recycling Guide'), findsOneWidget);
      expect(find.text('Recycling Steps'), findsOneWidget);

      // Verify all 6 step titles are in the widget tree
      for (final step in kRecyclingSteps) {
        expect(find.text(step.title), findsOneWidget);
      }
    });

    testWidgets('Tapping a step opens its detail screen with instructions', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pumpAndSettle();

      // Tap on the first step card
      await tester.tap(find.text('Collect Waste'));
      await tester.pumpAndSettle();

      // Should be on detail screen for Step 1
      expect(find.text('Step 1 of 6'), findsWidgets);
      expect(find.text('Collect Waste'), findsOneWidget);
      expect(find.text('Practical Eco Tip'), findsOneWidget);
      expect(find.text('Instructions'), findsOneWidget);
      expect(find.text('Next Step'), findsOneWidget);
    });

    testWidgets('Next and Previous buttons navigate through steps correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: RecyclingStepScreen(stepIndex: 0)),
      );
      await tester.pumpAndSettle();

      // Initially on Step 1: Previous button should be disabled (onPressed == null)
      final prevFinder = find.widgetWithText(OutlinedButton, 'Previous');
      expect(prevFinder, findsOneWidget);
      final OutlinedButton prevButton = tester.widget(prevFinder);
      expect(prevButton.onPressed, isNull);

      // Tap 'Next Step' to navigate to Step 2
      await tester.tap(find.text('Next Step'));
      await tester.pumpAndSettle();

      // Now on Step 2
      expect(find.text('Step 2 of 6'), findsWidgets);
      expect(find.text('Separate Materials'), findsOneWidget);

      // Previous button should now be enabled
      final OutlinedButton prevButtonStep2 = tester.widget(prevFinder);
      expect(prevButtonStep2.onPressed, isNotNull);

      // Tap 'Previous' to go back to Step 1
      await tester.tap(prevFinder);
      await tester.pumpAndSettle();

      expect(find.text('Step 1 of 6'), findsWidgets);
      expect(find.text('Collect Waste'), findsOneWidget);
    });

    testWidgets('Navigating through all steps opens the completion screen', (
      WidgetTester tester,
    ) async {
      // Start directly on step 5 (0-indexed, Step 6: Reuse and Reduce)
      await tester.pumpWidget(
        const MaterialApp(home: RecyclingStepScreen(stepIndex: 5)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Step 6 of 6'), findsWidgets);
      expect(find.text('Reuse and Reduce'), findsOneWidget);
      expect(find.text('Complete'), findsOneWidget);

      // Tap Complete
      await tester.tap(find.text('Complete'));
      await tester.pumpAndSettle();

      // Verify Completion screen content
      expect(find.text('Congratulations!'), findsOneWidget);
      expect(
        find.text('You are now an EcoSteps Recycling Champion'),
        findsOneWidget,
      );
      expect(find.text('Quick 6-Step Recap'), findsOneWidget);
      expect(find.text('Restart Guide'), findsOneWidget);
      expect(find.text('Return to Home'), findsOneWidget);
    });

    testWidgets('Restarting the guide from completion returns to Step 1', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(800, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const MaterialApp(home: CompletionScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Restart Guide'), findsOneWidget);
      await tester.tap(find.text('Restart Guide'));
      await tester.pumpAndSettle();

      expect(find.text('Step 1 of 6'), findsWidgets);
      expect(find.text('Collect Waste'), findsOneWidget);
    });
  });
}

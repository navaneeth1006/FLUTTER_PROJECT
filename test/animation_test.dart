import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/animations/fade_animation.dart';
import 'package:flutter_application_1/animations/hero_recycling_icon.dart';
import 'package:flutter_application_1/animations/slide_animation.dart';
import 'package:flutter_application_1/data/recycling_steps.dart';
import 'package:flutter_application_1/screens/recycling_step_screen.dart';

void main() {
  group('EcoSteps Animation Tests', () {
    testWidgets('FadeAnimation initializes and animates opacity smoothly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FadeAnimation(
              duration: Duration(milliseconds: 300),
              child: Text('Fade Test Content'),
            ),
          ),
        ),
      );

      // Verify widget tree contains FadeTransition inside FadeAnimation
      final fadeFinder = find.descendant(
        of: find.byType(FadeAnimation),
        matching: find.byType(FadeTransition),
      );
      expect(fadeFinder, findsOneWidget);

      final FadeTransition initialFade = tester.widget(fadeFinder);
      expect(initialFade.opacity.value, inInclusiveRange(0.0, 1.0));

      // Advance clock past the duration
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      final FadeTransition settledFade = tester.widget(fadeFinder);
      expect(settledFade.opacity.value, equals(1.0));
      expect(find.text('Fade Test Content'), findsOneWidget);
    });

    testWidgets('SlideAnimation initializes with correct direction offset', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SlideAnimation(
              direction: SlideDirection.fromBottom,
              offsetDistance: 0.2,
              duration: Duration(milliseconds: 300),
              child: Text('Slide Test Content'),
            ),
          ),
        ),
      );

      final slideFinder = find.descendant(
        of: find.byType(SlideAnimation),
        matching: find.byType(SlideTransition),
      );
      expect(slideFinder, findsOneWidget);

      // Advance clock past duration
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      final SlideTransition settledSlide = tester.widget(slideFinder);
      expect(settledSlide.position.value, equals(Offset.zero));
      expect(find.text('Slide Test Content'), findsOneWidget);
    });

    testWidgets('HeroRecyclingIcon wraps Hero with valid non-empty tag', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeroRecyclingIcon(
              heroTag: 'test_hero_tag',
              icon: Icons.recycling,
              backgroundColor: Colors.green,
              iconColor: Colors.white,
            ),
          ),
        ),
      );

      final heroFinder = find.byType(Hero);
      expect(heroFinder, findsOneWidget);

      final Hero heroWidget = tester.widget(heroFinder);
      expect(heroWidget.tag, equals('test_hero_tag'));
    });

    testWidgets(
      'Animated navigation between steps executes without throwing exceptions',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: RecyclingStepScreen(stepIndex: 0)),
        );
        await tester.pumpAndSettle();

        // Navigate from step 0 to step 1
        await tester.tap(find.text('Next Step'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 150));
        await tester.pumpAndSettle();

        expect(find.text('Step 2 of 6'), findsWidgets);

        // Navigate backwards to step 0
        await tester.tap(find.text('Previous'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 150));
        await tester.pumpAndSettle();

        expect(find.text('Step 1 of 6'), findsWidgets);
      },
    );

    testWidgets('AnimationControllers dispose properly on unmount', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FadeAnimation(
              child: SlideAnimation(child: Text('Nested Animation')),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 50));

      // Replace with empty container to trigger dispose() on all controllers
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SizedBox.shrink())),
      );

      // No exception should be thrown during disposal
      expect(tester.takeException(), isNull);
    });

    test('All 6 dataset steps have distinct, collision-free hero tags', () {
      final tags = <String>{};
      for (final step in kRecyclingSteps) {
        expect(
          tags.contains(step.heroTag),
          isFalse,
          reason: 'Tag collision detected: ${step.heroTag}',
        );
        tags.add(step.heroTag);
      }
      expect(tags.length, equals(6));
    });
  });
}

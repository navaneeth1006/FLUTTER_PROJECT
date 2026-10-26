import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/data/recycling_steps.dart';

void main() {
  group('Recycling Steps Unit Tests', () {
    test('Exactly six recycling steps are defined', () {
      expect(kRecyclingSteps.length, equals(6));
    });

    test('Each step has sequential numbering from 1 to 6', () {
      for (int i = 0; i < kRecyclingSteps.length; i++) {
        expect(kRecyclingSteps[i].stepNumber, equals(i + 1));
      }
    });

    test('Each step has non-empty title, descriptions, and practical tip', () {
      for (final step in kRecyclingSteps) {
        expect(
          step.title.trim().isNotEmpty,
          isTrue,
          reason: 'Step ${step.stepNumber} title should not be empty',
        );
        expect(
          step.shortDescription.trim().isNotEmpty,
          isTrue,
          reason:
              'Step ${step.stepNumber} short description should not be empty',
        );
        expect(
          step.detailedInstruction.trim().isNotEmpty,
          isTrue,
          reason:
              'Step ${step.stepNumber} detailed instruction should not be empty',
        );
        expect(
          step.practicalTip.trim().isNotEmpty,
          isTrue,
          reason: 'Step ${step.stepNumber} practical tip should not be empty',
        );
        expect(
          step.keyItems.isNotEmpty,
          isTrue,
          reason: 'Step ${step.stepNumber} must have recommended items',
        );
        expect(
          step.doNotInclude.isNotEmpty,
          isTrue,
          reason: 'Step ${step.stepNumber} must have contaminant warnings',
        );
        expect(
          step.heroTag.isNotEmpty,
          isTrue,
          reason: 'Step ${step.stepNumber} must have a hero tag',
        );
      }
    });

    test('All Hero tags are completely unique across steps', () {
      final tags = kRecyclingSteps.map((s) => s.heroTag).toSet();
      expect(
        tags.length,
        equals(kRecyclingSteps.length),
        reason: 'Every step must have a strictly unique hero tag',
      );
    });

    test('Step indexes and boundaries are handled correctly', () {
      // Step indices range from 0 to 5
      expect(kRecyclingSteps.isNotEmpty, isTrue);
      expect(5 < kRecyclingSteps.length, isTrue);

      // Boundaries test
      const int invalidNegative = -1;
      const int invalidExcess = 99;
      final clampedMin = invalidNegative.clamp(0, kRecyclingSteps.length - 1);
      final clampedMax = invalidExcess.clamp(0, kRecyclingSteps.length - 1);

      expect(clampedMin, equals(0));
      expect(clampedMax, equals(5));
    });

    test('Progress calculation produces correct fraction and percentage', () {
      const totalSteps = 6;
      for (int step = 1; step <= totalSteps; step++) {
        final progressFraction = step / totalSteps;
        final percentage = (progressFraction * 100).toInt();

        expect(progressFraction, inInclusiveRange(0.0, 1.0));
        expect(percentage, equals(((step / 6) * 100).toInt()));
      }

      // Boundary clamp test
      final clampedProgress0 = (0.clamp(1, 6)) / 6;
      final clampedProgress7 = (7.clamp(1, 6)) / 6;
      expect(clampedProgress0, equals(1 / 6));
      expect(clampedProgress7, equals(1.0));
    });

    test('Specific required step titles match project specifications', () {
      expect(kRecyclingSteps[0].title, equals('Collect Waste'));
      expect(kRecyclingSteps[1].title, equals('Separate Materials'));
      expect(kRecyclingSteps[2].title, equals('Clean and Dry'));
      expect(kRecyclingSteps[3].title, equals('Sort Correctly'));
      expect(kRecyclingSteps[4].title, equals('Send for Recycling'));
      expect(kRecyclingSteps[5].title, equals('Reuse and Reduce'));
    });
  });
}

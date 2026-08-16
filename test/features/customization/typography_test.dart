import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/core/theme/nudge_typography.dart';
import 'package:nudge/features/customization/domain/models/theme_config.dart';

void main() {
  group('NudgeFontFamily mappings', () {
    test('fontFamilyName maps to correct pubspec declaration', () {
      expect(NudgeFontFamily.inter.fontFamilyName, 'Inter');
      expect(NudgeFontFamily.plusJakartaSans.fontFamilyName, 'PlusJakartaSans');
      expect(NudgeFontFamily.spaceGrotesk.fontFamilyName, 'SpaceGrotesk');
      expect(NudgeFontFamily.ibmPlexMono.fontFamilyName, 'IBMPlexMono');
      expect(NudgeFontFamily.system.fontFamilyName, isNull);
    });

    test('getNearestWeight maps weight request to capability', () {
      // Inter has all weights
      expect(NudgeFontFamily.inter.getNearestWeight(350), FontWeight.w400);

      // Space Grotesk only has 300, 400, 500, 600, 700
      expect(NudgeFontFamily.spaceGrotesk.getNearestWeight(100), FontWeight.w300);
      expect(NudgeFontFamily.spaceGrotesk.getNearestWeight(900), FontWeight.w700);
    });
  });

  group('NudgeTextCase transform formatting', () {
    test('TextCase values transform text correctly', () {
      expect(NudgeTextCase.none.apply('Hello'), 'Hello');
      expect(NudgeTextCase.upper.apply('Hello'), 'HELLO');
      expect(NudgeTextCase.lower.apply('Hello'), 'hello');
    });
  });

  group('NudgeTypeScale scaling from ThemeConfig', () {
    test('fontSizeScale multiplies base sizes', () {
      final config = ThemeConfig()..fontSizeScale = 1.5;
      final scale = NudgeTypeScale.fromConfig(config);
      expect(scale.body.fontSize, 15 * 1.5);
      expect(scale.label.fontSize, 13 * 1.5);
    });

    test('letterSpacingDelta adjusts spacing', () {
      final config = ThemeConfig()..letterSpacingDelta = 0.5;
      final scale = NudgeTypeScale.fromConfig(config);
      expect(scale.body.letterSpacing, 0.1 + 0.5);
    });

    test('lineHeightScale multiplies line heights', () {
      final config = ThemeConfig()..lineHeightScale = 1.2;
      final scale = NudgeTypeScale.fromConfig(config);
      expect(scale.body.height, closeTo(1.55 * 1.2, 0.01));
    });
  });
}

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/core/theme/nudge_motion.dart';
import 'package:nudge/core/theme/theme_presets.dart';
import 'package:nudge/features/customization/domain/models/theme_config.dart';

void main() {
  group('Accessibility Theme Resolution', () {
    test('highContrast mode overrides colors to WCAG AAA contrast tokens', () {
      final configDark = ThemeConfig()..name = 'Test'..highContrast = true..colorPreset = 'dark';
      final themeDark = buildThemeDataFromConfig(configDark, Brightness.dark);
      expect(themeDark.background, const Color(0xFF000000));
      expect(themeDark.primaryText, const Color(0xFFFFFFFF));
      expect(themeDark.accent, const Color(0xFFFFE600)); // high contrast yellow

      final configLight = ThemeConfig()..name = 'Test'..highContrast = true..colorPreset = 'light';
      final themeLight = buildThemeDataFromConfig(configLight, Brightness.light);
      expect(themeLight.background, const Color(0xFFFFFFFF));
      expect(themeLight.primaryText, const Color(0xFF000000));
      expect(themeLight.accent, const Color(0xFF0000D0)); // high contrast blue
    });

    test('reducedMotion mode overrides motionMode to none', () {
      final config = ThemeConfig()
        ..name = 'Test'
        ..motionMode = 'smooth'
        ..reducedMotion = true;
      final theme = buildThemeDataFromConfig(config, Brightness.dark);
      expect(theme.motion.mode, NudgeMotionMode.none);
      expect(theme.motion.fast, Duration.zero);
      expect(theme.motion.normal, Duration.zero);
    });

    test('hapticFeedback flag reflects configuration state', () {
      final config = ThemeConfig()..hapticFeedback = false;
      expect(config.hapticFeedback, isFalse);
      config.hapticFeedback = true;
      expect(config.hapticFeedback, isTrue);
    });
  });
}

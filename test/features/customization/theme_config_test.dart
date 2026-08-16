import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/core/theme/nudge_theme.dart';
import 'package:nudge/core/theme/nudge_colors.dart';
import 'package:nudge/core/theme/theme_presets.dart';
import 'package:nudge/features/customization/domain/models/theme_config.dart';

void main() {
  group('ThemeConfig Preset seeds & build theme', () {
    test('Pure preset config matches defaults', () {
      final config = NudgeThemePreset.pure.toConfig();
      expect(config.name, 'Pure');
      expect(config.fontFamily, 'Inter');
      expect(config.colorPreset, 'light');
      expect(config.motionMode, 'calm');
    });

    test('OLED preset matches oled defaults', () {
      final config = NudgeThemePreset.oled.toConfig();
      expect(config.colorPreset, 'oled');
      expect(config.fontFamily, 'Inter');
      expect(config.motionMode, 'calm');
    });

    test('Terminal preset matches monospace terminal defaults', () {
      final config = NudgeThemePreset.terminal.toConfig();
      expect(config.colorPreset, 'custom');
      expect(config.fontFamily, 'JetBrainsMono');
      expect(config.motionMode, 'none');
    });

    test('buildThemeDataFromConfig parses correct brightness', () {
      final config = NudgeThemePreset.oled.toConfig();
      final data = buildThemeDataFromConfig(config, Brightness.dark);
      expect(data.colors.brightness, Brightness.dark);
      expect(data.themeMode, NudgeThemeMode.oled);
    });

    test('buildThemeDataFromConfig applies font weights correctly', () {
      final config = NudgeThemePreset.pure.toConfig();
      config.fontWeight = 800;
      final data = buildThemeDataFromConfig(config, Brightness.light);
      expect(data.type.body.fontWeight, FontWeight.w800);
    });
  });

  group('WCAG Contrast Safe Calculations', () {
    test('Contrast ratio calculation of identical colors is 1.0', () {
      final ratio = NudgeColorScheme.contrastRatio(const Color(0xFF000000), const Color(0xFF000000));
      expect(ratio, 1.0);
    });

    test('Contrast ratio of white and black is 21.0', () {
      final ratio = NudgeColorScheme.contrastRatio(const Color(0xFFFFFFFF), const Color(0xFF000000));
      expect(ratio, closeTo(21.0, 0.1));
    });

    test('safeContrast shifts low-contrast colors above 4.5:1 ratio', () {
      final background = const Color(0xFF101010); // Very dark
      final lowContrastText = const Color(0xFF151515); // Almost identical
      final adjusted = NudgeColorScheme.safeContrast(background, lowContrastText);
      final ratio = NudgeColorScheme.contrastRatio(background, adjusted);
      expect(ratio, greaterThanOrEqualTo(4.5));
    });
  });

  group('ThemeConfig defaults', () {
    test('ThemeConfig fields default correctly', () {
      final config = ThemeConfig();
      expect(config.fontSizeScale, 1.0);
      expect(config.letterSpacingDelta, 0.0);
      expect(config.lineHeightScale, 1.0);
      expect(config.showIcons, isFalse);
      expect(config.clockFormat, '24');
    });
  });
}

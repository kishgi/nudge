import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/core/theme/nudge_colors.dart';
import 'package:nudge/core/theme/nudge_icons.dart';
import 'package:nudge/core/theme/nudge_theme.dart';

import 'package:nudge/core/theme/nudge_typography.dart';
import 'package:nudge/core/theme/theme_presets.dart';
import 'package:nudge/features/customization/domain/models/theme_config.dart';

void main() {
  group('Font Family Parsing & Propagation', () {
    test('NudgeFontFamily.parse parses id, name, and fontFamilyName correctly', () {
      expect(NudgeFontFamily.parse('Inter'), NudgeFontFamily.inter);
      expect(NudgeFontFamily.parse('inter'), NudgeFontFamily.inter);

      expect(NudgeFontFamily.parse('Plus Jakarta Sans'), NudgeFontFamily.plusJakartaSans);
      expect(NudgeFontFamily.parse('PlusJakartaSans'), NudgeFontFamily.plusJakartaSans);

      expect(NudgeFontFamily.parse('Space Grotesk'), NudgeFontFamily.spaceGrotesk);
      expect(NudgeFontFamily.parse('SpaceGrotesk'), NudgeFontFamily.spaceGrotesk);

      expect(NudgeFontFamily.parse('IBM Plex Sans'), NudgeFontFamily.ibmPlexSans);
      expect(NudgeFontFamily.parse('IBMPlexSans'), NudgeFontFamily.ibmPlexSans);

      expect(NudgeFontFamily.parse('IBM Plex Mono'), NudgeFontFamily.ibmPlexMono);
      expect(NudgeFontFamily.parse('IBMPlexMono'), NudgeFontFamily.ibmPlexMono);

      expect(NudgeFontFamily.parse('JetBrains Mono'), NudgeFontFamily.jetBrainsMono);
      expect(NudgeFontFamily.parse('JetBrainsMono'), NudgeFontFamily.jetBrainsMono);

      expect(NudgeFontFamily.parse('system'), NudgeFontFamily.system);
    });

    test('NudgeTypeScale.fromConfig builds valid font styles for all built-in families', () {
      final families = [
        'Inter',
        'PlusJakartaSans',
        'SpaceGrotesk',
        'IBMPlexSans',
        'IBMPlexMono',
        'JetBrainsMono',
        'monospace',
      ];

      for (final fam in families) {
        final cfg = ThemeConfig()..fontFamily = fam;
        final typeScale = NudgeTypeScale.fromConfig(cfg);
        expect(typeScale.display.fontFamily, isNotNull);
        expect(typeScale.body.fontFamily, isNotNull);
      }
    });
  });

  group('Icon Pack Resolution', () {
    test('NudgeIconResolver resolves icons for all supported icon packs', () {
      for (final pack in NudgeIconPack.values) {
        final settings = NudgeIconSettings(
          pack: pack,
          size: 24.0,
          thickness: 1.5,
          style: 'outline',
          colorOverride: null,
          opacity: 1.0,
        );
        final resolver = NudgeIconResolver.forSettings(settings);
        expect(resolver.resolve(NudgeIconToken.home), isA<IconData>());
        expect(resolver.resolve(NudgeIconToken.search), isA<IconData>());
        expect(resolver.resolve(NudgeIconToken.settings), isA<IconData>());
        expect(resolver.resolve(NudgeIconToken.arrowBack), isA<IconData>());
      }
    });
  });

  group('Color Presets & ThemeData Building', () {
    test('buildThemeDataFromConfig constructs valid theme data for all presets', () {
      for (final preset in NudgeThemePreset.values) {
        final cfg = preset.toConfig();
        final themeData = buildThemeDataFromConfig(cfg, Brightness.dark);
        expect(themeData.background, isA<Color>());
        expect(themeData.primaryText, isA<Color>());
        expect(themeData.accent, isA<Color>());
      }
    });
  });
}

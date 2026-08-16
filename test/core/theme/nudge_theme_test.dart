import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/core/theme/nudge_colors.dart';
import 'package:nudge/core/theme/nudge_icons.dart';
import 'package:nudge/core/theme/nudge_motion.dart';
import 'package:nudge/core/theme/nudge_radius.dart';
import 'package:nudge/core/theme/nudge_semantic_colors.dart';
import 'package:nudge/core/theme/nudge_spacing.dart';
import 'package:nudge/core/theme/nudge_typography.dart';
import 'package:nudge/core/theme/theme_presets.dart';

void main() {
  // ---------------------------------------------------------------------------
  // Color scheme tests
  // ---------------------------------------------------------------------------
  group('NudgeColorScheme', () {
    test('light palette has correct brightness', () {
      expect(NudgeColorScheme.light.brightness, Brightness.light);
    });

    test('dark palette has correct brightness', () {
      expect(NudgeColorScheme.dark.brightness, Brightness.dark);
    });

    test('oled background is true black', () {
      expect(NudgeColorScheme.oled.background, const Color(0xFF000000));
    });

    test('terminal accent is green', () {
      // Terminal accent is 0xFF39FF88 — verify green channel dominates
      final c = NudgeColorScheme.terminal.accent;
      expect(c.g, greaterThan(c.r));
      expect(c.g, greaterThan(c.b));
    });

    test('colors are not fully transparent', () {
      for (final scheme in [
        NudgeColorScheme.light,
        NudgeColorScheme.dark,
        NudgeColorScheme.oled,
        NudgeColorScheme.terminal,
        NudgeColorScheme.paper,
        NudgeColorScheme.purple,
        NudgeColorScheme.linear,
        NudgeColorScheme.nothing,
        NudgeColorScheme.developer,
      ]) {
        expect(scheme.background.a, greaterThan(0),
            reason: 'background must not be transparent');
        expect(scheme.accent.a, greaterThan(0),
            reason: 'accent must not be transparent');
      }
    });

    test('copyWith preserves unchanged fields', () {
      final modified =
          NudgeColorScheme.light.copyWith(accent: const Color(0xFFFF0000));
      expect(modified.background, NudgeColorScheme.light.background);
      expect(modified.accent, const Color(0xFFFF0000));
    });
  });

  // ---------------------------------------------------------------------------
  // Semantic colors
  // ---------------------------------------------------------------------------
  group('NudgeSemanticColors', () {
    const sc = NudgeSemanticColors();

    test('success is green-dominant', () {
      expect(sc.success.g, greaterThan(sc.success.r));
    });

    test('error is red-dominant', () {
      expect(sc.error.r, greaterThan(sc.error.g));
    });

    test('warning has high red and green (amber)', () {
      expect(sc.warning.r, greaterThan(0));
      expect(sc.warning.g, greaterThan(0));
    });

    test('subtle variants have low alpha', () {
      expect(sc.successSubtle.a, lessThan(0.2));
      expect(sc.errorSubtle.a, lessThan(0.2));
    });
  });

  // ---------------------------------------------------------------------------
  // Typography scale
  // ---------------------------------------------------------------------------
  group('NudgeTypeScale', () {
    final scale = NudgeTypeScale.defaults();

    test('font sizes decrease from display to caption', () {
      final sizes = [
        scale.display.fontSize!,
        scale.headline.fontSize!,
        scale.title.fontSize!,
        scale.body.fontSize!,
        scale.label.fontSize!,
        scale.caption.fontSize!,
      ];
      for (int i = 0; i < sizes.length - 1; i++) {
        expect(sizes[i], greaterThan(sizes[i + 1]),
            reason: 'Type scale must decrease monotonically');
      }
    });

    test('default font family is Inter', () {
      expect(scale.fontFamily, 'Inter');
      expect(scale.display.fontFamily, 'Inter');
    });

    test('withFontFamily swaps family on all styles', () {
      final mono = scale.withFontFamily('monospace');
      expect(mono.fontFamily, 'monospace');
      expect(mono.display.fontFamily, 'monospace');
      expect(mono.caption.fontFamily, 'monospace');
    });

    test('mono factory uses monospace font', () {
      final mono = NudgeTypeScale.mono();
      expect(mono.fontFamily, 'monospace');
    });
  });

  // ---------------------------------------------------------------------------
  // Spacing tokens
  // ---------------------------------------------------------------------------
  group('NudgeSpacing', () {
    test('tokens increase monotonically', () {
      final values = [
        NudgeSpacing.xs,
        NudgeSpacing.sm,
        NudgeSpacing.md,
        NudgeSpacing.lg,
        NudgeSpacing.xl,
        NudgeSpacing.xxl,
        NudgeSpacing.huge,
      ];
      for (int i = 0; i < values.length - 1; i++) {
        expect(values[i], lessThan(values[i + 1]),
            reason: 'Spacing tokens must be strictly increasing');
      }
    });

    test('pageHorizontal equals lg', () {
      expect(NudgeSpacing.pageHorizontal, NudgeSpacing.lg);
    });
  });

  // ---------------------------------------------------------------------------
  // Radius tokens
  // ---------------------------------------------------------------------------
  group('NudgeRadius', () {
    test('tokens increase monotonically', () {
      final values = [
        NudgeRadius.xs,
        NudgeRadius.small,
        NudgeRadius.medium,
        NudgeRadius.large,
        NudgeRadius.xl,
      ];
      for (int i = 0; i < values.length - 1; i++) {
        expect(values[i], lessThan(values[i + 1]),
            reason: 'Radius tokens must be strictly increasing');
      }
    });

    test('full radius is very large', () {
      expect(NudgeRadius.full, greaterThan(100));
    });
  });

  // ---------------------------------------------------------------------------
  // Motion tokens
  // ---------------------------------------------------------------------------
  group('NudgeMotion', () {
    test('none mode has zero durations', () {
      expect(NudgeMotion.none.fast, Duration.zero);
      expect(NudgeMotion.none.normal, Duration.zero);
      expect(NudgeMotion.none.slow, Duration.zero);
    });

    test('calm fast < calm normal < calm slow', () {
      final m = NudgeMotion.calm;
      expect(m.fast, lessThan(m.normal));
      expect(m.normal, lessThan(m.slow));
    });

    test('smooth normal is longer than calm normal', () {
      expect(NudgeMotion.smooth.normal,
          greaterThan(NudgeMotion.calm.normal));
    });

    test('forMode returns correct instance', () {
      expect(NudgeMotion.forMode(NudgeMotionMode.none), NudgeMotion.none);
      expect(NudgeMotion.forMode(NudgeMotionMode.calm), NudgeMotion.calm);
      expect(NudgeMotion.forMode(NudgeMotionMode.smooth), NudgeMotion.smooth);
    });
  });

  // ---------------------------------------------------------------------------
  // Theme presets
  // ---------------------------------------------------------------------------
  group('NudgeThemePreset', () {
    test('all presets build without throwing', () {
      for (final preset in NudgeThemePreset.values) {
        expect(
          () => preset.build(systemBrightness: Brightness.light),
          returnsNormally,
          reason: '${preset.label} should build cleanly',
        );
      }
    });

    test('pure preset uses light colors in light system brightness', () {
      final data =
          NudgeThemePreset.pure.build(systemBrightness: Brightness.light);
      expect(data.brightness, Brightness.light);
    });

    test('pure preset uses dark colors in dark system brightness', () {
      final data =
          NudgeThemePreset.pure.build(systemBrightness: Brightness.dark);
      expect(data.brightness, Brightness.dark);
    });

    test('oled preset background is black', () {
      final data = NudgeThemePreset.oled.build();
      expect(data.background, const Color(0xFF000000));
    });

    test('terminal preset uses no-motion', () {
      final data = NudgeThemePreset.terminal.build();
      expect(data.motion.mode, NudgeMotionMode.none);
    });

    test('linear preset uses smooth motion', () {
      final data = NudgeThemePreset.linear.build();
      expect(data.motion.mode, NudgeMotionMode.smooth);
    });

    test('all presets have non-empty labels', () {
      for (final preset in NudgeThemePreset.values) {
        expect(preset.label, isNotEmpty);
        expect(preset.description, isNotEmpty);
      }
    });

    test('terminal preset uses monospace font', () {
      final data = NudgeThemePreset.terminal.build();
      // Terminal uses JetBrains Mono — a bundled monospace font.
      expect(data.type.fontFamily, 'JetBrainsMono');
    });
  });

  // ---------------------------------------------------------------------------
  // Icon resolver
  // ---------------------------------------------------------------------------
  group('MaterialIconResolver', () {
    const resolver = MaterialIconResolver();

    test('pack is material', () {
      expect(resolver.pack, NudgeIconPack.material);
    });

    test('all tokens resolve without throwing', () {
      for (final token in NudgeIconToken.values) {
        expect(
          () => resolver.resolve(token),
          returnsNormally,
          reason: '${token.name} must resolve to an IconData',
        );
      }
    });

    test('home and search resolve to different icons', () {
      final home = resolver.resolve(NudgeIconToken.home);
      final search = resolver.resolve(NudgeIconToken.search);
      expect(home.codePoint, isNot(equals(search.codePoint)));
    });
  });
}

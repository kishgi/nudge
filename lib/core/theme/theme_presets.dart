import 'package:flutter/widgets.dart';

import 'nudge_colors.dart';
import 'nudge_icons.dart';
import 'nudge_motion.dart';
import 'nudge_semantic_colors.dart';
import 'nudge_theme.dart';
import 'nudge_typography.dart';

/// Nudge Design System — Theme Presets
///
/// Each preset is a named combination of design tokens.
/// All presets share the same [NudgeThemeData] structure;
/// only token values differ. No separate widget implementations exist per theme.

enum NudgeThemePreset {
  pure,
  purple,
  oled,
  terminal,
  paper,
  linear,
  nothing,
  developer;

  /// Human-readable display name.
  String get label => switch (this) {
        NudgeThemePreset.pure => 'Pure',
        NudgeThemePreset.purple => 'Purple',
        NudgeThemePreset.oled => 'OLED',
        NudgeThemePreset.terminal => 'Terminal',
        NudgeThemePreset.paper => 'Paper',
        NudgeThemePreset.linear => 'Linear',
        NudgeThemePreset.nothing => 'Nothing',
        NudgeThemePreset.developer => 'Developer',
      };

  /// Brief description shown in settings.
  String get description => switch (this) {
        NudgeThemePreset.pure =>
          'Clean neutral defaults. Follows system light/dark.',
        NudgeThemePreset.purple => 'Accent-forward. Deep purple surface.',
        NudgeThemePreset.oled =>
          'True black. Maximum contrast for AMOLED displays.',
        NudgeThemePreset.terminal => 'Hacker green on near-black. Monospace.',
        NudgeThemePreset.paper => 'Warm off-white. Ink-on-paper feel.',
        NudgeThemePreset.linear => 'Precision dark. Inspired by Linear.',
        NudgeThemePreset.nothing => 'Monochrome minimal. Nothing OS inspired.',
        NudgeThemePreset.developer =>
          'Terminal palette with developer tooling visibility.',
      };

  /// Whether this preset defaults to a dark-mode color scheme.
  bool get isDark => switch (this) {
        NudgeThemePreset.pure => false,
        NudgeThemePreset.purple => true,
        NudgeThemePreset.oled => true,
        NudgeThemePreset.terminal => true,
        NudgeThemePreset.paper => false,
        NudgeThemePreset.linear => true,
        NudgeThemePreset.nothing => true,
        NudgeThemePreset.developer => true,
      };

  // ---------------------------------------------------------------------------
  // Factory — build NudgeThemeData
  // ---------------------------------------------------------------------------

  /// Builds the [NudgeThemeData] for this preset.
  ///
  /// [systemBrightness] is used only by [NudgeThemePreset.pure] which tracks
  /// the OS light/dark setting.
  NudgeThemeData build({Brightness systemBrightness = Brightness.light}) {
    final colors = _resolveColors(systemBrightness);
    final motion = _resolveMotion();
    final type = _resolveTypeScale();

    return NudgeThemeData(
      colors: colors,
      semanticColors: const NudgeSemanticColors(),
      type: type,
      motion: motion,
      icons: const MaterialIconResolver(),
      themeMode: _resolveThemeMode(systemBrightness),
      presetLabel: label,
    );
  }

  NudgeColorScheme _resolveColors(Brightness systemBrightness) =>
      switch (this) {
        NudgeThemePreset.pure => systemBrightness == Brightness.dark
            ? NudgeColorScheme.dark
            : NudgeColorScheme.light,
        NudgeThemePreset.purple => NudgeColorScheme.purple,
        NudgeThemePreset.oled => NudgeColorScheme.oled,
        NudgeThemePreset.terminal => NudgeColorScheme.terminal,
        NudgeThemePreset.paper => NudgeColorScheme.paper,
        NudgeThemePreset.linear => NudgeColorScheme.linear,
        NudgeThemePreset.nothing => NudgeColorScheme.nothing,
        NudgeThemePreset.developer => NudgeColorScheme.developer,
      };

  NudgeMotion _resolveMotion() => switch (this) {
        NudgeThemePreset.terminal => NudgeMotion.none,
        NudgeThemePreset.developer => NudgeMotion.none,
        NudgeThemePreset.linear => NudgeMotion.smooth,
        _ => NudgeMotion.calm,
      };

  NudgeTypeScale _resolveTypeScale() => switch (this) {
        NudgeThemePreset.terminal =>
          NudgeTypeScale.defaults(fontFamily: 'monospace'),
        NudgeThemePreset.developer =>
          NudgeTypeScale.defaults(fontFamily: 'monospace'),
        _ => NudgeTypeScale.defaults(),
      };

  NudgeThemeMode _resolveThemeMode(Brightness systemBrightness) =>
      switch (this) {
        NudgeThemePreset.pure => systemBrightness == Brightness.dark
            ? NudgeThemeMode.dark
            : NudgeThemeMode.light,
        NudgeThemePreset.oled => NudgeThemeMode.oled,
        _ => isDark ? NudgeThemeMode.dark : NudgeThemeMode.light,
      };
}

import 'package:flutter/widgets.dart';

import 'nudge_colors.dart';
import 'nudge_icons.dart';
import 'nudge_motion.dart';
import 'nudge_semantic_colors.dart';
import 'nudge_theme.dart';
import 'nudge_typography.dart';
import 'nudge_layout.dart';
import 'nudge_clock.dart';
import '../../features/customization/domain/models/theme_config.dart';

/// Supported built-in theme presets.
enum NudgeThemePreset {
  pure,
  purple,
  oled,
  terminal,
  paper,
  linear,
  nothing,
  developer;

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

  String get description => switch (this) {
        NudgeThemePreset.pure => 'Clean neutral defaults. Follows system light/dark.',
        NudgeThemePreset.purple => 'Accent-forward. Deep purple surface.',
        NudgeThemePreset.oled => 'True black. Maximum contrast for AMOLED displays.',
        NudgeThemePreset.terminal => 'Hacker green on near-black. Monospace.',
        NudgeThemePreset.paper => 'Warm off-white. Ink-on-paper feel.',
        NudgeThemePreset.linear => 'Precision dark. Inspired by Linear.',
        NudgeThemePreset.nothing => 'Monochrome minimal. Nothing OS inspired.',
        NudgeThemePreset.developer => 'Monospace terminal layout with developer tooling colors.',
      };

  /// Builds a full [ThemeConfig] object for this preset.
  ThemeConfig toConfig() {
    final cfg = ThemeConfig()
      ..name = label
      ..isCustom = false;

    switch (this) {
      case NudgeThemePreset.pure:
        cfg.colorPreset = 'light';
        cfg.fontFamily = 'Inter';
        cfg.fontWeight = 400;
        cfg.motionMode = 'calm';
        break;

      case NudgeThemePreset.purple:
        cfg.colorPreset = 'custom';
        cfg.backgroundColorValue = 0xFF0F0B1E;
        cfg.primaryTextColorValue = 0xFFF5F5FF;
        cfg.secondaryTextColorValue = 0xFFB8AEFF;
        cfg.accentColorValue = 0xFF8B6CFF;
        cfg.fontFamily = 'Inter';
        cfg.fontWeight = 500;
        cfg.motionMode = 'calm';
        break;

      case NudgeThemePreset.oled:
        cfg.colorPreset = 'oled';
        cfg.fontFamily = 'Inter';
        cfg.fontWeight = 400;
        cfg.motionMode = 'calm';
        break;

      case NudgeThemePreset.terminal:
        cfg.colorPreset = 'custom';
        cfg.backgroundColorValue = 0xFF0D1117;
        cfg.primaryTextColorValue = 0xFFE6EDF3;
        cfg.secondaryTextColorValue = 0xFF8B949E;
        cfg.accentColorValue = 0xFF39FF88;
        cfg.fontFamily = 'JetBrainsMono';
        cfg.fontWeight = 400;
        cfg.motionMode = 'none';
        break;

      case NudgeThemePreset.paper:
        cfg.colorPreset = 'custom';
        cfg.backgroundColorValue = 0xFFFAFAF8;
        cfg.primaryTextColorValue = 0xFF222222;
        cfg.secondaryTextColorValue = 0xFF6B6B63;
        cfg.accentColorValue = 0xFF7C5CFC;
        cfg.fontFamily = 'IBMPlexSans';
        cfg.fontWeight = 400;
        cfg.motionMode = 'calm';
        break;

      case NudgeThemePreset.linear:
        cfg.colorPreset = 'custom';
        cfg.backgroundColorValue = 0xFF0F0F11;
        cfg.primaryTextColorValue = 0xFFF2F2F5;
        cfg.secondaryTextColorValue = 0xFF9898A6;
        cfg.accentColorValue = 0xFF7C5CFC;
        cfg.fontFamily = 'Inter';
        cfg.fontWeight = 400;
        cfg.motionMode = 'smooth';
        break;

      case NudgeThemePreset.nothing:
        cfg.colorPreset = 'custom';
        cfg.backgroundColorValue = 0xFF0A0A0A;
        cfg.primaryTextColorValue = 0xFFF0F0F0;
        cfg.secondaryTextColorValue = 0xFF888888;
        cfg.accentColorValue = 0xFFFFFFFF;
        cfg.fontFamily = 'Inter';
        cfg.fontWeight = 400;
        cfg.motionMode = 'calm';
        break;

      case NudgeThemePreset.developer:
        cfg.colorPreset = 'custom';
        cfg.backgroundColorValue = 0xFF0D1117;
        cfg.primaryTextColorValue = 0xFFE6EDF3;
        cfg.secondaryTextColorValue = 0xFF8B949E;
        cfg.accentColorValue = 0xFF39FF88;
        cfg.fontFamily = 'IBMPlexMono';
        cfg.fontWeight = 400;
        cfg.motionMode = 'none';
        break;
    }

    return cfg;
  }

  /// Builds a [NudgeThemeData] derived directly from this preset configuration.
  /// (Kept for backwards compatibility and test suites)
  NudgeThemeData build({Brightness systemBrightness = Brightness.light}) {
    final config = toConfig();
    if (this == NudgeThemePreset.pure && systemBrightness == Brightness.dark) {
      config.colorPreset = 'dark';
    }
    return buildThemeDataFromConfig(config, systemBrightness);
  }
}

/// Helper method to construct NudgeThemeData from a ThemeConfig object.
NudgeThemeData buildThemeDataFromConfig(ThemeConfig config, Brightness systemBrightness) {
  // 1. Resolve colors
  NudgeColorScheme colors;
  if (config.highContrast) {
    final isLight = config.colorPreset == 'light';
    colors = NudgeColorScheme(
      background: isLight ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
      surface: isLight ? const Color(0xFFF2F2F2) : const Color(0xFF141414),
      primaryText: isLight ? const Color(0xFF000000) : const Color(0xFFFFFFFF),
      secondaryText: isLight ? const Color(0xFF1A1A1A) : const Color(0xFFE6E6E6),
      mutedText: isLight ? const Color(0xFF333333) : const Color(0xFFCCCCCC),
      accent: isLight ? const Color(0xFF0000D0) : const Color(0xFFFFE600),
      accentLight: isLight ? const Color(0xFF3333FF) : const Color(0xFFFFFF66),
      accentDark: isLight ? const Color(0xFF000088) : const Color(0xFFB3A200),
      divider: isLight ? const Color(0xFF000000) : const Color(0xFFFFFFFF),
      brightness: isLight ? Brightness.light : Brightness.dark,
    );
  } else if (config.colorPreset == 'light') {
    colors = NudgeColorScheme.light;
  } else if (config.colorPreset == 'dark') {
    colors = NudgeColorScheme.dark;
  } else if (config.colorPreset == 'oled') {
    colors = NudgeColorScheme.oled;
  } else {
    // Custom colors (or dynamically overrides)
    colors = NudgeColorScheme.fromConfig(config);
  }

  // 2. Resolve typography
  final type = NudgeTypeScale.fromConfig(config);

  // 3. Resolve motion
  // Convert config.motionMode to NudgeMotionMode
  NudgeMotionMode motionMode = NudgeMotionMode.calm;
  if (config.reducedMotion || config.motionMode == 'none') {
    motionMode = NudgeMotionMode.none;
  } else if (config.motionMode == 'smooth') {
    motionMode = NudgeMotionMode.smooth;
  }

  NudgeMotion baseMotion = NudgeMotion.forMode(motionMode);
  // Apply speed scale
  final motion = NudgeMotion(
    mode: motionMode,
    fast: baseMotion.fast * config.animationSpeedScale,
    normal: baseMotion.normal * config.animationSpeedScale,
    slow: baseMotion.slow * config.animationSpeedScale,
    curve: baseMotion.curve,
    curveDecelerate: baseMotion.curveDecelerate,
    curveAccelerate: baseMotion.curveAccelerate,
  );

  // 4. Resolve icons
  final iconSettings = NudgeIconSettings.fromConfig(config);
  final icons = NudgeIconResolver.forSettings(iconSettings);

  // 5. Layout and Clock
  final layoutSettings = NudgeLayoutSettings.fromConfig(config);
  final clockSettings = NudgeClockSettings.fromConfig(config);

  // Theme mode mapping
  NudgeThemeMode tMode = NudgeThemeMode.dark;
  if (config.colorPreset == 'light') {
    tMode = NudgeThemeMode.light;
  } else if (config.colorPreset == 'oled') {
    tMode = NudgeThemeMode.oled;
  }

  return NudgeThemeData(
    colors: colors,
    semanticColors: const NudgeSemanticColors(),
    type: type,
    motion: motion,
    icons: icons,
    iconSettings: iconSettings,
    layoutSettings: layoutSettings,
    clockSettings: clockSettings,
    themeMode: tMode,
    presetLabel: config.name,
  );
}

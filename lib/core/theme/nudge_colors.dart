import 'package:flutter/widgets.dart';


/// Nudge Design System — Color Tokens
///
/// All UI colors must be sourced from these classes.
/// Never hardcode Color values inside widgets.

// ---------------------------------------------------------------------------
// Color scheme (per theme)
// ---------------------------------------------------------------------------

/// Immutable semantic color palette for one Nudge theme variant.
///
/// Widgets reference semantic names (e.g. [background], [accent]) rather than
/// raw hex values, so swapping themes only requires replacing this object.
final class NudgeColorScheme {
  const NudgeColorScheme({
    required this.background,
    required this.surface,
    required this.primaryText,
    required this.secondaryText,
    required this.mutedText,
    required this.accent,
    required this.accentLight,
    required this.accentDark,
    required this.divider,
    required this.brightness,
  });

  final Color background;
  final Color surface;
  final Color primaryText;
  final Color secondaryText;
  final Color mutedText;
  final Color accent;
  final Color accentLight;
  final Color accentDark;
  final Color divider;
  final Brightness brightness;

  // ---------------------------------------------------------------------------
  // Named palettes
  // ---------------------------------------------------------------------------

  /// Default light theme.
  static const NudgeColorScheme light = NudgeColorScheme(
    background: Color(0xFFFAFAFC),
    surface: Color(0xFFFFFFFF),
    primaryText: Color(0xFF17171C),
    secondaryText: Color(0xFF74747F),
    mutedText: Color(0xFFA1A1AA),
    accent: Color(0xFF7C5CFC),
    accentLight: Color(0xFFA78BFA),
    accentDark: Color(0xFF6241D8),
    divider: Color(0xFFE8E8ED),
    brightness: Brightness.light,
  );

  /// Default dark theme.
  static const NudgeColorScheme dark = NudgeColorScheme(
    background: Color(0xFF0B0B0F),
    surface: Color(0xFF141419),
    primaryText: Color(0xFFF5F5F7),
    secondaryText: Color(0xFFA1A1AA),
    mutedText: Color(0xFF71717A),
    accent: Color(0xFF8B6CFF),
    accentLight: Color(0xFFA78BFA),
    accentDark: Color(0xFF6241D8),
    divider: Color(0xFF24242A),
    brightness: Brightness.dark,
  );

  /// OLED — true black for AMOLED displays.
  static const NudgeColorScheme oled = NudgeColorScheme(
    background: Color(0xFF000000),
    surface: Color(0xFF080808),
    primaryText: Color(0xFFFFFFFF),
    secondaryText: Color(0xFFA1A1AA),
    mutedText: Color(0xFF71717A),
    accent: Color(0xFFA78BFA),
    accentLight: Color(0xFFC4B5FD),
    accentDark: Color(0xFF6241D8),
    divider: Color(0xFF1A1A1A),
    brightness: Brightness.dark,
  );

  /// Terminal — hacker-green on near-black.
  static const NudgeColorScheme terminal = NudgeColorScheme(
    background: Color(0xFF0D1117),
    surface: Color(0xFF161B22),
    primaryText: Color(0xFFE6EDF3),
    secondaryText: Color(0xFF8B949E),
    mutedText: Color(0xFF6E7681),
    accent: Color(0xFF39FF88),
    accentLight: Color(0xFF7CFFC4),
    accentDark: Color(0xFF00D966),
    divider: Color(0xFF30363D),
    brightness: Brightness.dark,
  );

  /// Paper — warm, ink-on-paper feel.
  static const NudgeColorScheme paper = NudgeColorScheme(
    background: Color(0xFFFAFAF8),
    surface: Color(0xFFFFFFFF),
    primaryText: Color(0xFF222222),
    secondaryText: Color(0xFF6B6B63),
    mutedText: Color(0xFF999990),
    accent: Color(0xFF7C5CFC),
    accentLight: Color(0xFFA78BFA),
    accentDark: Color(0xFF6241D8),
    divider: Color(0xFFE8E6DF),
    brightness: Brightness.light,
  );

  /// Purple-forward — accent-tinted surface for a bold, branded feel.
  static const NudgeColorScheme purple = NudgeColorScheme(
    background: Color(0xFF0F0B1E),
    surface: Color(0xFF1A1430),
    primaryText: Color(0xFFF5F5FF),
    secondaryText: Color(0xFFB8AEFF),
    mutedText: Color(0xFF7B6FCC),
    accent: Color(0xFF8B6CFF),
    accentLight: Color(0xFFA78BFA),
    accentDark: Color(0xFF6241D8),
    divider: Color(0xFF2E2450),
    brightness: Brightness.dark,
  );

  /// Linear-inspired — clean dark, precise and fast-feeling.
  static const NudgeColorScheme linear = NudgeColorScheme(
    background: Color(0xFF0F0F11),
    surface: Color(0xFF18181C),
    primaryText: Color(0xFFF2F2F5),
    secondaryText: Color(0xFF9898A6),
    mutedText: Color(0xFF606070),
    accent: Color(0xFF7C5CFC),
    accentLight: Color(0xFFA78BFA),
    accentDark: Color(0xFF5C42D8),
    divider: Color(0xFF222228),
    brightness: Brightness.dark,
  );

  /// Nothing OS-inspired — monochrome, raw, minimal.
  static const NudgeColorScheme nothing = NudgeColorScheme(
    background: Color(0xFF0A0A0A),
    surface: Color(0xFF111111),
    primaryText: Color(0xFFF0F0F0),
    secondaryText: Color(0xFF888888),
    mutedText: Color(0xFF555555),
    accent: Color(0xFFFFFFFF),
    accentLight: Color(0xFFCCCCCC),
    accentDark: Color(0xFF999999),
    divider: Color(0xFF222222),
    brightness: Brightness.dark,
  );

  /// Developer — terminal palette with extra debug-border-visible density.
  static const NudgeColorScheme developer = NudgeColorScheme(
    background: Color(0xFF0D1117),
    surface: Color(0xFF161B22),
    primaryText: Color(0xFFE6EDF3),
    secondaryText: Color(0xFF8B949E),
    mutedText: Color(0xFF6E7681),
    accent: Color(0xFF39FF88),
    accentLight: Color(0xFF7CFFC4),
    accentDark: Color(0xFF00D966),
    divider: Color(0xFF30363D),
    brightness: Brightness.dark,
  );

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Returns a copy of this scheme with individual fields overridden.
  NudgeColorScheme copyWith({
    Color? background,
    Color? surface,
    Color? primaryText,
    Color? secondaryText,
    Color? mutedText,
    Color? accent,
    Color? accentLight,
    Color? accentDark,
    Color? divider,
    Brightness? brightness,
  }) {
    return NudgeColorScheme(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      mutedText: mutedText ?? this.mutedText,
      accent: accent ?? this.accent,
      accentLight: accentLight ?? this.accentLight,
      accentDark: accentDark ?? this.accentDark,
      divider: divider ?? this.divider,
      brightness: brightness ?? this.brightness,
    );
  }
}

// Note: NudgeSemanticColors is defined in theme_presets.dart as an
// instantiable class that can be held in NudgeThemeData.
// Access its values via: context.nudgeTheme.semanticColors.success

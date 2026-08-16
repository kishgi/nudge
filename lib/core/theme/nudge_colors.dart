import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import '../../features/customization/domain/models/theme_config.dart';

/// Immutable semantic color palette for one Nudge theme variant.
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
  // Dynamic Factory from Config
  // ---------------------------------------------------------------------------

  factory NudgeColorScheme.fromConfig(ThemeConfig config) {
    if (config.colorPreset != 'custom') {
      return switch (config.colorPreset) {
        'light' => NudgeColorScheme.light,
        'oled' => NudgeColorScheme.oled,
        _ => NudgeColorScheme.dark,
      };
    }

    // Custom color configuration
    final bg = Color(config.backgroundColorValue ?? 0xFF0B0B0F);
    final rawPrimary = Color(config.primaryTextColorValue ?? 0xFFF5F5F7);
    final rawSecondary = Color(config.secondaryTextColorValue ?? 0xFFA1A1AA);
    final rawAccent = Color(config.accentColorValue ?? 0xFF8B6CFF);

    // Apply safe contrast to ensure readability (minimum WCAG 4.5:1 ratio)
    final primary = safeContrast(bg, rawPrimary);
    final secondary = safeContrast(bg, rawSecondary);
    final accent = safeContrast(bg, rawAccent);

    // Determine brightness based on background luminance
    final isDark = bg.computeLuminance() < 0.5;
    final brightness = isDark ? Brightness.dark : Brightness.light;

    // Construct secondary colors
    final surface = isDark 
        ? Color.alphaBlend(primary.withValues(alpha: 0.05), bg) 
        : Color.alphaBlend(primary.withValues(alpha: 0.03), bg);

    final mutedText = isDark 
        ? Color.alphaBlend(primary.withValues(alpha: 0.3), bg) 
        : Color.alphaBlend(primary.withValues(alpha: 0.25), bg);

    final divider = isDark
        ? Color.alphaBlend(primary.withValues(alpha: 0.1), bg)
        : Color.alphaBlend(primary.withValues(alpha: 0.08), bg);

    return NudgeColorScheme(
      background: bg,
      surface: surface,
      primaryText: primary,
      secondaryText: secondary,
      mutedText: mutedText,
      accent: accent,
      accentLight: accent.withValues(alpha: 0.8),
      accentDark: accent.withValues(alpha: 1.2),
      divider: divider,
      brightness: brightness,
    );
  }

  // ---------------------------------------------------------------------------
  // Contrast helpers
  // ---------------------------------------------------------------------------

  /// Calculates the relative luminance of a color according to WCAG 2.0.
  static double relativeLuminance(Color color) {
    double r = color.r;
    double g = color.g;
    double b = color.b;

    r = (r <= 0.04045) ? r / 12.92 : math.pow((r + 0.055) / 1.055, 2.4).toDouble();
    g = (g <= 0.04045) ? g / 12.92 : math.pow((g + 0.055) / 1.055, 2.4).toDouble();
    b = (b <= 0.04045) ? b / 12.92 : math.pow((b + 0.055) / 1.055, 2.4).toDouble();

    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  /// Calculates the contrast ratio between two colors (range: 1.0 to 21.0).
  static double contrastRatio(Color a, Color b) {
    final l1 = relativeLuminance(a);
    final l2 = relativeLuminance(b);
    final brightest = math.max(l1, l2);
    final darkest = math.min(l1, l2);
    return (brightest + 0.05) / (darkest + 0.05);
  }

  /// Automatically adjusts [requestedColor] to ensure a readable contrast ratio (at least 4.5:1)
  /// against [background].
  static Color safeContrast(Color background, Color requestedColor) {
    final double currentRatio = contrastRatio(background, requestedColor);
    if (currentRatio >= 4.5) {
      return requestedColor;
    }

    final double bgLuminance = relativeLuminance(background);
    final bool backgroundIsDark = bgLuminance < 0.5;

    // Shift color towards black or white until contrast is sufficient
    Color adjusted = requestedColor;
    double step = 0.05;
    double progress = 0.0;

    while (contrastRatio(background, adjusted) < 4.5 && progress <= 1.0) {
      if (backgroundIsDark) {
        // Background is dark: shift target color closer to white
        adjusted = Color.lerp(requestedColor, const Color(0xFFFFFFFF), progress)!;
      } else {
        // Background is light: shift target color closer to black
        adjusted = Color.lerp(requestedColor, const Color(0xFF000000), progress)!;
      }
      progress += step;
    }

    return adjusted;
  }

  // ---------------------------------------------------------------------------
  // Named palettes
  // ---------------------------------------------------------------------------

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

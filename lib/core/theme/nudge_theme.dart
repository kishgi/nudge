import 'package:flutter/widgets.dart';

import 'nudge_colors.dart';
import 'nudge_icons.dart';
import 'nudge_motion.dart';
import 'nudge_semantic_colors.dart';
import 'nudge_typography.dart';

/// Nudge Design System — Core Theme Data & Inherited Widget
///
/// [NudgeThemeData] is the single aggregate that carries every design token
/// for one theme configuration. Widgets access it via [NudgeTheme.of(context)]
/// or the [BuildContext.nudgeTheme] extension — never through hardcoded values.

// ---------------------------------------------------------------------------
// Theme mode
// ---------------------------------------------------------------------------

/// Controls whether the app follows light, dark, OLED, or the system setting.
enum NudgeThemeMode {
  light,
  dark,
  system,
  oled;

  String get label => switch (this) {
        NudgeThemeMode.light => 'Light',
        NudgeThemeMode.dark => 'Dark',
        NudgeThemeMode.system => 'System',
        NudgeThemeMode.oled => 'OLED',
      };
}

// ---------------------------------------------------------------------------
// NudgeThemeData
// ---------------------------------------------------------------------------

/// Immutable aggregate of all design tokens for the active Nudge theme.
///
/// Access convenience getters directly on the theme data:
/// ```dart
/// final t = context.nudgeTheme;
/// Container(color: t.background);
/// Text('Hi', style: t.type.headline.copyWith(color: t.primaryText));
/// ```
final class NudgeThemeData {
  const NudgeThemeData({
    required this.colors,
    required this.semanticColors,
    required this.type,
    required this.motion,
    required this.icons,
    required this.themeMode,
    required this.presetLabel,
  });

  final NudgeColorScheme colors;
  final NudgeSemanticColors semanticColors;
  final NudgeTypeScale type;
  final NudgeMotion motion;
  final NudgeIconResolver icons;
  final NudgeThemeMode themeMode;

  /// Human-readable label for the active preset (e.g. "OLED", "Terminal").
  final String presetLabel;

  // ---------------------------------------------------------------------------
  // Color convenience accessors
  // Widgets use `t.background`, `t.accent`, etc. — never raw Color() literals.
  // ---------------------------------------------------------------------------

  Color get background => colors.background;
  Color get surface => colors.surface;
  Color get primaryText => colors.primaryText;
  Color get secondaryText => colors.secondaryText;
  Color get mutedText => colors.mutedText;
  Color get accent => colors.accent;
  Color get accentLight => colors.accentLight;
  Color get accentDark => colors.accentDark;
  Color get divider => colors.divider;
  Brightness get brightness => colors.brightness;

  bool get isDark => brightness == Brightness.dark;

  // ---------------------------------------------------------------------------
  // copyWith
  // ---------------------------------------------------------------------------

  NudgeThemeData copyWith({
    NudgeColorScheme? colors,
    NudgeSemanticColors? semanticColors,
    NudgeTypeScale? type,
    NudgeMotion? motion,
    NudgeIconResolver? icons,
    NudgeThemeMode? themeMode,
    String? presetLabel,
  }) {
    return NudgeThemeData(
      colors: colors ?? this.colors,
      semanticColors: semanticColors ?? this.semanticColors,
      type: type ?? this.type,
      motion: motion ?? this.motion,
      icons: icons ?? this.icons,
      themeMode: themeMode ?? this.themeMode,
      presetLabel: presetLabel ?? this.presetLabel,
    );
  }
}

// ---------------------------------------------------------------------------
// NudgeTheme inherited widget
// ---------------------------------------------------------------------------

/// Inherited widget that exposes [NudgeThemeData] to the widget tree.
///
/// Place this as an ancestor of [MaterialApp] or within the widget tree where
/// theme access is needed.
class NudgeTheme extends InheritedWidget {
  const NudgeTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final NudgeThemeData data;

  /// Returns the [NudgeThemeData] from the nearest [NudgeTheme] ancestor.
  ///
  /// Throws a [FlutterError] if no [NudgeTheme] is found.
  static NudgeThemeData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<NudgeTheme>();
    assert(
      widget != null,
      'No NudgeTheme found in context. '
      'Ensure NudgeTheme is an ancestor of this widget.',
    );
    return widget!.data;
  }

  /// Returns the [NudgeThemeData] or null if no [NudgeTheme] ancestor exists.
  static NudgeThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NudgeTheme>()?.data;
  }

  @override
  bool updateShouldNotify(NudgeTheme oldWidget) => data != oldWidget.data;
}

// ---------------------------------------------------------------------------
// BuildContext extension
// ---------------------------------------------------------------------------

/// Convenient access to [NudgeThemeData] from any [BuildContext].
///
/// ```dart
/// final t = context.nudgeTheme;
/// ```
extension NudgeThemeContext on BuildContext {
  NudgeThemeData get nudgeTheme => NudgeTheme.of(this);
}

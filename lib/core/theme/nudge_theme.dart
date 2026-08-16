import 'package:flutter/widgets.dart';

import 'nudge_colors.dart';
import 'nudge_icons.dart';
import 'nudge_motion.dart';
import 'nudge_semantic_colors.dart';
import 'nudge_typography.dart';
import 'nudge_layout.dart';
import 'nudge_clock.dart';

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

/// Immutable aggregate of all design tokens for the active Nudge theme.
final class NudgeThemeData {
  const NudgeThemeData({
    required this.colors,
    required this.semanticColors,
    required this.type,
    required this.motion,
    required this.icons,
    required this.iconSettings,
    required this.layoutSettings,
    required this.clockSettings,
    required this.themeMode,
    required this.presetLabel,
  });

  final NudgeColorScheme colors;
  final NudgeSemanticColors semanticColors;
  final NudgeTypeScale type;
  final NudgeMotion motion;
  final NudgeIconResolver icons;
  final NudgeIconSettings iconSettings;
  final NudgeLayoutSettings layoutSettings;
  final NudgeClockSettings clockSettings;
  final NudgeThemeMode themeMode;

  /// Human-readable label for the active preset (e.g. "OLED", "Terminal").
  final String presetLabel;

  // ---------------------------------------------------------------------------
  // Color convenience accessors
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
    NudgeIconSettings? iconSettings,
    NudgeLayoutSettings? layoutSettings,
    NudgeClockSettings? clockSettings,
    NudgeThemeMode? themeMode,
    String? presetLabel,
  }) {
    return NudgeThemeData(
      colors: colors ?? this.colors,
      semanticColors: semanticColors ?? this.semanticColors,
      type: type ?? this.type,
      motion: motion ?? this.motion,
      icons: icons ?? this.icons,
      iconSettings: iconSettings ?? this.iconSettings,
      layoutSettings: layoutSettings ?? this.layoutSettings,
      clockSettings: clockSettings ?? this.clockSettings,
      themeMode: themeMode ?? this.themeMode,
      presetLabel: presetLabel ?? this.presetLabel,
    );
  }
}

/// Inherited widget that exposes [NudgeThemeData] to the widget tree.
class NudgeTheme extends InheritedWidget {
  const NudgeTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final NudgeThemeData data;

  static NudgeThemeData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<NudgeTheme>();
    assert(
      widget != null,
      'No NudgeTheme found in context. '
      'Ensure NudgeTheme is an ancestor of this widget.',
    );
    return widget!.data;
  }

  static NudgeThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NudgeTheme>()?.data;
  }

  @override
  bool updateShouldNotify(NudgeTheme oldWidget) => data != oldWidget.data;
}

extension NudgeThemeContext on BuildContext {
  NudgeThemeData get nudgeTheme => NudgeTheme.of(this);
}

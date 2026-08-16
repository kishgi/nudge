import 'package:flutter/widgets.dart';
import '../../features/customization/domain/models/theme_config.dart';

/// Holds all clock-related styling settings.
class NudgeClockSettings {
  const NudgeClockSettings({
    required this.clockFormat, // '12' or '24'
    required this.showSeconds,
    required this.clockSizeScale,
    required this.clockFontFamily,
    required this.clockFontWeight,
    required this.alignment,
    required this.showDate,
    required this.dateFormat,
  });

  final String clockFormat;
  final bool showSeconds;
  final double clockSizeScale;
  final String? clockFontFamily;
  final int? clockFontWeight;
  final AlignmentGeometry alignment;
  final bool showDate;
  final String dateFormat;

  factory NudgeClockSettings.fromConfig(ThemeConfig config) {
    AlignmentGeometry align = Alignment.centerLeft;
    if (config.clockAlignment == 'center') {
      align = Alignment.center;
    } else if (config.clockAlignment == 'right') {
      align = Alignment.centerRight;
    }

    return NudgeClockSettings(
      clockFormat: config.clockFormat,
      showSeconds: config.showSeconds,
      clockSizeScale: config.clockSizeScale,
      clockFontFamily: config.clockFontFamily,
      clockFontWeight: config.clockFontWeight,
      alignment: align,
      showDate: config.showDate,
      dateFormat: config.dateFormat,
    );
  }

  NudgeClockSettings copyWith({
    String? clockFormat,
    bool? showSeconds,
    double? clockSizeScale,
    String? clockFontFamily,
    int? clockFontWeight,
    AlignmentGeometry? alignment,
    bool? showDate,
    String? dateFormat,
  }) {
    return NudgeClockSettings(
      clockFormat: clockFormat ?? this.clockFormat,
      showSeconds: showSeconds ?? this.showSeconds,
      clockSizeScale: clockSizeScale ?? this.clockSizeScale,
      clockFontFamily: clockFontFamily ?? this.clockFontFamily,
      clockFontWeight: clockFontWeight ?? this.clockFontWeight,
      alignment: alignment ?? this.alignment,
      showDate: showDate ?? this.showDate,
      dateFormat: dateFormat ?? this.dateFormat,
    );
  }
}

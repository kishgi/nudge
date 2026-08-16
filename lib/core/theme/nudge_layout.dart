import 'package:flutter/widgets.dart';
import '../../features/customization/domain/models/theme_config.dart';

/// App list density.
enum NudgeAppDensity {
  compact,
  normal,
  comfortable;

  static NudgeAppDensity parse(String value) {
    return NudgeAppDensity.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => NudgeAppDensity.normal,
    );
  }

  double get itemSpacing => switch (this) {
        NudgeAppDensity.compact => 4.0,
        NudgeAppDensity.normal => 8.0,
        NudgeAppDensity.comfortable => 14.0,
      };

  double get verticalPadding => switch (this) {
        NudgeAppDensity.compact => 6.0,
        NudgeAppDensity.normal => 10.0,
        NudgeAppDensity.comfortable => 16.0,
      };
}

/// Holds all layout-related tokens/settings for the active theme.
class NudgeLayoutSettings {
  const NudgeLayoutSettings({
    required this.horizontalPadding,
    required this.verticalSpacing,
    required this.density,
    required this.alignment,
    required this.visibleAppCount,
    required this.showIcons,
    required this.clockPosition,
  });

  final double horizontalPadding;
  final double verticalSpacing;
  final NudgeAppDensity density;
  final AlignmentGeometry alignment;
  final int visibleAppCount;
  final bool showIcons;
  final String clockPosition; // 'top', 'bottom', 'hidden'

  factory NudgeLayoutSettings.fromConfig(ThemeConfig config) {
    // Parse alignment
    AlignmentGeometry align = Alignment.centerLeft;
    if (config.appAlignment == 'center') {
      align = Alignment.center;
    } else if (config.appAlignment == 'right') {
      align = Alignment.centerRight;
    }

    return NudgeLayoutSettings(
      horizontalPadding: config.horizontalPadding,
      verticalSpacing: config.verticalSpacing,
      density: NudgeAppDensity.parse(config.appDensity),
      alignment: align,
      visibleAppCount: config.visibleAppCount,
      showIcons: config.showIcons,
      clockPosition: config.clockPosition,
    );
  }

  NudgeLayoutSettings copyWith({
    double? horizontalPadding,
    double? verticalSpacing,
    NudgeAppDensity? density,
    AlignmentGeometry? alignment,
    int? visibleAppCount,
    bool? showIcons,
    String? clockPosition,
  }) {
    return NudgeLayoutSettings(
      horizontalPadding: horizontalPadding ?? this.horizontalPadding,
      verticalSpacing: verticalSpacing ?? this.verticalSpacing,
      density: density ?? this.density,
      alignment: alignment ?? this.alignment,
      visibleAppCount: visibleAppCount ?? this.visibleAppCount,
      showIcons: showIcons ?? this.showIcons,
      clockPosition: clockPosition ?? this.clockPosition,
    );
  }
}

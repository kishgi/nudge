import 'package:flutter/painting.dart';

/// Nudge Design System — Semantic Status Colors
///
/// App-wide status colors. These do not change with the active theme preset.
/// Accessible contrast is maintained against both light and dark backgrounds.
///
/// Access via [context.nudgeTheme.semanticColors.*] — never hardcode these hex
/// values in widgets.
final class NudgeSemanticColors {
  const NudgeSemanticColors();

  Color get success => _values.success;
  Color get warning => _values.warning;
  Color get error => _values.error;
  Color get info => _values.info;

  // Subtle 10%-opacity fills for status-indicator backgrounds.
  Color get successSubtle => _values.successSubtle;
  Color get warningSubtle => _values.warningSubtle;
  Color get errorSubtle => _values.errorSubtle;
  Color get infoSubtle => _values.infoSubtle;

  static const _values = _SemanticValues();
}

/// Private const holder for the actual values.
final class _SemanticValues {
  const _SemanticValues();

  Color get success => const Color(0xFF34C759);
  Color get warning => const Color(0xFFF59E0B);
  Color get error => const Color(0xFFEF4444);
  Color get info => const Color(0xFF3B82F6);

  Color get successSubtle => const Color(0x1A34C759);
  Color get warningSubtle => const Color(0x1AF59E0B);
  Color get errorSubtle => const Color(0x1AEF4444);
  Color get infoSubtle => const Color(0x1A3B82F6);
}

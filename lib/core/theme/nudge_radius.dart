import 'package:flutter/painting.dart';

/// Nudge Design System — Border Radius Tokens
///
/// Nudge is intentionally flat and minimal. Do not add new radius values
/// without a clear design rationale.
abstract final class NudgeRadius {
  NudgeRadius._();

  /// 4 dp — very tight, e.g. badges
  static const double xs = 4;

  /// 8 dp — small: chips, tags, compact inputs
  static const double small = 8;

  /// 12 dp — medium: cards, sheets
  static const double medium = 12;

  /// 16 dp — large: modal bottom sheets, prominent cards
  static const double large = 16;

  /// 24 dp — xl: floating panels, pill buttons
  static const double xl = 24;

  /// Fully circular — icon buttons, avatars
  static const double full = 999;

  // ---------------------------------------------------------------------------
  // BorderRadius convenience getters
  // ---------------------------------------------------------------------------

  static BorderRadius get xsAll => BorderRadius.circular(xs);
  static BorderRadius get smallAll => BorderRadius.circular(small);
  static BorderRadius get mediumAll => BorderRadius.circular(medium);
  static BorderRadius get largeAll => BorderRadius.circular(large);
  static BorderRadius get xlAll => BorderRadius.circular(xl);
  static BorderRadius get fullAll => BorderRadius.circular(full);
}

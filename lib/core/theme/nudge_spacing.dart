/// Nudge Design System — Spacing Tokens
///
/// All spacing values in the app must be sourced from [NudgeSpacing].
/// Never hardcode numeric padding/margin values inside widgets.
abstract final class NudgeSpacing {
  NudgeSpacing._();

  /// 4 dp — micro gaps, icon padding
  static const double xs = 4;

  /// 8 dp — tight spacing, chip gaps
  static const double sm = 8;

  /// 12 dp — compact rows
  static const double md = 12;

  /// 16 dp — standard content padding
  static const double lg = 16;

  /// 24 dp — section spacing
  static const double xl = 24;

  /// 32 dp — large gaps between blocks
  static const double xxl = 32;

  /// 48 dp — hero/page-level breathing room
  static const double huge = 48;

  // ---------------------------------------------------------------------------
  // Convenience multiples
  // ---------------------------------------------------------------------------

  /// Half of [xs] — use sparingly
  static const double xxs = 2;

  /// Page edge inset (horizontal)
  static const double pageHorizontal = lg;

  /// Page edge inset (vertical)
  static const double pageVertical = xl;
}

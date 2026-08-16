import 'package:flutter/painting.dart';

/// Nudge Design System — Typography Tokens
///
/// All text styles in the app must be sourced from a [NudgeTypeScale] instance.
/// Never hardcode font sizes, weights, or letter spacing inside widgets.
///
/// The font family is a parameter so it can be swapped dynamically later
/// without touching individual widgets.

// ---------------------------------------------------------------------------
// Type scale definition
// ---------------------------------------------------------------------------

/// Immutable type scale — maps semantic roles to fully configured [TextStyle]s.
final class NudgeTypeScale {
  const NudgeTypeScale({
    required this.display,
    required this.headline,
    required this.title,
    required this.body,
    required this.label,
    required this.caption,
    required this.fontFamily,
  });

  // Semantic type roles
  final TextStyle display;
  final TextStyle headline;
  final TextStyle title;
  final TextStyle body;
  final TextStyle label;
  final TextStyle caption;

  /// The font family used by all styles in this scale.
  final String fontFamily;

  // ---------------------------------------------------------------------------
  // Default scale (Inter)
  // ---------------------------------------------------------------------------

  /// Constructs the standard Nudge type scale.
  ///
  /// Override [fontFamily] to swap the typeface globally (e.g. JetBrains Mono
  /// for the Terminal theme).
  factory NudgeTypeScale.defaults({String fontFamily = 'Inter'}) {
    return NudgeTypeScale(
      fontFamily: fontFamily,

      // display — large hero text, onboarding, big numbers
      display: TextStyle(
        fontFamily: fontFamily,
        fontSize: 48,
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: -1.5,
        leadingDistribution: TextLeadingDistribution.even,
      ),

      // headline — screen titles, section headers
      headline: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: -0.5,
        leadingDistribution: TextLeadingDistribution.even,
      ),

      // title — card titles, list headings
      title: TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.3,
        letterSpacing: -0.2,
        leadingDistribution: TextLeadingDistribution.even,
      ),

      // body — primary reading text
      body: TextStyle(
        fontFamily: fontFamily,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.55,
        letterSpacing: 0.1,
        leadingDistribution: TextLeadingDistribution.even,
      ),

      // label — UI labels, buttons, chips
      label: TextStyle(
        fontFamily: fontFamily,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.1,
        leadingDistribution: TextLeadingDistribution.even,
      ),

      // caption — timestamps, metadata, fine print
      caption: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.2,
        leadingDistribution: TextLeadingDistribution.even,
      ),
    );
  }

  /// Mono scale — for Terminal / Developer themes.
  factory NudgeTypeScale.mono({String fontFamily = 'monospace'}) {
    return NudgeTypeScale.defaults(fontFamily: fontFamily);
  }

  // ---------------------------------------------------------------------------
  // Utility
  // ---------------------------------------------------------------------------

  /// Returns a copy with a different font family applied to all styles.
  NudgeTypeScale withFontFamily(String newFamily) {
    TextStyle swap(TextStyle s) => s.copyWith(fontFamily: newFamily);
    return NudgeTypeScale(
      fontFamily: newFamily,
      display: swap(display),
      headline: swap(headline),
      title: swap(title),
      body: swap(body),
      label: swap(label),
      caption: swap(caption),
    );
  }
}

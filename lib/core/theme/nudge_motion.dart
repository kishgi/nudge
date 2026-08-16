import 'package:flutter/animation.dart';

/// Nudge Design System — Motion Tokens
///
/// Centralises all animation durations and curves.
/// Widgets must never hardcode Duration or Curve values.
///
/// Three motion modes are supported:
/// - [NudgeMotionMode.none]   — no animations (accessibility / reduced motion)
/// - [NudgeMotionMode.calm]   — subtle, fast, minimal (default)
/// - [NudgeMotionMode.smooth] — slightly richer easing (Linear/productivity feel)

enum NudgeMotionMode {
  none,
  calm,
  smooth;

  /// Human-readable label for display in settings UI.
  String get label => switch (this) {
        NudgeMotionMode.none => 'None',
        NudgeMotionMode.calm => 'Calm',
        NudgeMotionMode.smooth => 'Smooth',
      };
}

/// Immutable set of animation parameters for a given [NudgeMotionMode].
final class NudgeMotion {
  const NudgeMotion({
    required this.mode,
    required this.fast,
    required this.normal,
    required this.slow,
    required this.curve,
    required this.curveDecelerate,
    required this.curveAccelerate,
  });

  final NudgeMotionMode mode;

  // Durations
  final Duration fast;
  final Duration normal;
  final Duration slow;

  // Curves
  final Curve curve;
  final Curve curveDecelerate;
  final Curve curveAccelerate;

  /// Returns an instant (zero-duration) motion for [NudgeMotionMode.none].
  static const NudgeMotion none = NudgeMotion(
    mode: NudgeMotionMode.none,
    fast: Duration.zero,
    normal: Duration.zero,
    slow: Duration.zero,
    curve: Curves.linear,
    curveDecelerate: Curves.linear,
    curveAccelerate: Curves.linear,
  );

  /// Default calm motion — fast, subtle transitions.
  static const NudgeMotion calm = NudgeMotion(
    mode: NudgeMotionMode.calm,
    fast: Duration(milliseconds: 120),
    normal: Duration(milliseconds: 200),
    slow: Duration(milliseconds: 300),
    curve: Curves.easeOut,
    curveDecelerate: Curves.decelerate,
    curveAccelerate: Curves.easeIn,
  );

  /// Smooth motion — slightly longer, richer easing.
  static const NudgeMotion smooth = NudgeMotion(
    mode: NudgeMotionMode.smooth,
    fast: Duration(milliseconds: 150),
    normal: Duration(milliseconds: 250),
    slow: Duration(milliseconds: 400),
    curve: Curves.easeInOutCubic,
    curveDecelerate: Curves.easeOutCubic,
    curveAccelerate: Curves.easeInCubic,
  );

  /// Returns the appropriate [NudgeMotion] for the given [mode].
  static NudgeMotion forMode(NudgeMotionMode mode) => switch (mode) {
        NudgeMotionMode.none => NudgeMotion.none,
        NudgeMotionMode.calm => NudgeMotion.calm,
        NudgeMotionMode.smooth => NudgeMotion.smooth,
      };
}

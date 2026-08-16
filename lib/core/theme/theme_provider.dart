import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'nudge_theme.dart';
import 'theme_presets.dart';

/// Nudge Design System — Theme Provider (Riverpod v3)
///
/// Uses [Notifier] + [NotifierProvider] to hold and expose the active
/// [NudgeThemeData]. Theme switching is a single [setPreset] call.

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

final class NudgeThemeState {
  const NudgeThemeState({
    required this.preset,
    required this.systemBrightness,
  });

  final NudgeThemePreset preset;
  final Brightness systemBrightness;

  NudgeThemeData get themeData =>
      preset.build(systemBrightness: systemBrightness);

  NudgeThemeState copyWith({
    NudgeThemePreset? preset,
    Brightness? systemBrightness,
  }) {
    return NudgeThemeState(
      preset: preset ?? this.preset,
      systemBrightness: systemBrightness ?? this.systemBrightness,
    );
  }
}

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------

final class NudgeThemeNotifier extends Notifier<NudgeThemeState> {
  @override
  NudgeThemeState build() {
    final brightness = ui.PlatformDispatcher.instance.platformBrightness;
    return NudgeThemeState(
      preset: NudgeThemePreset.pure,
      systemBrightness: brightness,
    );
  }

  /// Switch to the given [preset].
  void setPreset(NudgeThemePreset preset) {
    state = state.copyWith(preset: preset);
  }

  /// Update the system brightness (call from [WidgetsBindingObserver]).
  void setSystemBrightness(Brightness brightness) {
    state = state.copyWith(systemBrightness: brightness);
  }
}

// ---------------------------------------------------------------------------
// Providers
// ---------------------------------------------------------------------------

/// The top-level theme provider. Exposes [NudgeThemeState].
final nudgeThemeProvider =
    NotifierProvider<NudgeThemeNotifier, NudgeThemeState>(
  NudgeThemeNotifier.new,
);

/// Convenience provider that directly exposes the active [NudgeThemeData].
final nudgeThemeDataProvider = Provider<NudgeThemeData>((ref) {
  return ref.watch(nudgeThemeProvider).themeData;
});

/// Convenience provider for the active [NudgeThemePreset].
final nudgeThemePresetProvider = Provider<NudgeThemePreset>((ref) {
  return ref.watch(nudgeThemeProvider).preset;
});

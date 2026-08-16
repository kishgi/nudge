import 'package:flutter/material.dart';

import 'nudge_theme.dart';
import 'nudge_spacing.dart';
import 'nudge_radius.dart';

/// Nudge Design System — Flutter ThemeData Builder
///
/// Converts a [NudgeThemeData] into a [ThemeData] compatible with [MaterialApp].
/// This is the only place that touches Flutter's ThemeData directly.
///
/// Keep this file thin — all design decisions live in the token files.
abstract final class AppTheme {
  AppTheme._();

  /// Builds a [ThemeData] from the given [NudgeThemeData].
  static ThemeData fromNudge(NudgeThemeData t) {
    final cs = ColorScheme(
      brightness: t.brightness,
      primary: t.accent,
      onPrimary: t.brightness == Brightness.dark
          ? const Color(0xFF000000)
          : const Color(0xFFFFFFFF),
      secondary: t.accentLight,
      onSecondary: t.brightness == Brightness.dark
          ? const Color(0xFF000000)
          : const Color(0xFFFFFFFF),
      error: t.semanticColors.error,
      onError: const Color(0xFFFFFFFF),
      surface: t.surface,
      onSurface: t.primaryText,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      scaffoldBackgroundColor: t.background,
      splashFactory: NoSplash.splashFactory,
      highlightColor: t.accent.withValues(alpha: 0.08),

      // Typography
      textTheme: TextTheme(
        displayLarge: t.type.display.copyWith(color: t.primaryText),
        displayMedium: t.type.display
            .copyWith(color: t.primaryText, fontSize: 40),
        displaySmall: t.type.display
            .copyWith(color: t.primaryText, fontSize: 32),
        headlineLarge: t.type.headline.copyWith(color: t.primaryText),
        headlineMedium: t.type.headline
            .copyWith(color: t.primaryText, fontSize: 24),
        headlineSmall: t.type.headline
            .copyWith(color: t.primaryText, fontSize: 20),
        titleLarge: t.type.title.copyWith(color: t.primaryText),
        titleMedium: t.type.label.copyWith(color: t.primaryText),
        titleSmall: t.type.label
            .copyWith(color: t.primaryText, fontSize: 12),
        bodyLarge: t.type.body.copyWith(color: t.primaryText),
        bodyMedium: t.type.body
            .copyWith(color: t.secondaryText, fontSize: 14),
        bodySmall: t.type.caption.copyWith(color: t.secondaryText),
        labelLarge: t.type.label.copyWith(color: t.primaryText),
        labelMedium: t.type.label.copyWith(color: t.secondaryText),
        labelSmall: t.type.caption.copyWith(color: t.mutedText),
      ),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: t.background,
        foregroundColor: t.primaryText,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: t.type.title.copyWith(color: t.primaryText),
      ),

      // Cards
      cardTheme: CardThemeData(
        color: t.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: NudgeRadius.mediumAll,
          side: BorderSide(color: t.divider, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),

      // Dividers
      dividerTheme: DividerThemeData(
        color: t.divider,
        thickness: 1,
        space: 1,
      ),

      // Input fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: t.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: NudgeSpacing.lg,
          vertical: NudgeSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: NudgeRadius.smallAll,
          borderSide: BorderSide(color: t.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: NudgeRadius.smallAll,
          borderSide: BorderSide(color: t.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: NudgeRadius.smallAll,
          borderSide: BorderSide(color: t.accent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: NudgeRadius.smallAll,
          borderSide: BorderSide(color: t.semanticColors.error),
        ),
        hintStyle: t.type.body.copyWith(color: t.mutedText),
        labelStyle: t.type.label.copyWith(color: t.secondaryText),
      ),

      // Elevated buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: t.accent,
          foregroundColor: const Color(0xFFFFFFFF),
          textStyle: t.type.label,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: NudgeSpacing.xl,
            vertical: NudgeSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: NudgeRadius.smallAll,
          ),
        ),
      ),

      // Outlined buttons
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: t.primaryText,
          textStyle: t.type.label,
          side: BorderSide(color: t.divider),
          padding: const EdgeInsets.symmetric(
            horizontal: NudgeSpacing.xl,
            vertical: NudgeSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: NudgeRadius.smallAll,
          ),
        ),
      ),

      // Text buttons
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: t.accent,
          textStyle: t.type.label,
          padding: const EdgeInsets.symmetric(
            horizontal: NudgeSpacing.lg,
            vertical: NudgeSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: NudgeRadius.smallAll,
          ),
        ),
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const Color(0xFFFFFFFF);
          }
          return t.mutedText;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return t.accent;
          }
          return t.divider;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: t.surface,
        labelStyle: t.type.label.copyWith(color: t.primaryText),
        side: BorderSide(color: t.divider),
        shape: RoundedRectangleBorder(borderRadius: NudgeRadius.fullAll),
        padding: const EdgeInsets.symmetric(
          horizontal: NudgeSpacing.md,
          vertical: NudgeSpacing.xs,
        ),
      ),

      // Icon
      iconTheme: IconThemeData(color: t.secondaryText, size: 20),
      primaryIconTheme: IconThemeData(color: t.primaryText, size: 20),
    );
  }
}

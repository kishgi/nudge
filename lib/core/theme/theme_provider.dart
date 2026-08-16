import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../database/database_service.dart';
import 'nudge_theme.dart';
import 'theme_presets.dart';
import '../../features/customization/domain/models/app_settings.dart';

/// State holding the active configuration and system brightness.
class ThemeConfigState {
  const ThemeConfigState({
    required this.config,
    required this.systemBrightness,
  });

  final ThemeConfig config;
  final Brightness systemBrightness;

  NudgeThemeData get themeData =>
      buildThemeDataFromConfig(config, systemBrightness);

  ThemeConfigState copyWith({
    ThemeConfig? config,
    Brightness? systemBrightness,
  }) {
    return ThemeConfigState(
      config: config ?? this.config,
      systemBrightness: systemBrightness ?? this.systemBrightness,
    );
  }
}

/// Dynamic notifier for managing theme configurations with live updates 
/// and debounced database persistence.
class ThemeConfigNotifier extends Notifier<ThemeConfigState> {
  Timer? _debounceTimer;

  @override
  ThemeConfigState build() {
    final db = ref.read(databaseServiceProvider);
    final brightness = ui.PlatformDispatcher.instance.platformBrightness;

    // Load active settings
    final settings = db.isar.appSettings.where().findFirstSync() ?? AppSettings();
    ThemeConfig? activeConfig;

    if (settings.activeThemeConfigId != null) {
      activeConfig = db.isar.themeConfigs.getSync(settings.activeThemeConfigId!);
    }

    // Fallback: load the first seeded config (usually Pure)
    activeConfig ??= db.isar.themeConfigs.where().findFirstSync() ?? (NudgeThemePreset.pure.toConfig());

    return ThemeConfigState(
      config: activeConfig,
      systemBrightness: brightness,
    );
  }

  /// Updates system brightness dynamically.
  void setSystemBrightness(Brightness brightness) {
    state = state.copyWith(systemBrightness: brightness);
  }

  /// Switches to a built-in preset theme.
  Future<void> setPreset(NudgeThemePreset preset) async {
    final db = ref.read(databaseServiceProvider);
    final isar = db.isar;

    // Check if preset config already exists in Isar to preserve state
    ThemeConfig? presetConfig = await isar.themeConfigs
        .where()
        .filter()
        .nameEqualTo(preset.label)
        .isCustomEqualTo(false)
        .findFirst();

    presetConfig ??= preset.toConfig();

    await isar.writeTxn(() async {
      final id = await isar.themeConfigs.put(presetConfig!);
      presetConfig.id = id;

      final settings = await isar.appSettings.where().findFirst() ?? AppSettings();
      settings.activeThemeConfigId = id;
      await isar.appSettings.put(settings);
    });

    state = state.copyWith(config: presetConfig);
  }

  /// Applies an existing ThemeConfig to settings.
  Future<void> applyConfig(ThemeConfig target) async {
    final db = ref.read(databaseServiceProvider);
    final isar = db.isar;

    await isar.writeTxn(() async {
      final settings = await isar.appSettings.where().findFirst() ?? AppSettings();
      settings.activeThemeConfigId = target.id;
      await isar.appSettings.put(settings);
    });

    state = state.copyWith(config: target);
  }

  /// Triggers a debounced write to persist current theme config.
  void _saveDebounced() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      final db = ref.read(databaseServiceProvider);
      final isar = db.isar;
      final configToSave = state.config;

      await isar.writeTxn(() async {
        await isar.themeConfigs.put(configToSave);
      });
    });
  }

  /// Updates a field on the current configuration and schedules persistence.
  void updateField(void Function(ThemeConfig) update) {
    final current = state.config;
    // Mutate state copy directly
    update(current);
    // Trigger immediate UI refresh
    state = state.copyWith(config: current);
    // Debounce DB write
    _saveDebounced();
  }

  /// Saves the current layout as a custom theme.
  Future<void> saveCustomTheme(String name) async {
    final db = ref.read(databaseServiceProvider);
    final isar = db.isar;

    final custom = ThemeConfig()
      ..name = name
      ..isCustom = true
      // Copy all fields from current configuration
      ..fontFamily = state.config.fontFamily
      ..fontWeight = state.config.fontWeight
      ..fontSizeScale = state.config.fontSizeScale
      ..letterSpacingDelta = state.config.letterSpacingDelta
      ..lineHeightScale = state.config.lineHeightScale
      ..textAlignment = state.config.textAlignment
      ..textCase = state.config.textCase
      ..iconPack = state.config.iconPack
      ..iconSize = state.config.iconSize
      ..iconThickness = state.config.iconThickness
      ..iconStyle = state.config.iconStyle
      ..iconColorValue = state.config.iconColorValue
      ..iconOpacity = state.config.iconOpacity
      ..colorPreset = state.config.colorPreset
      ..backgroundColorValue = state.config.backgroundColorValue
      ..primaryTextColorValue = state.config.primaryTextColorValue
      ..secondaryTextColorValue = state.config.secondaryTextColorValue
      ..accentColorValue = state.config.accentColorValue
      ..horizontalPadding = state.config.horizontalPadding
      ..verticalSpacing = state.config.verticalSpacing
      ..appDensity = state.config.appDensity
      ..appAlignment = state.config.appAlignment
      ..visibleAppCount = state.config.visibleAppCount
      ..showIcons = state.config.showIcons
      ..clockPosition = state.config.clockPosition
      ..clockFormat = state.config.clockFormat
      ..showSeconds = state.config.showSeconds
      ..clockSizeScale = state.config.clockSizeScale
      ..clockFontFamily = state.config.clockFontFamily
      ..clockFontWeight = state.config.clockFontWeight
      ..clockAlignment = state.config.clockAlignment
      ..showDate = state.config.showDate
      ..dateFormat = state.config.dateFormat
      ..motionMode = state.config.motionMode
      ..animationSpeedScale = state.config.animationSpeedScale
      ..reducedMotion = state.config.reducedMotion
      ..hapticFeedback = state.config.hapticFeedback;

    await isar.writeTxn(() async {
      final id = await isar.themeConfigs.put(custom);
      custom.id = id;

      final settings = await isar.appSettings.where().findFirst() ?? AppSettings();
      settings.activeThemeConfigId = id;
      await isar.appSettings.put(settings);
    });

    state = state.copyWith(config: custom);
  }

  /// Duplicates a theme.
  Future<void> duplicateTheme(ThemeConfig target, String newName) async {
    final db = ref.read(databaseServiceProvider);
    final isar = db.isar;

    final dup = ThemeConfig()
      ..name = newName
      ..isCustom = true
      ..fontFamily = target.fontFamily
      ..fontWeight = target.fontWeight
      ..fontSizeScale = target.fontSizeScale
      ..letterSpacingDelta = target.letterSpacingDelta
      ..lineHeightScale = target.lineHeightScale
      ..textAlignment = target.textAlignment
      ..textCase = target.textCase
      ..iconPack = target.iconPack
      ..iconSize = target.iconSize
      ..iconThickness = target.iconThickness
      ..iconStyle = target.iconStyle
      ..iconColorValue = target.iconColorValue
      ..iconOpacity = target.iconOpacity
      ..colorPreset = target.colorPreset
      ..backgroundColorValue = target.backgroundColorValue
      ..primaryTextColorValue = target.primaryTextColorValue
      ..secondaryTextColorValue = target.secondaryTextColorValue
      ..accentColorValue = target.accentColorValue
      ..horizontalPadding = target.horizontalPadding
      ..verticalSpacing = target.verticalSpacing
      ..appDensity = target.appDensity
      ..appAlignment = target.appAlignment
      ..visibleAppCount = target.visibleAppCount
      ..showIcons = target.showIcons
      ..clockPosition = target.clockPosition
      ..clockFormat = target.clockFormat
      ..showSeconds = target.showSeconds
      ..clockSizeScale = target.clockSizeScale
      ..clockFontFamily = target.clockFontFamily
      ..clockFontWeight = target.clockFontWeight
      ..clockAlignment = target.clockAlignment
      ..showDate = target.showDate
      ..dateFormat = target.dateFormat
      ..motionMode = target.motionMode
      ..animationSpeedScale = target.animationSpeedScale
      ..reducedMotion = target.reducedMotion
      ..hapticFeedback = target.hapticFeedback;

    await isar.writeTxn(() async {
      final id = await isar.themeConfigs.put(dup);
      dup.id = id;

      final settings = await isar.appSettings.where().findFirst() ?? AppSettings();
      settings.activeThemeConfigId = id;
      await isar.appSettings.put(settings);
    });

    state = state.copyWith(config: dup);
  }

  /// Deletes a custom theme.
  Future<void> deleteCustomTheme(int id) async {
    final db = ref.read(databaseServiceProvider);
    final isar = db.isar;

    await isar.writeTxn(() async {
      await isar.themeConfigs.delete(id);
    });

    // If active was deleted, fallback to default Pure preset
    if (state.config.id == id) {
      await setPreset(NudgeThemePreset.pure);
    }
  }

  /// Resets the config to default preset state.
  Future<void> resetToDefault() async {
    final presetName = state.config.name;
    final preset = NudgeThemePreset.values.firstWhere(
      (p) => p.label == presetName,
      orElse: () => NudgeThemePreset.pure,
    );

    final defaultConfig = preset.toConfig();
    defaultConfig.id = state.config.id; // Keep same row ID

    final db = ref.read(databaseServiceProvider);
    await db.isar.writeTxn(() async {
      await db.isar.themeConfigs.put(defaultConfig);
    });

    state = state.copyWith(config: defaultConfig);
  }

  /// Loads all available theme configs from database.
  Future<List<ThemeConfig>> getAllThemes() async {
    final db = ref.read(databaseServiceProvider);
    return db.isar.themeConfigs.where().findAll();
  }
}

// ---------------------------------------------------------------------------
// Providers
// ---------------------------------------------------------------------------

/// The top-level theme provider, managing [ThemeConfigState].
final nudgeThemeProvider =
    NotifierProvider<ThemeConfigNotifier, ThemeConfigState>(
  ThemeConfigNotifier.new,
);

/// Convenience provider that directly exposes the active [NudgeThemeData].
final nudgeThemeDataProvider = Provider<NudgeThemeData>((ref) {
  return ref.watch(nudgeThemeProvider).themeData;
});

/// Convenience provider for the active [ThemeConfig].
final activeThemeConfigProvider = Provider<ThemeConfig>((ref) {
  return ref.watch(nudgeThemeProvider).config;
});

/// Convenience provider for the active [NudgeThemePreset].
final nudgeThemePresetProvider = Provider<NudgeThemePreset>((ref) {
  final name = ref.watch(nudgeThemeProvider).config.name;
  return NudgeThemePreset.values.firstWhere(
    (p) => p.label == name,
    orElse: () => NudgeThemePreset.pure,
  );
});

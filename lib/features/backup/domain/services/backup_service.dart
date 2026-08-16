import 'package:isar_community/isar.dart';
import '../../../../core/database/database_service.dart';
import '../../../apps/domain/models/installed_app.dart';
import '../../../customization/domain/models/app_settings.dart';
import '../../../customization/domain/models/theme_config.dart';
import '../../../focus/domain/models/focus_models.dart';
import '../models/nudge_backup.dart';

/// Result status of a backup import attempt.
class ImportResult {
  const ImportResult({
    required this.success,
    required this.message,
    this.summary,
  });

  final bool success;
  final String message;
  final String? summary;
}

/// Service handling local JSON export, import, schema migration, and factory reset.
class BackupService {
  const BackupService(this.db);

  final DatabaseService db;

  /// Exports all launcher configuration into a formatted JSON string.
  Future<String> exportBackup() async {
    final isar = db.isar;

    final appSettings = await isar.appSettings.where().findFirst() ?? AppSettings();
    final themes = await isar.themeConfigs.where().findAll();
    final apps = await isar.installedApps.where().findAll();
    final focusRules = await isar.focusRules.where().findAll();

    final favorites = apps
        .where((a) => a.isFavorite)
        .map((a) => {'packageName': a.packageName, 'position': a.position})
        .toList();

    final hiddenApps = apps.where((a) => a.isHidden).map((a) => a.packageName).toList();

    final themeMaps = themes.map((t) => {
      'name': t.name,
      'isCustom': t.isCustom,
      'fontFamily': t.fontFamily,
      'fontWeight': t.fontWeight,
      'fontSizeScale': t.fontSizeScale,
      'letterSpacingDelta': t.letterSpacingDelta,
      'lineHeightScale': t.lineHeightScale,
      'textAlignment': t.textAlignment,
      'textCase': t.textCase,
      'iconPack': t.iconPack,
      'iconSize': t.iconSize,
      'iconThickness': t.iconThickness,
      'iconStyle': t.iconStyle,
      'iconColorValue': t.iconColorValue,
      'iconOpacity': t.iconOpacity,
      'colorPreset': t.colorPreset,
      'backgroundColorValue': t.backgroundColorValue,
      'primaryTextColorValue': t.primaryTextColorValue,
      'secondaryTextColorValue': t.secondaryTextColorValue,
      'accentColorValue': t.accentColorValue,
      'horizontalPadding': t.horizontalPadding,
      'verticalSpacing': t.verticalSpacing,
      'appDensity': t.appDensity,
      'appAlignment': t.appAlignment,
      'visibleAppCount': t.visibleAppCount,
      'showIcons': t.showIcons,
      'clockPosition': t.clockPosition,
      'clockFormat': t.clockFormat,
      'showSeconds': t.showSeconds,
      'clockSizeScale': t.clockSizeScale,
      'clockFontFamily': t.clockFontFamily,
      'clockFontWeight': t.clockFontWeight,
      'clockAlignment': t.clockAlignment,
      'showDate': t.showDate,
      'dateFormat': t.dateFormat,
      'motionMode': t.motionMode,
      'animationSpeedScale': t.animationSpeedScale,
      'reducedMotion': t.reducedMotion,
      'hapticFeedback': t.hapticFeedback,
      'highContrast': t.highContrast,
    }).toList();

    final ruleMaps = focusRules.map((r) => {
      'packageName': r.packageName,
      'isBlocked': r.isBlocked,
      'delaySeconds': r.delaySeconds,
      'scheduleEnabled': r.scheduleEnabled,
      'scheduleDays': r.scheduleDays,
      'startHour': r.startHour,
      'startMinute': r.startMinute,
      'endHour': r.endHour,
      'endMinute': r.endMinute,
      'customMessage': r.customMessage,
    }).toList();

    final settingsMap = {
      'gestureSwipeUp': appSettings.gestureSwipeUp,
      'gestureSwipeDown': appSettings.gestureSwipeDown,
      'gestureDoubleTap': appSettings.gestureDoubleTap,
      'gestureLongPress': appSettings.gestureLongPress,
      'drawerSortMode': appSettings.drawerSortMode,
      'drawerScrollOffset': appSettings.drawerScrollOffset,
      'showSmartSuggestions': appSettings.showSmartSuggestions,
      'homeWidgetsJson': appSettings.homeWidgetsJson,
      'widgetSpacing': appSettings.widgetSpacing,
      'widgetAlignment': appSettings.widgetAlignment,
    };

    final backup = NudgeBackup(
      version: 1,
      createdAt: DateTime.now().toIso8601String(),
      appSettings: settingsMap,
      themes: themeMaps,
      favorites: favorites,
      hiddenApps: hiddenApps,
      focusRules: ruleMaps,
    );

    return backup.encode();
  }

  /// Parses and validates a JSON string. Returns summary without writing to DB.
  ImportResult inspectBackup(String jsonString) {
    try {
      final backup = NudgeBackup.decode(jsonString);
      final summary = '${backup.themes.length} themes, '
          '${backup.favorites.length} favorites, '
          '${backup.hiddenApps.length} hidden apps, '
          '${backup.focusRules.length} focus rules';
      return ImportResult(success: true, message: 'Valid backup file', summary: summary);
    } catch (e) {
      return ImportResult(success: false, message: 'Corrupted backup file: ${e.toString()}');
    }
  }

  /// Restores launcher configuration from a JSON string into Isar database.
  Future<ImportResult> importBackup(String jsonString) async {
    final validation = inspectBackup(jsonString);
    if (!validation.success) return validation;

    try {
      final backup = NudgeBackup.decode(jsonString);
      final isar = db.isar;

      await isar.writeTxn(() async {
        // 1. Restore AppSettings
        var settings = await isar.appSettings.where().findFirst();
        settings ??= AppSettings();
        final sMap = backup.appSettings;
        if (sMap.containsKey('gestureSwipeUp')) settings.gestureSwipeUp = sMap['gestureSwipeUp'] as String;
        if (sMap.containsKey('gestureSwipeDown')) settings.gestureSwipeDown = sMap['gestureSwipeDown'] as String;
        if (sMap.containsKey('gestureDoubleTap')) settings.gestureDoubleTap = sMap['gestureDoubleTap'] as String;
        if (sMap.containsKey('gestureLongPress')) settings.gestureLongPress = sMap['gestureLongPress'] as String;
        if (sMap.containsKey('drawerSortMode')) settings.drawerSortMode = sMap['drawerSortMode'] as String;
        if (sMap.containsKey('drawerScrollOffset')) settings.drawerScrollOffset = (sMap['drawerScrollOffset'] as num).toDouble();
        if (sMap.containsKey('showSmartSuggestions')) settings.showSmartSuggestions = sMap['showSmartSuggestions'] as bool;
        if (sMap.containsKey('homeWidgetsJson')) settings.homeWidgetsJson = sMap['homeWidgetsJson'] as String;
        if (sMap.containsKey('widgetSpacing')) settings.widgetSpacing = (sMap['widgetSpacing'] as num).toDouble();
        if (sMap.containsKey('widgetAlignment')) settings.widgetAlignment = sMap['widgetAlignment'] as String;
        await isar.appSettings.put(settings);

        // 2. Restore ThemeConfigs
        for (final tMap in backup.themes) {
          final name = tMap['name'] as String? ?? 'Custom Theme';
          var existing = await isar.themeConfigs.where().filter().nameEqualTo(name).findFirst();
          existing ??= ThemeConfig()..name = name;

          existing.isCustom = tMap['isCustom'] as bool? ?? true;
          existing.fontFamily = tMap['fontFamily'] as String? ?? 'Inter';
          existing.fontWeight = tMap['fontWeight'] as int? ?? 400;
          existing.fontSizeScale = (tMap['fontSizeScale'] as num?)?.toDouble() ?? 1.0;
          existing.letterSpacingDelta = (tMap['letterSpacingDelta'] as num?)?.toDouble() ?? 0.0;
          existing.lineHeightScale = (tMap['lineHeightScale'] as num?)?.toDouble() ?? 1.0;
          existing.textAlignment = tMap['textAlignment'] as String? ?? 'left';
          existing.textCase = tMap['textCase'] as String? ?? 'none';
          existing.iconPack = tMap['iconPack'] as String? ?? 'material';
          existing.iconSize = (tMap['iconSize'] as num?)?.toDouble() ?? 20.0;
          existing.iconThickness = (tMap['iconThickness'] as num?)?.toDouble() ?? 1.5;
          existing.iconStyle = tMap['iconStyle'] as String? ?? 'outline';
          existing.iconColorValue = tMap['iconColorValue'] as int?;
          existing.iconOpacity = (tMap['iconOpacity'] as num?)?.toDouble() ?? 1.0;
          existing.colorPreset = tMap['colorPreset'] as String? ?? 'dark';
          existing.backgroundColorValue = tMap['backgroundColorValue'] as int?;
          existing.primaryTextColorValue = tMap['primaryTextColorValue'] as int?;
          existing.secondaryTextColorValue = tMap['secondaryTextColorValue'] as int?;
          existing.accentColorValue = tMap['accentColorValue'] as int?;
          existing.horizontalPadding = (tMap['horizontalPadding'] as num?)?.toDouble() ?? 24.0;
          existing.verticalSpacing = (tMap['verticalSpacing'] as num?)?.toDouble() ?? 12.0;
          existing.appDensity = tMap['appDensity'] as String? ?? 'normal';
          existing.appAlignment = tMap['appAlignment'] as String? ?? 'left';
          existing.visibleAppCount = tMap['visibleAppCount'] as int? ?? 6;
          existing.showIcons = tMap['showIcons'] as bool? ?? false;
          existing.clockPosition = tMap['clockPosition'] as String? ?? 'top';
          existing.clockFormat = tMap['clockFormat'] as String? ?? '24';
          existing.showSeconds = tMap['showSeconds'] as bool? ?? false;
          existing.clockSizeScale = (tMap['clockSizeScale'] as num?)?.toDouble() ?? 1.0;
          existing.clockFontFamily = tMap['clockFontFamily'] as String?;
          existing.clockFontWeight = tMap['clockFontWeight'] as int?;
          existing.clockAlignment = tMap['clockAlignment'] as String? ?? 'left';
          existing.showDate = tMap['showDate'] as bool? ?? true;
          existing.dateFormat = tMap['dateFormat'] as String? ?? 'EEE, MMM d';
          existing.motionMode = tMap['motionMode'] as String? ?? 'calm';
          existing.animationSpeedScale = (tMap['animationSpeedScale'] as num?)?.toDouble() ?? 1.0;
          existing.reducedMotion = tMap['reducedMotion'] as bool? ?? false;
          existing.hapticFeedback = tMap['hapticFeedback'] as bool? ?? true;
          existing.highContrast = tMap['highContrast'] as bool? ?? false;

          await isar.themeConfigs.put(existing);
        }

        // 3. Restore Favorites & Hidden apps
        final favMap = {for (final f in backup.favorites) f['packageName'] as String: f['position'] as int? ?? 0};
        final hiddenSet = Set<String>.from(backup.hiddenApps);

        final apps = await isar.installedApps.where().findAll();
        for (final app in apps) {
          bool updated = false;
          if (favMap.containsKey(app.packageName)) {
            app.isFavorite = true;
            app.position = favMap[app.packageName]!;
            updated = true;
          } else if (app.isFavorite) {
            app.isFavorite = false;
            updated = true;
          }

          final shouldBeHidden = hiddenSet.contains(app.packageName);
          if (app.isHidden != shouldBeHidden) {
            app.isHidden = shouldBeHidden;
            updated = true;
          }

          if (updated) await isar.installedApps.put(app);
        }

        // 4. Restore FocusRules
        await isar.focusRules.clear();
        for (final rMap in backup.focusRules) {
          final pkg = rMap['packageName'] as String?;
          if (pkg != null) {
            final rule = FocusRule()
              ..packageName = pkg
              ..isBlocked = rMap['isBlocked'] as bool? ?? false
              ..delaySeconds = rMap['delaySeconds'] as int? ?? 0
              ..scheduleEnabled = rMap['scheduleEnabled'] as bool? ?? false
              ..scheduleDays = (rMap['scheduleDays'] as List? ?? []).cast<int>()
              ..startHour = rMap['startHour'] as int? ?? 0
              ..startMinute = rMap['startMinute'] as int? ?? 0
              ..endHour = rMap['endHour'] as int? ?? 0
              ..endMinute = rMap['endMinute'] as int? ?? 0
              ..customMessage = rMap['customMessage'] as String?;
            await isar.focusRules.put(rule);
          }
        }
      });

      return ImportResult(
        success: true,
        message: 'Backup restored successfully!',
        summary: validation.summary,
      );
    } catch (e) {
      return ImportResult(success: false, message: 'Failed to import backup: ${e.toString()}');
    }
  }

  /// Performs a full factory reset of Nudge configuration back to default state.
  Future<void> factoryReset() async {
    final isar = db.isar;
    await isar.writeTxn(() async {
      await isar.appSettings.clear();
      await isar.focusRules.clear();
      final apps = await isar.installedApps.where().findAll();
      for (final app in apps) {
        app.isFavorite = false;
        app.isHidden = false;
        app.position = 0;
        await isar.installedApps.put(app);
      }
      await isar.appSettings.put(AppSettings());
    });
  }
}

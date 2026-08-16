import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/customization/domain/models/app_settings.dart';
import '../../features/apps/domain/models/installed_app.dart';
import '../../features/customization/domain/models/theme_config.dart';
import '../../features/focus/domain/models/focus_models.dart';
import '../../features/usage/domain/models/usage_models.dart';

export '../../features/apps/domain/models/installed_app.dart';
export '../../features/customization/domain/models/theme_config.dart';
export '../../features/focus/domain/models/focus_models.dart';
export '../../features/usage/domain/models/usage_models.dart';

class DatabaseService {
  late final Isar isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        AppSettingsSchema,
        InstalledAppSchema,
        ThemeConfigSchema,
        FocusRuleSchema,
        FocusSessionSchema,
        UsageSummarySchema,
      ],
      directory: dir.path,
    );

    await _seedDefaults();
  }

  Future<void> _seedDefaults() async {
    // Seed AppSettings if absent
    final settingsCount = await isar.appSettings.count();
    if (settingsCount == 0) {
      await isar.writeTxn(() async {
        await isar.appSettings.put(AppSettings());
      });
    }

    // Seed built-in ThemeConfigs if absent
    final configCount = await isar.themeConfigs.count();
    if (configCount == 0) {
      await isar.writeTxn(() async {
        for (final config in _builtInConfigs()) {
          await isar.themeConfigs.put(config);
        }
      });
    }
  }

  /// Returns the 7 built-in preset ThemeConfig seeds.
  List<ThemeConfig> _builtInConfigs() => [
        _pure(),
        _linear(),
        _nothing(),
        _terminal(),
        _paper(),
        _developer(),
        _oled(),
      ];

  ThemeConfig _pure() => ThemeConfig()
    ..name = 'Pure'
    ..colorPreset = 'light'
    ..fontFamily = 'Inter'
    ..motionMode = 'calm'
    ..clockPosition = 'top'
    ..showDate = true;

  ThemeConfig _linear() => ThemeConfig()
    ..name = 'Linear'
    ..colorPreset = 'dark'
    ..fontFamily = 'Inter'
    ..fontWeight = 400
    ..motionMode = 'smooth'
    ..clockPosition = 'top'
    ..showDate = true;

  ThemeConfig _nothing() => ThemeConfig()
    ..name = 'Nothing'
    ..colorPreset = 'dark'
    ..fontFamily = 'Inter'
    ..letterSpacingDelta = 0.5
    ..motionMode = 'calm'
    ..clockPosition = 'top'
    ..showDate = true;

  ThemeConfig _terminal() => ThemeConfig()
    ..name = 'Terminal'
    ..colorPreset = 'dark'
    ..fontFamily = 'JetBrainsMono'
    ..fontWeight = 400
    ..motionMode = 'none'
    ..clockPosition = 'top'
    ..showDate = true;

  ThemeConfig _paper() => ThemeConfig()
    ..name = 'Paper'
    ..colorPreset = 'light'
    ..fontFamily = 'IBMPlexSans'
    ..lineHeightScale = 1.15
    ..motionMode = 'calm'
    ..clockPosition = 'top'
    ..showDate = true;

  ThemeConfig _developer() => ThemeConfig()
    ..name = 'Developer'
    ..colorPreset = 'dark'
    ..fontFamily = 'IBMPlexMono'
    ..fontWeight = 400
    ..motionMode = 'none'
    ..clockPosition = 'top'
    ..showDate = true;

  ThemeConfig _oled() => ThemeConfig()
    ..name = 'OLED'
    ..colorPreset = 'oled'
    ..fontFamily = 'Inter'
    ..motionMode = 'calm'
    ..clockPosition = 'top'
    ..showDate = true;
}

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  // Overridden in main() with an initialized instance.
  throw UnimplementedError();
});

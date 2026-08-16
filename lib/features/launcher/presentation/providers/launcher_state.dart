import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';

import '../../../../core/database/database_service.dart';
import '../../../apps/domain/models/installed_app.dart';
import '../../../customization/domain/models/app_settings.dart';
import '../../domain/models/home_widget_config.dart';

/// State class for the launcher.
final class LauncherState {
  LauncherState({
    required this.allApps,
    required this.appIcons,
    required this.settings,
  });

  final List<InstalledApp> allApps;
  final Map<String, Uint8List> appIcons;
  final AppSettings settings;

  LauncherState copyWith({
    List<InstalledApp>? allApps,
    Map<String, Uint8List>? appIcons,
    AppSettings? settings,
  }) {
    return LauncherState(
      allApps: allApps ?? this.allApps,
      appIcons: appIcons ?? this.appIcons,
      settings: settings ?? this.settings,
    );
  }
}

/// Notifier that manages installed apps, icons memory cache, and AppSettings.
final class LauncherNotifier extends Notifier<LauncherState> {
  static const _channel = MethodChannel('com.example.nudge/launcher');

  @override
  LauncherState build() {
    final db = ref.read(databaseServiceProvider);
    
    // Watch AppSettings and InstalledApps dynamically
    final settings = db.isar.appSettings.where().findFirstSync() ?? AppSettings();
    final apps = db.isar.installedApps.where().findAllSync();

    // Listen to native package changes
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onAppsChanged') {
        await refreshApps();
      }
    });

    // Start initial refresh in background
    Future.microtask(() => refreshApps());

    return LauncherState(
      allApps: apps,
      appIcons: const {},
      settings: settings,
    );
  }

  /// Refreshes the list of apps by querying the native Android APIs,
  /// updating the Isar database cache, and keeping the icons in memory.
  Future<void> refreshApps() async {
    try {
      final List<dynamic>? nativeApps =
          await _channel.invokeMethod<List<dynamic>>('getInstalledApps');
      if (nativeApps == null) return;

      final db = ref.read(databaseServiceProvider);
      final isar = db.isar;

      // Extract details from native
      final nativePackNames = <String>{};
      final nativeAppsMap = <String, Map<String, dynamic>>{};
      final newIcons = Map<String, Uint8List>.from(state.appIcons);

      for (final appObj in nativeApps) {
        if (appObj is Map) {
          final packageName = appObj['packageName'] as String?;
          final appName = appObj['appName'] as String?;
          final iconBytes = appObj['icon'] as Uint8List?;
          final category = appObj['category'] as String? ?? 'Other';

          if (packageName != null && appName != null) {
            nativePackNames.add(packageName);
            nativeAppsMap[packageName] = {
              'appName': appName,
              'packageName': packageName,
              'category': category,
            };
            if (iconBytes != null) {
              newIcons[packageName] = iconBytes;
            }
          }
        }
      }

      final currentDbApps = await isar.installedApps.where().findAll();
      final currentDbMap = {for (var a in currentDbApps) a.packageName: a};

      await isar.writeTxn(() async {
        // 1. Delete apps no longer installed
        for (final dbApp in currentDbApps) {
          if (!nativePackNames.contains(dbApp.packageName)) {
            await isar.installedApps.delete(dbApp.id);
          }
        }

        // 2. Add or update apps
        for (final packageName in nativePackNames) {
          final nativeData = nativeAppsMap[packageName]!;
          final existing = currentDbMap[packageName];
          
          if (existing == null) {
            // New app
            final newApp = InstalledApp()
              ..packageName = packageName
              ..appName = nativeData['appName'] as String
              ..category = nativeData['category'] as String? ?? 'Other'
              ..isFavorite = false
              ..isHidden = false
              ..position = 0;
            await isar.installedApps.put(newApp);
          } else {
            // Update name and category if changed
            bool changed = false;
            if (existing.appName != nativeData['appName']) {
              existing.appName = nativeData['appName'] as String;
              changed = true;
            }
            final newCat = nativeData['category'] as String? ?? 'Other';
            if (existing.category != newCat) {
              existing.category = newCat;
              changed = true;
            }
            if (changed) await isar.installedApps.put(existing);
          }
        }
      });

      // Reload updated lists from Isar
      final updatedApps = await isar.installedApps.where().findAll();
      state = state.copyWith(
        allApps: updatedApps,
        appIcons: newIcons,
      );
    } on PlatformException catch (_) {
      // Platform Exception is expected when running in tests/mocks without platform channels.
    } catch (_) {
      // Gracefully ignore refresh errors in offline production
    }
  }

  /// Launches the given application package.
  Future<bool> launchApp(String packageName) async {
    try {
      await _channel.invokeMethod('launchApp', {'packageName': packageName});
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Sets whether an app is selected for the Home Screen.
  Future<void> setHomeAppSelected(String packageName, bool selected) async {
    final db = ref.read(databaseServiceProvider);
    final isar = db.isar;

    final app = await isar.installedApps.where().packageNameEqualTo(packageName).findFirst();
    if (app != null && app.isFavorite != selected) {
      await isar.writeTxn(() async {
        app.isFavorite = selected;
        if (selected) {
          final maxPos = await isar.installedApps
              .where()
              .filter()
              .isFavoriteEqualTo(true)
              .positionProperty()
              .max() ?? 0;
          app.position = maxPos + 1;
        }
        await isar.installedApps.put(app);
      });
      await _syncLocalState();
    }
  }

  /// Removes an app from the Home Screen selection.
  Future<void> removeHomeApp(String packageName) async {
    await setHomeAppSelected(packageName, false);
  }

  /// Toggles favorite/home status of [packageName].
  Future<void> toggleFavorite(String packageName) async {
    final db = ref.read(databaseServiceProvider);
    final isar = db.isar;

    final app = await isar.installedApps.where().packageNameEqualTo(packageName).findFirst();
    if (app != null) {
      await setHomeAppSelected(packageName, !app.isFavorite);
    }
  }

  /// Toggles hidden status of [packageName].
  Future<void> toggleHidden(String packageName) async {
    final db = ref.read(databaseServiceProvider);
    final isar = db.isar;

    final app = await isar.installedApps.where().packageNameEqualTo(packageName).findFirst();
    if (app != null) {
      await isar.writeTxn(() async {
        app.isHidden = !app.isHidden;
        await isar.installedApps.put(app);
      });
      await _syncLocalState();
    }
  }

  /// Reorders favorite apps positions.
  Future<void> reorderFavorites(int oldIndex, int newIndex) async {
    final db = ref.read(databaseServiceProvider);
    final isar = db.isar;

    final favorites = await isar.installedApps
        .where()
        .filter()
        .isFavoriteEqualTo(true)
        .sortByPosition()
        .findAll();

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final item = favorites.removeAt(oldIndex);
    favorites.insert(newIndex, item);

    await isar.writeTxn(() async {
      for (int i = 0; i < favorites.length; i++) {
        favorites[i].position = i;
        await isar.installedApps.put(favorites[i]);
      }
    });
    await _syncLocalState();
  }


  Future<void> _syncLocalState() async {
    final db = ref.read(databaseServiceProvider);
    final apps = await db.isar.installedApps.where().findAll();
    state = state.copyWith(allApps: apps);
  }

  // ─── Settings persistence helpers ──────────────────────────────────────────

  Future<AppSettings> _loadOrCreateSettings() async {
    final db = ref.read(databaseServiceProvider);
    final existing = await db.isar.appSettings.where().findFirst();
    return existing ?? AppSettings();
  }

  Future<void> _persistSettings(AppSettings settings) async {
    final db = ref.read(databaseServiceProvider);
    await db.isar.writeTxn(() => db.isar.appSettings.put(settings));
    state = state.copyWith(settings: settings);
  }

  /// Updates the action bound to one gesture key.
  Future<void> updateGesture(String gestureKey, String actionKey) async {
    final settings = await _loadOrCreateSettings();
    switch (gestureKey) {
      case 'swipeUp': settings.gestureSwipeUp = actionKey;
      case 'swipeDown': settings.gestureSwipeDown = actionKey;
      case 'doubleTap': settings.gestureDoubleTap = actionKey;
      case 'longPress': settings.gestureLongPress = actionKey;
    }
    await _persistSettings(settings);
  }

  /// Persists the ordered + visible widget configuration list.
  Future<void> updateWidgets(List<HomeWidgetConfig> configs) async {
    final settings = await _loadOrCreateSettings();
    settings.homeWidgetsJson = HomeWidgetConfigList.encode(configs);
    await _persistSettings(settings);
  }

  /// Persists the widget strip vertical spacing.
  Future<void> updateWidgetSpacing(double spacing) async {
    final settings = await _loadOrCreateSettings();
    settings.widgetSpacing = spacing;
    await _persistSettings(settings);
  }

  /// Persists the widget strip alignment ('left', 'center', 'right').
  Future<void> updateWidgetAlignment(String alignment) async {
    final settings = await _loadOrCreateSettings();
    settings.widgetAlignment = alignment;
    await _persistSettings(settings);
  }

  /// Persists the drawer sort mode.
  Future<void> updateDrawerSortMode(String mode) async {
    final settings = await _loadOrCreateSettings();
    settings.drawerSortMode = mode;
    await _persistSettings(settings);
  }

  /// Persists the drawer scroll offset.
  Future<void> saveDrawerScrollOffset(double offset) async {
    final settings = await _loadOrCreateSettings();
    settings.drawerScrollOffset = offset;
    await _persistSettings(settings);
  }

  /// Toggles smart suggestions visibility.
  Future<void> toggleSmartSuggestions() async {
    final settings = await _loadOrCreateSettings();
    settings.showSmartSuggestions = !settings.showSmartSuggestions;
    await _persistSettings(settings);
  }
}

// Providers
final launcherProvider = NotifierProvider<LauncherNotifier, LauncherState>(
  LauncherNotifier.new,
);

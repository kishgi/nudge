import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../../core/database/database_service.dart';
import '../../../customization/domain/models/app_settings.dart';

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

          if (packageName != null && appName != null) {
            nativePackNames.add(packageName);
            nativeAppsMap[packageName] = {
              'appName': appName,
              'packageName': packageName,
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
              ..isFavorite = false
              ..isHidden = false
              ..position = 0;
            await isar.installedApps.put(newApp);
          } else if (existing.appName != nativeData['appName']) {
            // Update name
            existing.appName = nativeData['appName'] as String;
            await isar.installedApps.put(existing);
          }
        }
      });

      // Reload updated lists from Isar
      final updatedApps = await isar.installedApps.where().findAll();
      state = state.copyWith(
        allApps: updatedApps,
        appIcons: newIcons,
      );
    } on PlatformException catch (e) {
      // Platform Exception is expected when running in tests/mocks, catch it safely.
      debugPrint('Launcher Platform Exception: $e');
    } catch (e) {
      debugPrint('Refresh Apps Error: $e');
    }
  }

  /// Launches the given application package.
  Future<bool> launchApp(String packageName) async {
    try {
      await _channel.invokeMethod('launchApp', {'packageName': packageName});
      return true;
    } catch (e) {
      debugPrint('Error launching app $packageName: $e');
      return false;
    }
  }

  /// Toggles favorite status of [packageName].
  Future<void> toggleFavorite(String packageName) async {
    final db = ref.read(databaseServiceProvider);
    final isar = db.isar;

    final app = await isar.installedApps.where().packageNameEqualTo(packageName).findFirst();
    if (app != null) {
      await isar.writeTxn(() async {
        app.isFavorite = !app.isFavorite;
        // If favorited, put it at the end of the favorite positions
        if (app.isFavorite) {
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
}

// Providers
final launcherProvider = NotifierProvider<LauncherNotifier, LauncherState>(
  LauncherNotifier.new,
);

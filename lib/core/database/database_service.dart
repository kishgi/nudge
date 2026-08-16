import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/customization/domain/models/app_settings.dart';
import '../../features/apps/domain/models/installed_app.dart';

class DatabaseService {
  late final Isar isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        AppSettingsSchema,
        InstalledAppSchema,
      ],
      directory: dir.path,
    );

    // Initialize default settings if none exist
    final count = await isar.appSettings.count();
    if (count == 0) {
      await isar.writeTxn(() async {
        await isar.appSettings.put(AppSettings());
      });
    }
  }
}

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  // This will be overridden in main() with an initialized instance
  throw UnimplementedError();
});

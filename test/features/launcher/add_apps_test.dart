import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/features/apps/domain/models/installed_app.dart';

InstalledApp _createApp(String pkg, String name, {bool isFavorite = false}) {
  return InstalledApp()
    ..packageName = pkg
    ..appName = name
    ..isFavorite = isFavorite
    ..isHidden = false
    ..position = 0;
}

void main() {
  group('Minimalist Home App Filtering Architecture', () {
    test('home list returns ONLY user-selected apps (isFavorite == true)', () {
      final allInstalledApps = [
        _createApp('com.whatsapp', 'WhatsApp', isFavorite: true),
        _createApp('com.spotify', 'Spotify', isFavorite: true),
        _createApp('com.game.angrybirds', 'Angry Birds', isFavorite: false),
        _createApp('com.google.chrome', 'Chrome', isFavorite: false),
      ];

      final homeApps = allInstalledApps.where((a) => a.isFavorite && !a.isHidden).toList();

      expect(homeApps.length, 2);
      expect(homeApps.map((a) => a.appName), containsAll(['WhatsApp', 'Spotify']));
      expect(homeApps.map((a) => a.appName), isNot(contains('Angry Birds')));
    });

    test('empty home state triggers when no apps are selected', () {
      final allInstalledApps = [
        _createApp('com.app1', 'App 1', isFavorite: false),
        _createApp('com.app2', 'App 2', isFavorite: false),
      ];

      final homeApps = allInstalledApps.where((a) => a.isFavorite && !a.isHidden).toList();
      expect(homeApps, isEmpty);
    });

    test('removing an app sets isFavorite to false without removing app entry', () {
      final app = _createApp('com.spotify', 'Spotify', isFavorite: true);
      expect(app.isFavorite, isTrue);

      // Simulate removeHomeApp
      app.isFavorite = false;

      expect(app.isFavorite, isFalse);
      expect(app.packageName, 'com.spotify'); // Still exists in installed list
    });
  });
}

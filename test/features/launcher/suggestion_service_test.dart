import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/features/apps/domain/models/installed_app.dart';
import 'package:nudge/features/launcher/domain/services/suggestion_service.dart';

InstalledApp _app(String pkg, String name) {
  return InstalledApp()
    ..packageName = pkg
    ..appName = name
    ..isHidden = false
    ..isFavorite = false
    ..position = 0;
}

void main() {
  group('SuggestionService', () {
    test('returns empty list when apps list is empty', () {
      final result = SuggestionService.suggest(
        apps: [],
        appLaunchCounts: {},
        now: DateTime(2025, 1, 6, 8, 0), // Monday morning
      );
      expect(result, isEmpty);
    });

    test('caps results at maxResults (4)', () {
      final apps = List.generate(
        20,
        (i) => _app('com.test.app$i', 'App $i'),
      );
      // Give them all high launch counts so they score positively
      final counts = {for (int i = 0; i < 20; i++) 'com.test.app$i': 50};

      final result = SuggestionService.suggest(
        apps: apps,
        appLaunchCounts: counts,
        now: DateTime(2025, 1, 6, 8, 0),
      );
      expect(result.length, lessThanOrEqualTo(SuggestionService.maxResults));
    });

    test('morning time boosts calendar/alarm apps', () {
      final apps = [
        _app('com.google.calendar', 'Calendar'),
        _app('com.social.app', 'Instagram'),
        _app('com.note.app', 'Notes'),
      ];
      final result = SuggestionService.suggest(
        apps: apps,
        appLaunchCounts: {},
        now: DateTime(2025, 1, 6, 8, 30), // 8:30 AM weekday
      );
      // Calendar should appear in morning results
      expect(result.map((a) => a.packageName), contains('com.google.calendar'));
    });

    test('evening time boosts social/music apps', () {
      final apps = [
        _app('com.instagram.android', 'Instagram'),
        _app('com.android.calendar', 'Calendar'),
        _app('com.spotify.music', 'Spotify'),
      ];
      final result = SuggestionService.suggest(
        apps: apps,
        appLaunchCounts: {},
        now: DateTime(2025, 1, 6, 19, 0), // 7 PM
      );
      expect(result.isNotEmpty, isTrue);
      // Instagram or Spotify should appear (evening hints match)
      final packages = result.map((a) => a.packageName).toList();
      expect(
        packages.any((p) =>
            p.contains('instagram') ||
            p.contains('spotify')),
        isTrue,
      );
    });

    test('usage frequency boosts apps with high launch counts', () {
      final apps = [
        _app('com.frequent.app', 'Frequent'),
        _app('com.rare.app', 'Rare'),
      ];
      final counts = {
        'com.frequent.app': 100,
        'com.rare.app': 0,
      };
      final result = SuggestionService.suggest(
        apps: apps,
        appLaunchCounts: counts,
        now: DateTime(2025, 1, 6, 8, 0),
      );
      // Frequent app should rank higher
      if (result.length >= 2) {
        expect(result.first.packageName, 'com.frequent.app');
      } else if (result.isNotEmpty) {
        expect(result.first.packageName, 'com.frequent.app');
      }
    });

    test('blocked apps are deprioritised during focus session', () {
      final apps = [
        _app('com.blocked.app', 'Blocked App'),
        _app('com.allowed.calendar', 'Calendar'),
      ];
      final counts = {
        'com.blocked.app': 500, // Very high usage
        'com.allowed.calendar': 1,
      };
      final result = SuggestionService.suggest(
        apps: apps,
        appLaunchCounts: counts,
        blockedPackages: {'com.blocked.app'},
        now: DateTime(2025, 1, 6, 8, 0),
      );
      // Blocked app should not be first despite high usage
      if (result.isNotEmpty) {
        expect(result.first.packageName, isNot('com.blocked.app'));
      }
    });

    test('only returns apps with positive score', () {
      // An app with zero usage and no time hint should score 0
      final apps = [
        _app('com.xyz.obscure', 'Obscure App XYZ'),
      ];
      final result = SuggestionService.suggest(
        apps: apps,
        appLaunchCounts: {},
        now: DateTime(2025, 1, 6, 8, 0),
      );
      // Score should be 0 → not included
      expect(result, isEmpty);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/features/apps/domain/models/installed_app.dart';
import 'package:nudge/features/search/domain/services/search_service.dart';

/// Helper to build an [InstalledApp] without needing Isar open.
InstalledApp _makeApp({
  required String packageName,
  required String appName,
  bool isFavorite = false,
  bool isHidden = false,
  int position = 0,
}) {
  return InstalledApp()
    ..packageName = packageName
    ..appName = appName
    ..isFavorite = isFavorite
    ..isHidden = isHidden
    ..position = position;
}

void main() {
  group('SearchService', () {
    late List<InstalledApp> apps;

    setUp(() {
      apps = [
        _makeApp(packageName: 'com.google.chrome', appName: 'Chrome'),
        _makeApp(packageName: 'com.google.maps', appName: 'Google Maps'),
        _makeApp(packageName: 'com.spotify', appName: 'Spotify'),
        _makeApp(packageName: 'com.whatsapp', appName: 'WhatsApp'),
        _makeApp(packageName: 'com.netflix', appName: 'Netflix'),
        _makeApp(packageName: 'com.calc', appName: 'Calculator'),
        _makeApp(packageName: 'com.camera', appName: 'Camera'),
        _makeApp(packageName: 'com.camscanner', appName: 'CamScanner'),
        _makeApp(packageName: 'com.slack', appName: 'Slack'),
      ];
    });

    test('returns ALL apps for empty query (passthrough)', () {
      final result = SearchService.search(apps, '');
      expect(result.length, apps.length);
    });

    test('returns ALL apps for whitespace-only query (passthrough)', () {
      final result = SearchService.search(apps, '   ');
      expect(result.length, apps.length);
    });

    test('exact match scores highest', () {
      final result = SearchService.search(apps, 'Chrome');
      expect(result.first.appName, 'Chrome');
    });

    test('exact match is case-insensitive', () {
      final result = SearchService.search(apps, 'chrome');
      expect(result.first.appName, 'Chrome');
    });

    test('prefix match comes before substring match', () {
      // "Cal" is a prefix of "Calculator" (score 80), but "alc" is a substring (score 40)
      final result = SearchService.search(apps, 'Cal');
      expect(result.first.appName, 'Calculator');
    });

    test('word-prefix match scores above substring match', () {
      // "Map" is a word-prefix of "Google Maps" (Maps starts with 'map'), score 60
      // It's not a prefix of the whole name (score < 80)
      final result = SearchService.search(apps, 'Map');
      expect(result.any((a) => a.appName == 'Google Maps'), isTrue);
      expect(result.first.appName, 'Google Maps');
    });

    test('substring match finds apps that contain query', () {
      final result = SearchService.search(apps, 'tify');
      expect(result.any((a) => a.appName == 'Spotify'), isTrue);
    });

    test('fuzzy match finds apps by subsequence characters', () {
      // 'sptf' is a subsequence of 'Spotify'
      final result = SearchService.search(apps, 'sptf');
      expect(result.any((a) => a.appName == 'Spotify'), isTrue);
    });

    test('no match returns empty list', () {
      final result = SearchService.search(apps, 'ZZZZ');
      expect(result, isEmpty);
    });

    test('results are ordered by score descending then alphabetically', () {
      // "cam" is a prefix of "Camera" AND "CamScanner" → both score 80
      // Alphabetically "Camera" < "CamScanner"
      final result = SearchService.search(apps, 'cam');
      final names = result.map((a) => a.appName).toList();
      expect(names.indexOf('Camera'), lessThan(names.indexOf('CamScanner')));
    });

    test('search ignores hidden apps when caller filters them', () {
      // SearchService itself doesn't filter hidden—the caller does.
      // Verify that hidden apps appear in results (responsibility for filtering is upstream).
      final allWithHidden = [
        ...apps,
        _makeApp(
          packageName: 'com.hidden',
          appName: 'HiddenApp',
          isHidden: true,
        ),
      ];
      final result = SearchService.search(allWithHidden, 'Hidden');
      expect(result.any((a) => a.appName == 'HiddenApp'), isTrue);
    });

    test('search on an empty app list returns empty', () {
      final result = SearchService.search([], 'Chrome');
      expect(result, isEmpty);
    });
  });

  group('InstalledApp - favorites & hidden toggles (unit logic)', () {
    test('isFavorite defaults to false', () {
      final app = _makeApp(packageName: 'pkg', appName: 'App');
      expect(app.isFavorite, isFalse);
    });

    test('isHidden defaults to false', () {
      final app = _makeApp(packageName: 'pkg', appName: 'App');
      expect(app.isHidden, isFalse);
    });

    test('toggling isFavorite flips value', () {
      final app = _makeApp(packageName: 'pkg', appName: 'App');
      app.isFavorite = !app.isFavorite;
      expect(app.isFavorite, isTrue);
      app.isFavorite = !app.isFavorite;
      expect(app.isFavorite, isFalse);
    });

    test('toggling isHidden flips value', () {
      final app = _makeApp(packageName: 'pkg', appName: 'App');
      app.isHidden = !app.isHidden;
      expect(app.isHidden, isTrue);
    });
  });

  group('App sorting', () {
    test('apps sorted alphabetically by name', () {
      final unsorted = [
        _makeApp(packageName: 'z', appName: 'Zoom'),
        _makeApp(packageName: 'a', appName: 'App'),
        _makeApp(packageName: 'm', appName: 'Maps'),
      ];
      unsorted.sort(
        (a, b) => a.appName.toLowerCase().compareTo(b.appName.toLowerCase()),
      );
      expect(unsorted.map((e) => e.appName).toList(), [
        'App',
        'Maps',
        'Zoom',
      ]);
    });

    test('favorites sorted by position', () {
      final favorites = [
        _makeApp(packageName: 'b', appName: 'B', position: 2),
        _makeApp(packageName: 'a', appName: 'A', position: 0),
        _makeApp(packageName: 'c', appName: 'C', position: 1),
      ];
      favorites.sort((a, b) => a.position.compareTo(b.position));
      expect(favorites.map((e) => e.appName).toList(), ['A', 'C', 'B']);
    });

    test('reorder logic shifts positions correctly', () {
      final favorites = [
        _makeApp(packageName: 'a', appName: 'A', position: 0),
        _makeApp(packageName: 'b', appName: 'B', position: 1),
        _makeApp(packageName: 'c', appName: 'C', position: 2),
      ];

      // Simulate reorder: move index 0 to index 2
      int oldIndex = 0;
      int newIndex = 2; // ReorderableListView emits old+1 when dragging downward
      if (oldIndex < newIndex) newIndex -= 1;

      final item = favorites.removeAt(oldIndex);
      favorites.insert(newIndex, item);

      // Reassign positions
      for (int i = 0; i < favorites.length; i++) {
        favorites[i].position = i;
      }

      expect(favorites[0].appName, 'B');
      expect(favorites[1].appName, 'A');
      expect(favorites[2].appName, 'C');
      expect(favorites[0].position, 0);
      expect(favorites[1].position, 1);
      expect(favorites[2].position, 2);
    });

    test('reorder logic handles moving last item to first', () {
      final favorites = [
        _makeApp(packageName: 'a', appName: 'A', position: 0),
        _makeApp(packageName: 'b', appName: 'B', position: 1),
        _makeApp(packageName: 'c', appName: 'C', position: 2),
      ];

      int oldIndex = 2;
      int newIndex = 0;
      if (oldIndex < newIndex) newIndex -= 1;

      final item = favorites.removeAt(oldIndex);
      favorites.insert(newIndex, item);

      for (int i = 0; i < favorites.length; i++) {
        favorites[i].position = i;
      }

      expect(favorites[0].appName, 'C');
      expect(favorites[1].appName, 'A');
      expect(favorites[2].appName, 'B');
    });
  });

  group('InstalledApp hidden filter', () {
    test('filtering hidden apps excludes isHidden=true', () {
      final apps = [
        _makeApp(packageName: 'a', appName: 'Visible'),
        _makeApp(packageName: 'b', appName: 'Hidden', isHidden: true),
        _makeApp(packageName: 'c', appName: 'AlsoVisible'),
      ];
      final visible = apps.where((a) => !a.isHidden).toList();
      expect(visible.length, 2);
      expect(visible.any((a) => a.appName == 'Hidden'), isFalse);
    });

    test('filtering favorites returns only isFavorite=true', () {
      final apps = [
        _makeApp(packageName: 'a', appName: 'Favorite', isFavorite: true),
        _makeApp(packageName: 'b', appName: 'NotFav'),
        _makeApp(
          packageName: 'c',
          appName: 'AnotherFav',
          isFavorite: true,
          position: 1,
        ),
      ];
      final favs = apps.where((a) => a.isFavorite).toList();
      expect(favs.length, 2);
      expect(favs.every((a) => a.isFavorite), isTrue);
    });
  });
}

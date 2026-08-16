import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/features/apps/domain/models/installed_app.dart';
import 'package:nudge/features/search/domain/models/search_models.dart';
import 'package:nudge/features/search/domain/services/search_service.dart';

void main() {
  group('SearchService Unit Tests', () {
    late List<InstalledApp> testApps;
    late List<Map<String, String>> testContacts;
    late Map<String, int> testLaunchCounts;

    setUp(() {
      testApps = [
        InstalledApp()
          ..id = 1
          ..appName = 'Calendar'
          ..packageName = 'com.android.calendar'
          ..isFavorite = false
          ..isHidden = false
          ..position = 0,
        InstalledApp()
          ..id = 2
          ..appName = 'Camera'
          ..packageName = 'com.android.camera'
          ..isFavorite = false
          ..isHidden = false
          ..position = 1,
        InstalledApp()
          ..id = 3
          ..appName = 'Google Chrome'
          ..packageName = 'com.android.chrome'
          ..isFavorite = false
          ..isHidden = false
          ..position = 2,
        InstalledApp()
          ..id = 4
          ..appName = 'Calculator'
          ..packageName = 'com.android.calculator'
          ..isFavorite = false
          ..isHidden = false
          ..position = 3,
      ];

      testContacts = [
        {'name': 'Alice Smith', 'number': '+15550100'},
        {'name': 'Bob Jones', 'number': '+15550101'},
      ];

      testLaunchCounts = {
        'com.android.calendar': 10,
        'com.android.camera': 5,
        'com.android.chrome': 20,
        'com.android.calculator': 50,
      };
    });

    test('Exact match ranks highest', () {
      final results = SearchService.searchAll(
        apps: testApps,
        contacts: testContacts,
        appLaunchCounts: testLaunchCounts,
        query: 'camera',
      );

      expect(results.first.title, 'Camera');
      expect(results.first.type, SearchItemType.app);
    });

    test('Prefix match ranks above word-prefix or contains match', () {
      final results = SearchService.searchAll(
        apps: testApps,
        contacts: testContacts,
        appLaunchCounts: testLaunchCounts,
        query: 'cal',
      );

      // 'Calendar' and 'Calculator' both start with 'cal'.
      // 'Calculator' has a higher launch count (50 vs 10).
      expect(results[0].title, 'Calculator');
      expect(results[1].title, 'Calendar');
    });

    test('Word prefix match ranks above simple contains match', () {
      final results = SearchService.searchAll(
        apps: testApps,
        contacts: testContacts,
        appLaunchCounts: testLaunchCounts,
        query: 'chrome',
      );

      // 'Google Chrome' contains a word starting with 'chrome'.
      expect(results.first.title, 'Google Chrome');
    });

    test('Fuzzy matching matches by subsequence', () {
      final results = SearchService.searchAll(
        apps: testApps,
        contacts: testContacts,
        appLaunchCounts: testLaunchCounts,
        query: 'cld',
      );

      // 'cld' matches 'Calendar' (C-a-l-en-d-ar).
      expect(results.any((r) => r.title == 'Calendar'), isTrue);
    });

    test('Empty query returns all candidates sorted by usage frequency', () {
      final results = SearchService.searchAll(
        apps: testApps,
        contacts: testContacts,
        appLaunchCounts: testLaunchCounts,
        query: '',
      );

      // Calculator has 50 launches, Chrome has 20, Calendar has 10, Camera has 5.
      // Settings/Actions/Contacts have 0.
      expect(results[0].title, 'Calculator');
      expect(results[1].title, 'Google Chrome');
      expect(results[2].title, 'Calendar');
      expect(results[3].title, 'Camera');
    });

    test('Includes contacts in search results', () {
      final results = SearchService.searchAll(
        apps: testApps,
        contacts: testContacts,
        appLaunchCounts: testLaunchCounts,
        query: 'Alice',
      );

      final contactResults = results.where((r) => r.type == SearchItemType.contact).toList();
      expect(contactResults.length, 1);
      expect(contactResults.first.title, 'Alice Smith');
      expect(contactResults.first.contactNumber, '+15550100');
    });

    test('Includes settings and actions in search results', () {
      final focusResults = SearchService.searchAll(
        apps: testApps,
        contacts: testContacts,
        appLaunchCounts: testLaunchCounts,
        query: 'Focus',
      );
      expect(focusResults.any((r) => r.title == 'Focus Settings'), isTrue);

      final workResults = SearchService.searchAll(
        apps: testApps,
        contacts: testContacts,
        appLaunchCounts: testLaunchCounts,
        query: 'Work',
      );
      expect(workResults.any((r) => r.title == 'Start Work Session'), isTrue);
    });
  });
}

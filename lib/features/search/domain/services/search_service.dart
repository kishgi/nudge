import 'package:nudge/features/apps/domain/models/installed_app.dart';
import '../models/search_models.dart';

class SearchResult {
  SearchResult({required this.item, required this.score});

  final SearchItem item;
  final int score;
}

abstract final class SearchService {
  SearchService._();

  static final List<SearchItem> _staticSettings = [
    SearchItem(type: SearchItemType.setting, title: 'Typography Settings', subtitle: 'Font size, family, weight, spacing', settingRoute: 'typography'),
    SearchItem(type: SearchItemType.setting, title: 'Icon Settings', subtitle: 'Icon packs, size, thickness, opacity', settingRoute: 'icons'),
    SearchItem(type: SearchItemType.setting, title: 'Color Settings', subtitle: 'Background, text, and accent colors', settingRoute: 'colors'),
    SearchItem(type: SearchItemType.setting, title: 'Layout Settings', subtitle: 'Padding, alignment, alignment settings', settingRoute: 'layout'),
    SearchItem(type: SearchItemType.setting, title: 'Clock Settings', subtitle: 'Clock position, date format, styling', settingRoute: 'clock'),
    SearchItem(type: SearchItemType.setting, title: 'Focus Settings', subtitle: 'App blocking, scheduled rules, delays', settingRoute: 'focus'),
    SearchItem(type: SearchItemType.setting, title: 'Themes Preset Manager', subtitle: 'Load, save, or edit theme presets', settingRoute: 'themes'),
    SearchItem(type: SearchItemType.setting, title: 'Wellbeing Dashboard', subtitle: 'Screen time, app stats, daily usage', settingRoute: 'wellbeing'),
  ];

  static final List<SearchItem> _staticActions = [
    SearchItem(type: SearchItemType.action, title: 'Start Work Session', subtitle: 'Launch focus session: Work mode', actionName: 'focus_work'),
    SearchItem(type: SearchItemType.action, title: 'Start Study Session', subtitle: 'Launch focus session: Study mode', actionName: 'focus_study'),
    SearchItem(type: SearchItemType.action, title: 'Start Sleep Session', subtitle: 'Launch focus session: Sleep mode', actionName: 'focus_sleep'),
    SearchItem(type: SearchItemType.action, title: 'Open Wellbeing Dashboard', subtitle: 'View daily screen time & top apps', actionName: 'open_dashboard'),
  ];

  /// compatibility helper for app-only screens and tests.
  static List<InstalledApp> search(List<InstalledApp> apps, String query) {
    if (query.trim().isEmpty) return apps;
    final results = searchAll(
      apps: apps,
      contacts: const [],
      appLaunchCounts: const {},
      query: query,
    );
    return results
        .where((item) => item.type == SearchItemType.app)
        .map((item) => item.app!)
        .toList();
  }

  /// Filters and sorts the indexed items based on [query] and [appLaunchCounts].
  ///
  /// Ranking rules:
  /// 1. Exact match (1,000,000 base score)
  /// 2. Prefix match (800,000 base score)
  /// 3. Word-prefix match (600,000 base score)
  /// 4. Contains/Substring match (400,000 base score)
  /// 5. Fuzzy match (200,000 base score)
  ///
  /// Inside each category, items are ranked by usage frequency (launch count).
  static List<SearchItem> searchAll({
    required List<InstalledApp> apps,
    required List<Map<String, String>> contacts,
    required Map<String, int> appLaunchCounts,
    required String query,
  }) {
    // Collect all candidates
    final List<SearchItem> candidates = [];

    // 1. Add Apps
    for (final app in apps) {
      candidates.add(SearchItem(
        type: SearchItemType.app,
        title: app.appName,
        subtitle: app.packageName,
        app: app,
      ));
    }

    // 2. Add Settings
    candidates.addAll(_staticSettings);

    // 3. Add Actions
    candidates.addAll(_staticActions);

    // 4. Add Contacts
    for (final contact in contacts) {
      final name = contact['name'] ?? '';
      final number = contact['number'] ?? '';
      candidates.add(SearchItem(
        type: SearchItemType.contact,
        title: name,
        subtitle: 'Contact: $number',
        contactNumber: number,
      ));
    }

    if (query.trim().isEmpty) {
      // With no query, return all candidates sorted by usage frequency (launch count)
      final results = candidates.map((item) {
        int freq = 0;
        if (item.type == SearchItemType.app && item.app != null) {
          freq = appLaunchCounts[item.app!.packageName] ?? 0;
        }
        return SearchResult(item: item, score: freq);
      }).toList();

      results.sort((a, b) {
        if (b.score != a.score) {
          return b.score.compareTo(a.score);
        }
        return a.item.title.toLowerCase().compareTo(b.item.title.toLowerCase());
      });

      return results.map((r) => r.item).toList();
    }

    final cleanQuery = query.trim().toLowerCase();
    final List<SearchResult> scoredResults = [];

    for (final item in candidates) {
      final baseScore = _calculateBaseScore(item.title.toLowerCase(), cleanQuery);
      if (baseScore > 0) {
        // Apply launch count frequency boost as a tie-breaker
        int freq = 0;
        if (item.type == SearchItemType.app && item.app != null) {
          freq = appLaunchCounts[item.app!.packageName] ?? 0;
        }
        final finalScore = baseScore + freq;
        scoredResults.add(SearchResult(item: item, score: finalScore));
      }
    }

    scoredResults.sort((a, b) {
      if (b.score != a.score) {
        return b.score.compareTo(a.score);
      }
      return a.item.title.toLowerCase().compareTo(b.item.title.toLowerCase());
    });

    return scoredResults.map((r) => r.item).toList();
  }

  static int _calculateBaseScore(String name, String query) {
    if (name == query) return 1000000;
    if (name.startsWith(query)) return 800000;

    // Word prefix match
    final words = name.split(RegExp(r'\s+'));
    for (final word in words) {
      if (word.startsWith(query)) {
        return 600000;
      }
    }

    if (name.contains(query)) return 400000;

    if (_isSubsequence(name, query)) {
      return 200000;
    }

    return 0;
  }

  static bool _isSubsequence(String name, String query) {
    int nameIdx = 0;
    int queryIdx = 0;

    while (nameIdx < name.length && queryIdx < query.length) {
      if (name[nameIdx] == query[queryIdx]) {
        queryIdx++;
      }
      nameIdx++;
    }

    return queryIdx == query.length;
  }
}

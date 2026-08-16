import 'package:nudge/features/apps/domain/models/installed_app.dart';

/// Combined model representing a search result with its match score.
class SearchResult {
  SearchResult({required this.app, required this.score});

  final InstalledApp app;
  final int score;
}

abstract final class SearchService {
  SearchService._();

  /// Filters and sorts the given [apps] list based on [query].
  ///
  /// Sorting rules:
  /// 1. Exact match first (case-insensitive)
  /// 2. Prefix match next (starts with query)
  /// 3. Word-prefix match (a word inside the app name starts with the query)
  /// 4. Contains match (query is substring)
  /// 5. Fuzzy match (query characters appear in order inside the app name)
  static List<InstalledApp> search(List<InstalledApp> apps, String query) {
    if (query.trim().isEmpty) {
      return apps;
    }

    final cleanQuery = query.trim().toLowerCase();
    final results = <SearchResult>[];

    for (final app in apps) {
      final score = _calculateScore(app.appName.toLowerCase(), cleanQuery);
      if (score > 0) {
        results.add(SearchResult(app: app, score: score));
      }
    }

    // Sort by score descending, then by app name alphabetically (case-insensitive)
    results.sort((a, b) {
      if (b.score != a.score) {
        return b.score.compareTo(a.score);
      }
      return a.app.appName.toLowerCase().compareTo(b.app.appName.toLowerCase());
    });

    return results.map((r) => r.app).toList();
  }

  static int _calculateScore(String name, String query) {
    if (name == query) return 100;
    if (name.startsWith(query)) return 80;

    // Word prefix match
    final words = name.split(RegExp(r'\s+'));
    for (final word in words) {
      if (word.startsWith(query)) {
        return 60;
      }
    }

    if (name.contains(query)) return 40;

    // Fuzzy matching (subsequence check)
    if (_isSubsequence(name, query)) {
      return 20;
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

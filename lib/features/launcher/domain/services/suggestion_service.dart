import 'package:nudge/features/apps/domain/models/installed_app.dart';

/// Local-only smart suggestion engine.
///
/// Ranks installed apps based on:
/// - Time of day (morning, work hours, evening, night)
/// - Day of week (weekday vs weekend)
/// - Usage frequency (launch counts)
/// - Active focus mode (deprioritise blocked apps)
///
/// Returns a capped list of at most [maxResults] suggestions.
/// No network calls are made.
abstract final class SuggestionService {
  SuggestionService._();

  static const int maxResults = 4;

  // Package name fragments and common names for heuristic time-slot matching
  static const _morningHints = [
    'calendar', 'task', 'todo', 'mail', 'email', 'news', 'alarm', 'clock',
    'weather', 'fitness', 'health',
  ];
  static const _workHints = [
    'slack', 'teams', 'meet', 'zoom', 'docs', 'sheets', 'notion', 'linear',
    'jira', 'confluence', 'mail', 'email', 'drive', 'office', 'outlook',
  ];
  static const _eveningHints = [
    'instagram', 'twitter', 'facebook', 'reddit', 'youtube', 'netflix',
    'spotify', 'music', 'podcast', 'social',
  ];
  static const _nightHints = [
    'notes', 'kindle', 'books', 'podcast', 'music', 'spotify', 'calm',
    'headspace', 'meditation', 'sleep',
  ];

  /// Returns up to [maxResults] suggested apps for the given context.
  ///
  /// [apps] — all visible (non-hidden) installed apps.
  /// [appLaunchCounts] — map of packageName → total launches from UsageState.
  /// [blockedPackages] — package names blocked in the current focus session.
  /// [now] — injectable for testing; defaults to [DateTime.now()].
  static List<InstalledApp> suggest({
    required List<InstalledApp> apps,
    required Map<String, int> appLaunchCounts,
    Set<String> blockedPackages = const {},
    DateTime? now,
  }) {
    if (apps.isEmpty) return const [];

    final time = now ?? DateTime.now();
    final hour = time.hour;
    final isWeekend = time.weekday >= 6; // Saturday = 6, Sunday = 7

    final List<String> timeHints;
    if (hour >= 6 && hour < 10) {
      timeHints = _morningHints;
    } else if (hour >= 10 && hour < 18 && !isWeekend) {
      timeHints = _workHints;
    } else if (hour >= 18 && hour < 22) {
      timeHints = _eveningHints;
    } else {
      timeHints = _nightHints;
    }

    final scored = <_ScoredApp>[];

    for (final app in apps) {
      int score = 0;

      // Usage frequency boost (capped to avoid dominating)
      final launches = appLaunchCounts[app.packageName] ?? 0;
      score += (launches * 10).clamp(0, 500);

      // Weekend usage boost for social/entertainment
      if (isWeekend) {
        final pkg = app.packageName.toLowerCase();
        final name = app.appName.toLowerCase();
        if (_eveningHints.any((h) => pkg.contains(h) || name.contains(h))) {
          score += 100;
        }
      }

      // Time-of-day hint matching
      final pkg = app.packageName.toLowerCase();
      final name = app.appName.toLowerCase();
      for (final hint in timeHints) {
        if (pkg.contains(hint) || name.contains(hint)) {
          score += 300;
          break;
        }
      }

      // Deprioritise apps blocked by active focus session
      if (blockedPackages.contains(app.packageName)) {
        score -= 1000;
      }

      scored.add(_ScoredApp(app: app, score: score));
    }

    scored.sort((a, b) {
      if (b.score != a.score) return b.score.compareTo(a.score);
      return a.app.appName.compareTo(b.app.appName);
    });

    return scored
        .where((s) => s.score > 0)
        .take(maxResults)
        .map((s) => s.app)
        .toList();
  }
}

class _ScoredApp {
  const _ScoredApp({required this.app, required this.score});
  final InstalledApp app;
  final int score;
}

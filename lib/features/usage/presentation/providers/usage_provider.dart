import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import '../../../../core/database/database_service.dart';

class UsageState {
  UsageState({
    required this.hasPermission,
    required this.appLaunchCounts,
    required this.todayUsage,
    required this.totalScreenTimeMs,
    required this.weeklyUsage,
    required this.contacts,
    required this.hasContactsPermission,
  });

  final bool hasPermission;
  final Map<String, int> appLaunchCounts;
  final List<Map<String, dynamic>> todayUsage;
  final int totalScreenTimeMs;
  final List<UsageSummary> weeklyUsage;
  final List<Map<String, String>> contacts;
  final bool hasContactsPermission;

  UsageState copyWith({
    bool? hasPermission,
    Map<String, int>? appLaunchCounts,
    List<Map<String, dynamic>>? todayUsage,
    int? totalScreenTimeMs,
    List<UsageSummary>? weeklyUsage,
    List<Map<String, String>>? contacts,
    bool? hasContactsPermission,
  }) {
    return UsageState(
      hasPermission: hasPermission ?? this.hasPermission,
      appLaunchCounts: appLaunchCounts ?? this.appLaunchCounts,
      todayUsage: todayUsage ?? this.todayUsage,
      totalScreenTimeMs: totalScreenTimeMs ?? this.totalScreenTimeMs,
      weeklyUsage: weeklyUsage ?? this.weeklyUsage,
      contacts: contacts ?? this.contacts,
      hasContactsPermission:
          hasContactsPermission ?? this.hasContactsPermission,
    );
  }
}

class UsageNotifier extends Notifier<UsageState> {
  static const _channel = MethodChannel('com.example.nudge/launcher');

  @override
  UsageState build() {
    Future.microtask(refresh);
    return UsageState(
      hasPermission: false,
      appLaunchCounts: {},
      todayUsage: [],
      totalScreenTimeMs: 0,
      weeklyUsage: [],
      contacts: [],
      hasContactsPermission: false,
    );
  }

  DatabaseService get _db => ref.read(databaseServiceProvider);

  Future<void> refresh() async {
    try {
      // 1. Check Usage Permission
      final bool hasUsagePerm =
          await _channel.invokeMethod<bool>('hasUsageStatsPermission') ?? false;

      // 2. Check Contacts Permission
      final bool hasContactsPerm =
          await _channel.invokeMethod<bool>('hasContactsPermission') ?? false;

      List<Map<String, String>> contactsList = [];
      if (hasContactsPerm) {
        final List<dynamic>? rawContacts =
            await _channel.invokeMethod<List<dynamic>>('getContacts');
        if (rawContacts != null) {
          contactsList = rawContacts
              .map((c) => Map<String, String>.from(c as Map))
              .toList();
        }
      }

      if (!hasUsagePerm) {
        state = state.copyWith(
          hasPermission: false,
          hasContactsPermission: hasContactsPerm,
          contacts: contactsList,
        );
        return;
      }

      // 3. Query system usage stats from midnight to now
      final now = DateTime.now();
      final midnight = DateTime(now.year, now.month, now.day);
      final startTimeMs = midnight.millisecondsSinceEpoch;
      final endTimeMs = now.millisecondsSinceEpoch;

      final List<dynamic>? rawStats =
          await _channel.invokeMethod<List<dynamic>>(
        'getAppUsageStats',
        {'startTime': startTimeMs, 'endTime': endTimeMs},
      );

      final List<Map<String, dynamic>> todayStats = [];
      final Map<String, int> launchCounts = {};
      int screenTimeMs = 0;

      if (rawStats != null) {
        for (final stat in rawStats) {
          final map = Map<String, dynamic>.from(stat as Map);
          todayStats.add(map);

          final pkg = map['packageName'] as String;
          final launches = map['launchCount'] as int? ?? 0;
          launchCounts[pkg] = launches;

          final duration = map['totalTimeInForeground'] as int? ?? 0;
          screenTimeMs += duration;
        }
      }

      // Sort today stats by duration descending
      todayStats.sort((a, b) {
        final durationA = a['totalTimeInForeground'] as int? ?? 0;
        final durationB = b['totalTimeInForeground'] as int? ?? 0;
        return durationB.compareTo(durationA);
      });

      // 4. Save today's stats to Isar local daily summary cache
      final appSummaries = todayStats.map((stat) {
        return AppUsageSummary()
          ..packageName = stat['packageName'] as String
          ..durationMs = stat['totalTimeInForeground'] as int? ?? 0
          ..launchCount = stat['launchCount'] as int? ?? 0;
      }).toList();

      final summary = UsageSummary()
        ..date = midnight
        ..totalScreenTimeMs = screenTimeMs
        ..totalFocusTimeMs = 0 // Populated dynamically from sessions
        ..appSummaries = appSummaries;

      await _db.isar.writeTxn(() async {
        await _db.isar.usageSummarys.put(summary);
      });

      // 5. Query weekly stats (last 7 days)
      final sevenDaysAgo = midnight.subtract(const Duration(days: 6));
      final allWeekly = await _db.isar.usageSummarys.where().findAll();
      final weeklySummaries = allWeekly
          .where((s) =>
              !s.date.isBefore(sevenDaysAgo.subtract(const Duration(seconds: 1))))
          .toList()
        ..sort((a, b) => a.date.compareTo(b.date));

      state = UsageState(
        hasPermission: true,
        appLaunchCounts: launchCounts,
        todayUsage: todayStats,
        totalScreenTimeMs: screenTimeMs,
        weeklyUsage: weeklySummaries,
        contacts: contactsList,
        hasContactsPermission: hasContactsPerm,
      );
    } catch (_) {
      // Gracefully catch exceptions during test/mock runs
      state = state.copyWith(hasPermission: false);
    }
  }

  Future<void> requestUsagePermission() async {
    try {
      await _channel.invokeMethod('requestUsageStatsPermission');
    } catch (_) {
      // Ignored in test environment
    }
  }

  Future<void> requestContactsPermission() async {
    try {
      await _channel.invokeMethod('requestContactsPermission');
    } catch (_) {}
  }

  Future<void> dialNumber(String number) async {
    try {
      await _channel.invokeMethod('dialNumber', {'number': number});
    } catch (_) {}
  }
}

final usageProvider =
    NotifierProvider<UsageNotifier, UsageState>(UsageNotifier.new);

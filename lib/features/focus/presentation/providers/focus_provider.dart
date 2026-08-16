import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import '../../../../core/database/database_service.dart';

class FocusState {
  FocusState({
    required this.rules,
    this.activeSession,
  });

  final List<FocusRule> rules;
  final FocusSession? activeSession;

  FocusState copyWith({
    List<FocusRule>? rules,
    FocusSession? activeSession,
    bool clearActiveSession = false,
  }) {
    return FocusState(
      rules: rules ?? this.rules,
      activeSession:
          clearActiveSession ? null : (activeSession ?? this.activeSession),
    );
  }
}

class FocusNotifier extends Notifier<FocusState> {
  @override
  FocusState build() {
    // Kick off async load; return empty state immediately for sync build.
    Future.microtask(load);
    return FocusState(rules: []);
  }

  DatabaseService get _db => ref.read(databaseServiceProvider);

  Future<void> load() async {
    final rules = await _db.isar.focusRules.where().findAll();

    // Find active session — filter completed=false in memory for simplicity.
    final sessions = await _db.isar.focusSessions.where().findAll();

    FocusSession? active;
    for (final s in sessions) {
      if (s.isCompleted) continue;
      if (s.isActive) {
        active = s;
        break;
      } else {
        // Auto-complete expired sessions
        s.isCompleted = true;
        s.endTime = s.startTime.add(Duration(minutes: s.targetDurationMinutes));
        await _db.isar.writeTxn(() => _db.isar.focusSessions.put(s));
      }
    }

    state = FocusState(rules: rules, activeSession: active);
  }

  Future<void> toggleRule(String packageName, bool isBlocked) async {
    var rule = state.rules.firstWhere(
      (r) => r.packageName == packageName,
      orElse: () => FocusRule()..packageName = packageName,
    );

    rule.isBlocked = isBlocked;
    await _db.isar.writeTxn(() async {
      await _db.isar.focusRules.put(rule);
    });
    await load();
  }

  Future<void> setRuleDelay(String packageName, int delaySeconds) async {
    var rule = state.rules.firstWhere(
      (r) => r.packageName == packageName,
      orElse: () => FocusRule()..packageName = packageName,
    );

    rule.delaySeconds = delaySeconds;
    await _db.isar.writeTxn(() async {
      await _db.isar.focusRules.put(rule);
    });
    await load();
  }

  Future<void> setRuleSchedule(
    String packageName, {
    required bool enabled,
    required List<int> days,
    required int startH,
    required int startM,
    required int endH,
    required int endM,
  }) async {
    var rule = state.rules.firstWhere(
      (r) => r.packageName == packageName,
      orElse: () => FocusRule()..packageName = packageName,
    );

    rule.scheduleEnabled = enabled;
    rule.scheduleDays = days;
    rule.startHour = startH;
    rule.startMinute = startM;
    rule.endHour = endH;
    rule.endMinute = endM;

    await _db.isar.writeTxn(() async {
      await _db.isar.focusRules.put(rule);
    });
    await load();
  }

  Future<void> updateRuleMessage(String packageName, String message) async {
    var rule = state.rules.firstWhere(
      (r) => r.packageName == packageName,
      orElse: () => FocusRule()..packageName = packageName,
    );

    rule.customMessage = message;
    await _db.isar.writeTxn(() async {
      await _db.isar.focusRules.put(rule);
    });
    await load();
  }

  Future<void> startFocusSession(String mode, int durationMinutes,
      {String? customName}) async {
    // End any current active sessions
    if (state.activeSession != null) {
      await cancelFocusSession();
    }

    final session = FocusSession()
      ..mode = mode
      ..customName = customName
      ..startTime = DateTime.now()
      ..targetDurationMinutes = durationMinutes
      ..isCompleted = false;

    await _db.isar.writeTxn(() async {
      await _db.isar.focusSessions.put(session);
    });
    await load();
  }

  Future<void> cancelFocusSession() async {
    final active = state.activeSession;
    if (active != null) {
      active.isCompleted = true;
      active.endTime = DateTime.now();
      await _db.isar.writeTxn(() async {
        await _db.isar.focusSessions.put(active);
      });
    }
    await load();
  }

  /// Determines if an app is currently blocked.
  /// An app is blocked if:
  /// 1. There is an active FocusSession AND the app is configured to be blocked.
  /// 2. OR, there is no active session, but the app's FocusRule is currently active (schedule match).
  FocusRule? getActiveBlockRule(String packageName, DateTime time) {
    final rule = state.rules.firstWhere(
      (r) => r.packageName == packageName,
      orElse: () => FocusRule()..packageName = packageName,
    );

    if (!rule.isBlocked) return null;

    final hasSession = state.activeSession != null && state.activeSession!.isActive;
    if (hasSession) {
      // During focus session, blocked apps are blocked 100% of the time.
      return rule;
    }

    if (rule.isActiveAt(time)) {
      return rule;
    }

    return null;
  }
}

final focusProvider =
    NotifierProvider<FocusNotifier, FocusState>(FocusNotifier.new);

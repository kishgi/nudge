import 'package:isar_community/isar.dart';

part 'focus_models.g.dart';

@collection
class FocusRule {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String packageName;

  bool isBlocked = false;
  int delaySeconds = 0; // Configurable opening delay in seconds
  bool scheduleEnabled = false;

  // 1 = Monday, 7 = Sunday. Stores days on which this rule is active.
  List<int> scheduleDays = [];

  int startHour = 0;
  int startMinute = 0;
  int endHour = 0;
  int endMinute = 0;

  String? customMessage;

  /// Checks if this rule is currently active based on target time and day of week.
  bool isActiveAt(DateTime dateTime) {
    if (!isBlocked) return false;
    if (!scheduleEnabled) return true; // Blocked always if schedule is disabled but isBlocked is true

    final day = dateTime.weekday;
    if (scheduleDays.isNotEmpty && !scheduleDays.contains(day)) {
      return false;
    }

    final currentMinutes = dateTime.hour * 60 + dateTime.minute;
    final startMinutes = startHour * 60 + startMinute;
    final endMinutes = endHour * 60 + endMinute;

    if (startMinutes <= endMinutes) {
      return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
    } else {
      // Over-midnight schedule
      return currentMinutes >= startMinutes || currentMinutes <= endMinutes;
    }
  }
}

@collection
class FocusSession {
  Id id = Isar.autoIncrement;

  late String mode; // 'Work', 'Study', 'Sleep', 'Custom'
  String? customName;
  late DateTime startTime;
  DateTime? endTime;
  int targetDurationMinutes = 0;
  bool isCompleted = false;

  bool get isActive {
    if (endTime != null || isCompleted) return false;
    // Auto-expire if duration has passed
    final now = DateTime.now();
    final elapsed = now.difference(startTime).inMinutes;
    if (elapsed >= targetDurationMinutes) {
      return false;
    }
    return true;
  }
}

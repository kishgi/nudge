import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/features/focus/domain/models/focus_models.dart';

void main() {
  group('FocusRule Schedule Boundary Condition Tests', () {
    test('isBlocked = false always returns false', () {
      final rule = FocusRule()
        ..packageName = 'com.test.app'
        ..isBlocked = false
        ..scheduleEnabled = false;

      expect(rule.isActiveAt(DateTime(2026, 8, 16, 12, 0)), isFalse);
    });

    test('isBlocked = true and scheduleEnabled = false always returns true', () {
      final rule = FocusRule()
        ..packageName = 'com.test.app'
        ..isBlocked = true
        ..scheduleEnabled = false;

      expect(rule.isActiveAt(DateTime(2026, 8, 16, 12, 0)), isTrue);
    });

    test('Normal schedule (same day: 09:00 - 17:00)', () {
      final rule = FocusRule()
        ..packageName = 'com.test.app'
        ..isBlocked = true
        ..scheduleEnabled = true;

      // 09:00 to 17:00
      rule.startHour = 9;
      rule.startMinute = 0;
      rule.endHour = 17;
      rule.endMinute = 0;
      rule.scheduleDays = [1, 2, 3, 4, 5]; // Mon-Fri

      // Mon, Aug 17, 2026 is a Monday (weekday = 1)
      final mondayActive = DateTime(2026, 8, 17, 12, 0); // 12:00
      final mondayInactive = DateTime(2026, 8, 17, 18, 0); // 18:00
      // Sunday, Aug 16, 2026 is a Sunday (weekday = 7)
      final sundayTime = DateTime(2026, 8, 16, 12, 0);

      expect(rule.isActiveAt(mondayActive), isTrue);
      expect(rule.isActiveAt(mondayInactive), isFalse);
      expect(rule.isActiveAt(sundayTime), isFalse);
    });

    test('Midnight boundary condition (over midnight: 22:00 - 06:00)', () {
      final rule = FocusRule()
        ..packageName = 'com.test.app'
        ..isBlocked = true
        ..scheduleEnabled = true;

      // 22:00 to 06:00 next day
      rule.startHour = 22;
      rule.startMinute = 0;
      rule.endHour = 6;
      rule.endMinute = 0;
      rule.scheduleDays = []; // All days

      final timeBeforeMidnight = DateTime(2026, 8, 16, 23, 30); // 23:30 (active)
      final timeAfterMidnight = DateTime(2026, 8, 17, 2, 0); // 02:00 (active)
      final timeOutside = DateTime(2026, 8, 17, 12, 0); // 12:00 (inactive)

      expect(rule.isActiveAt(timeBeforeMidnight), isTrue);
      expect(rule.isActiveAt(timeAfterMidnight), isTrue);
      expect(rule.isActiveAt(timeOutside), isFalse);
    });

    test('Day of week boundary check', () {
      final rule = FocusRule()
        ..packageName = 'com.test.app'
        ..isBlocked = true
        ..scheduleEnabled = true;

      rule.startHour = 0;
      rule.startMinute = 0;
      rule.endHour = 23;
      rule.endMinute = 59;
      rule.scheduleDays = [7]; // Sunday only

      // Aug 16, 2026 is a Sunday (weekday = 7)
      expect(rule.isActiveAt(DateTime(2026, 8, 16, 12, 0)), isTrue);
      // Aug 17, 2026 is a Monday (weekday = 1)
      expect(rule.isActiveAt(DateTime(2026, 8, 17, 12, 0)), isFalse);
    });
  });
}

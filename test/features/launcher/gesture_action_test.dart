import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/features/launcher/domain/gesture_action.dart';

void main() {
  group('GestureAction', () {
    test('fromKey returns correct action for all valid keys', () {
      expect(GestureAction.fromKey('drawer'), GestureAction.drawer);
      expect(GestureAction.fromKey('search'), GestureAction.search);
      expect(GestureAction.fromKey('lockScreen'), GestureAction.lockScreen);
      expect(GestureAction.fromKey('settings'), GestureAction.settings);
      expect(GestureAction.fromKey('none'), GestureAction.none);
    });

    test('fromKey falls back to none for unknown strings', () {
      expect(GestureAction.fromKey(''), GestureAction.none);
      expect(GestureAction.fromKey('unknown_gesture'), GestureAction.none);
      expect(GestureAction.fromKey('DRAWER'), GestureAction.none); // case-sensitive
    });

    test('key property returns the enum name', () {
      expect(GestureAction.drawer.key, 'drawer');
      expect(GestureAction.search.key, 'search');
      expect(GestureAction.lockScreen.key, 'lockScreen');
      expect(GestureAction.settings.key, 'settings');
      expect(GestureAction.none.key, 'none');
    });

    test('label is non-empty for all actions', () {
      for (final action in GestureAction.values) {
        expect(action.label, isNotEmpty,
            reason: 'Label for ${action.name} should not be empty');
      }
    });

    test('roundtrip: fromKey(action.key) == action for all values', () {
      for (final action in GestureAction.values) {
        expect(GestureAction.fromKey(action.key), action,
            reason: 'fromKey(${action.key}) should return $action');
      }
    });

    test('default gesture map returns all expected bindings', () {
      const defaults = {
        'swipeUp': 'drawer',
        'swipeDown': 'search',
        'doubleTap': 'lockScreen',
        'longPress': 'settings',
      };
      for (final entry in defaults.entries) {
        final action = GestureAction.fromKey(entry.value);
        expect(action, isNot(GestureAction.none),
            reason: '${entry.key}=${entry.value} should not resolve to none');
      }
    });
  });
}

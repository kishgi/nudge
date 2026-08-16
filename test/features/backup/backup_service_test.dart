import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/features/backup/domain/models/nudge_backup.dart';

void main() {
  group('NudgeBackup Model', () {
    test('encode and decode roundtrip preserves backup structure', () {
      final backup = NudgeBackup(
        version: 1,
        createdAt: '2026-08-16T12:00:00Z',
        appSettings: {'drawerSortMode': 'mostUsed', 'showSmartSuggestions': true},
        themes: [
          {'name': 'Custom OLED', 'colorPreset': 'oled', 'isCustom': true}
        ],
        favorites: [
          {'packageName': 'com.app.one', 'position': 0}
        ],
        hiddenApps: ['com.app.hidden'],
        focusRules: [
          {'packageName': 'com.app.blocked', 'isBlocked': true, 'delaySeconds': 10}
        ],
      );

      final encoded = backup.encode();
      expect(encoded, contains('"app": "nudge"'));
      expect(encoded, contains('"version": 1'));

      final decoded = NudgeBackup.decode(encoded);
      expect(decoded.version, 1);
      expect(decoded.appSettings['drawerSortMode'], 'mostUsed');
      expect(decoded.themes.length, 1);
      expect(decoded.themes.first['name'], 'Custom OLED');
      expect(decoded.favorites.length, 1);
      expect(decoded.hiddenApps, contains('com.app.hidden'));
      expect(decoded.focusRules.length, 1);
      expect(decoded.focusRules.first['delaySeconds'], 10);
    });

    test('decode throws FormatException for invalid app header', () {
      const invalidJson = '''
      {
        "app": "not_nudge",
        "version": 1,
        "created_at": "2026-08-16T12:00:00Z"
      }
      ''';
      expect(() => NudgeBackup.decode(invalidJson), throwsFormatException);
    });

    test('decode throws FormatException for unsupported future version', () {
      const futureVersionJson = '''
      {
        "app": "nudge",
        "version": 99,
        "created_at": "2026-08-16T12:00:00Z"
      }
      ''';
      expect(() => NudgeBackup.decode(futureVersionJson), throwsFormatException);
    });

    test('decode handles empty or missing optional sections gracefully', () {
      const minimalJson = '''
      {
        "app": "nudge",
        "version": 1
      }
      ''';
      final decoded = NudgeBackup.decode(minimalJson);
      expect(decoded.version, 1);
      expect(decoded.themes, isEmpty);
      expect(decoded.favorites, isEmpty);
      expect(decoded.hiddenApps, isEmpty);
      expect(decoded.focusRules, isEmpty);
    });
  });
}

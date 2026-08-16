import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/features/launcher/domain/models/home_widget_config.dart';

void main() {
  group('HomeWidgetType', () {
    test('fromKey returns correct type for all valid keys', () {
      expect(HomeWidgetType.fromKey('clock'), HomeWidgetType.clock);
      expect(HomeWidgetType.fromKey('date'), HomeWidgetType.date);
      expect(HomeWidgetType.fromKey('battery'), HomeWidgetType.battery);
      expect(HomeWidgetType.fromKey('focusTimer'), HomeWidgetType.focusTimer);
    });

    test('fromKey returns null for unknown keys', () {
      expect(HomeWidgetType.fromKey(''), isNull);
      expect(HomeWidgetType.fromKey('unknown'), isNull);
      expect(HomeWidgetType.fromKey('CLOCK'), isNull); // case-sensitive
    });

    test('label and description are non-empty for all types', () {
      for (final type in HomeWidgetType.values) {
        expect(type.label, isNotEmpty);
        expect(type.description, isNotEmpty);
      }
    });

    test('key roundtrip: fromKey(type.key) == type', () {
      for (final type in HomeWidgetType.values) {
        expect(HomeWidgetType.fromKey(type.key), type);
      }
    });
  });

  group('HomeWidgetConfig', () {
    test('toJson/fromJson roundtrip preserves type and visibility', () {
      final config = HomeWidgetConfig(type: HomeWidgetType.battery, visible: false);
      final json = config.toJson();
      final restored = HomeWidgetConfig.fromJson(json);
      expect(restored, isNotNull);
      expect(restored!.type, HomeWidgetType.battery);
      expect(restored.visible, isFalse);
    });

    test('fromJson returns null for unknown type key', () {
      final result = HomeWidgetConfig.fromJson({'type': 'nonExistent', 'visible': true});
      expect(result, isNull);
    });

    test('fromJson defaults visible to true when field is missing', () {
      final result = HomeWidgetConfig.fromJson({'type': 'clock'});
      expect(result, isNotNull);
      expect(result!.visible, isTrue);
    });
  });

  group('HomeWidgetConfigList', () {
    test('encode then decode roundtrip preserves order and visibility', () {
      final configs = [
        HomeWidgetConfig(type: HomeWidgetType.battery, visible: true),
        HomeWidgetConfig(type: HomeWidgetType.clock, visible: false),
        HomeWidgetConfig(type: HomeWidgetType.focusTimer, visible: true),
        HomeWidgetConfig(type: HomeWidgetType.date, visible: false),
      ];
      final encoded = HomeWidgetConfigList.encode(configs);
      final decoded = HomeWidgetConfigList.decode(encoded);

      // Encoded types are in the same order as the source list
      expect(decoded.first.type, HomeWidgetType.battery);
      expect(decoded[1].type, HomeWidgetType.clock);
      expect(decoded[1].visible, isFalse);
    });

    test('decode with empty JSON returns defaults (all visible)', () {
      final decoded = HomeWidgetConfigList.decode('[]');
      expect(decoded.length, HomeWidgetType.values.length);
      expect(decoded.every((c) => c.visible), isTrue);
    });

    test('decode with malformed JSON returns defaults', () {
      final decoded = HomeWidgetConfigList.decode('not_valid_json');
      expect(decoded.length, HomeWidgetType.values.length);
    });

    test('decode fills in missing widget types as hidden', () {
      // Only encode clock widget
      final partial = HomeWidgetConfigList.encode([
        HomeWidgetConfig(type: HomeWidgetType.clock, visible: true),
      ]);
      final decoded = HomeWidgetConfigList.decode(partial);
      // All 4 types should be present
      expect(decoded.length, HomeWidgetType.values.length);
      // Missing ones are added as not visible
      final missing = decoded.where((c) => c.type != HomeWidgetType.clock).toList();
      expect(missing.every((c) => !c.visible), isTrue);
    });

    test('visible filter excludes hidden widgets', () {
      final configs = HomeWidgetConfigList.defaults;
      configs[0].visible = false;
      configs[2].visible = false;
      final visible = configs.where((c) => c.visible).toList();
      expect(visible.length, 2);
    });

    test('defaults contains all HomeWidgetType values', () {
      final defaults = HomeWidgetConfigList.defaults;
      final types = defaults.map((c) => c.type).toSet();
      for (final type in HomeWidgetType.values) {
        expect(types, contains(type));
      }
    });
  });
}

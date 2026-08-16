import 'dart:convert';

/// Widget types available on the home screen.
enum HomeWidgetType {
  clock,
  date,
  battery,
  focusTimer;

  String get label => switch (this) {
        HomeWidgetType.clock => 'Clock',
        HomeWidgetType.date => 'Date',
        HomeWidgetType.battery => 'Battery',
        HomeWidgetType.focusTimer => 'Focus Timer',
      };

  String get description => switch (this) {
        HomeWidgetType.clock => 'Current time with your clock style',
        HomeWidgetType.date => 'Today\'s date with your date format',
        HomeWidgetType.battery => 'Battery level and charging status',
        HomeWidgetType.focusTimer => 'Countdown for active focus sessions',
      };

  static HomeWidgetType? fromKey(String key) => switch (key) {
        'clock' => HomeWidgetType.clock,
        'date' => HomeWidgetType.date,
        'battery' => HomeWidgetType.battery,
        'focusTimer' => HomeWidgetType.focusTimer,
        _ => null,
      };

  String get key => name;
}

/// Configuration for a single home widget entry.
class HomeWidgetConfig {
  HomeWidgetConfig({
    required this.type,
    this.visible = true,
  });

  final HomeWidgetType type;
  bool visible;

  Map<String, dynamic> toJson() => {
        'type': type.key,
        'visible': visible,
      };

  static HomeWidgetConfig? fromJson(Map<String, dynamic> json) {
    final type = HomeWidgetType.fromKey(json['type'] as String? ?? '');
    if (type == null) return null;
    return HomeWidgetConfig(
      type: type,
      visible: json['visible'] as bool? ?? true,
    );
  }
}

/// Helpers to serialise / deserialise the ordered widget list stored as JSON
/// in [AppSettings.homeWidgetsJson].
abstract final class HomeWidgetConfigList {
  HomeWidgetConfigList._();

  /// The canonical default order — all widgets visible.
  static List<HomeWidgetConfig> get defaults => [
        HomeWidgetConfig(type: HomeWidgetType.clock),
        HomeWidgetConfig(type: HomeWidgetType.date),
        HomeWidgetConfig(type: HomeWidgetType.battery),
        HomeWidgetConfig(type: HomeWidgetType.focusTimer),
      ];

  static String encode(List<HomeWidgetConfig> configs) {
    return jsonEncode(configs.map((c) => c.toJson()).toList());
  }

  static List<HomeWidgetConfig> decode(String json) {
    if (json.isEmpty || json == '[]') return defaults;
    try {
      final list = jsonDecode(json) as List<dynamic>;
      final configs = list
          .map((e) => HomeWidgetConfig.fromJson(e as Map<String, dynamic>))
          .whereType<HomeWidgetConfig>()
          .toList();
      // Ensure all types are represented (add missing ones at end as hidden)
      final present = configs.map((c) => c.type).toSet();
      for (final type in HomeWidgetType.values) {
        if (!present.contains(type)) {
          configs.add(HomeWidgetConfig(type: type, visible: false));
        }
      }
      return configs;
    } catch (_) {
      return defaults;
    }
  }
}

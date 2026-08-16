import 'dart:convert';

/// Root container model for Nudge local backup export/import.
/// Version 1 structure containing settings, themes, favorites, hidden apps, and focus rules.
class NudgeBackup {
  NudgeBackup({
    this.version = 1,
    required this.createdAt,
    required this.appSettings,
    required this.themes,
    required this.favorites,
    required this.hiddenApps,
    required this.focusRules,
  });

  final int version;
  final String createdAt;
  final Map<String, dynamic> appSettings;
  final List<Map<String, dynamic>> themes;
  final List<Map<String, dynamic>> favorites;
  final List<String> hiddenApps;
  final List<Map<String, dynamic>> focusRules;

  Map<String, dynamic> toJson() => {
        'app': 'nudge',
        'version': version,
        'created_at': createdAt,
        'app_settings': appSettings,
        'themes': themes,
        'favorites': favorites,
        'hidden_apps': hiddenApps,
        'focus_rules': focusRules,
      };

  factory NudgeBackup.fromJson(Map<String, dynamic> json) {
    if (json['app'] != 'nudge') {
      throw FormatException('Invalid backup file: missing "nudge" app header');
    }
    final ver = json['version'] as int? ?? 1;
    if (ver > 1) {
      throw FormatException('Backup file version $ver is not supported by this version of Nudge');
    }

    return NudgeBackup(
      version: ver,
      createdAt: json['created_at'] as String? ?? DateTime.now().toIso8601String(),
      appSettings: Map<String, dynamic>.from(json['app_settings'] as Map? ?? {}),
      themes: (json['themes'] as List? ?? [])
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
      favorites: (json['favorites'] as List? ?? [])
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
      hiddenApps: (json['hidden_apps'] as List? ?? []).cast<String>(),
      focusRules: (json['focus_rules'] as List? ?? [])
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
    );
  }

  String encode() => const JsonEncoder.withIndent('  ').convert(toJson());

  static NudgeBackup decode(String jsonString) {
    final Map<String, dynamic> map = jsonDecode(jsonString) as Map<String, dynamic>;
    return NudgeBackup.fromJson(map);
  }
}

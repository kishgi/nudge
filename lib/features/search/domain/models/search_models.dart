import 'package:nudge/features/apps/domain/models/installed_app.dart';

enum SearchItemType { app, action, setting, contact }

class SearchItem {
  SearchItem({
    required this.type,
    required this.title,
    required this.subtitle,
    this.app,
    this.actionName,
    this.settingRoute,
    this.contactNumber,
  });

  final SearchItemType type;
  final String title;
  final String subtitle;

  final InstalledApp? app;
  final String? actionName;
  final String? settingRoute;
  final String? contactNumber;

  @override
  String toString() => 'SearchItem(type: $type, title: $title)';
}

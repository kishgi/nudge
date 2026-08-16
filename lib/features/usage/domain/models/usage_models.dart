import 'package:isar_community/isar.dart';

part 'usage_models.g.dart';

@embedded
class AppUsageSummary {
  String? packageName;
  String? appName;
  int? durationMs;
  int? launchCount;
}

@collection
class UsageSummary {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late DateTime date; // Normalized to midnight

  int totalScreenTimeMs = 0;
  int totalFocusTimeMs = 0;

  List<AppUsageSummary> appSummaries = [];
}

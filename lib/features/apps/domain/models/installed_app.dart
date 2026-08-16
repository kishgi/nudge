import 'package:isar_community/isar.dart';

part 'installed_app.g.dart';

@collection
class InstalledApp {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String packageName;

  late String appName;

  /// App category seeded from Android's ApplicationInfo.category.
  /// One of: 'Game', 'Audio', 'Video', 'Image', 'Social', 'News',
  /// 'Maps', 'Productivity', 'Other'.
  String category = 'Other';

  bool isFavorite = false;
  bool isHidden = false;
  int position = 0; // position in favorites list
}

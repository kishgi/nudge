import 'package:isar/isar.dart';

part 'installed_app.g.dart';

@collection
class InstalledApp {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String packageName;

  late String appName;

  bool isFavorite = false;
  bool isHidden = false;
  int position = 0; // position in favorites list
}

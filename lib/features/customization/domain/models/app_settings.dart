import 'package:isar/isar.dart';

part 'app_settings.g.dart';

@collection
class AppSettings {
  Id id = Isar.autoIncrement;

  String themePresetName = 'pure';
  String layoutMode = 'TEXT'; // TEXT, ICON, HYBRID
  
  bool showDate = true;
  bool showTime = true;
}

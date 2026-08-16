import 'package:isar/isar.dart';

part 'app_settings.g.dart';

/// Global launcher settings (layout mode, active theme reference).
/// Appearance details are stored in [ThemeConfig].
@collection
class AppSettings {
  Id id = Isar.autoIncrement;

  /// References the Id of the active [ThemeConfig] row.
  /// Null means "use the default Pure preset config".
  int? activeThemeConfigId;
}

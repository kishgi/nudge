import 'package:isar_community/isar.dart';

part 'app_settings.g.dart';

/// Global launcher settings (layout mode, gestures, widgets, active theme).
/// Appearance details are stored in [ThemeConfig].
@collection
class AppSettings {
  Id id = Isar.autoIncrement;

  /// References the Id of the active [ThemeConfig] row.
  /// Null means "use the default Pure preset config".
  int? activeThemeConfigId;

  // ─── Gestures ──────────────────────────────────────────────────────────────
  // Possible values: 'drawer', 'search', 'lockScreen', 'settings', 'none'

  String gestureSwipeUp = 'drawer';
  String gestureSwipeDown = 'search';
  String gestureDoubleTap = 'lockScreen';
  String gestureLongPress = 'settings';

  // ─── App Drawer ────────────────────────────────────────────────────────────
  // Possible values: 'alphabetical', 'mostUsed', 'favorites', 'categories'

  String drawerSortMode = 'alphabetical';

  /// Last scroll offset of the drawer list — restored on reopen.
  double drawerScrollOffset = 0.0;

  // ─── Smart Suggestions ────────────────────────────────────────────────────

  bool showSmartSuggestions = true;

  // ─── Home Widgets ─────────────────────────────────────────────────────────

  /// JSON-serialised ordered list of home widget configs.
  /// Format: '[{"type":"clock","visible":true}, ...]'
  String homeWidgetsJson = '[]';

  /// Vertical gap between home widgets in logical pixels.
  double widgetSpacing = 8.0;

  /// Widget strip alignment. One of: 'left', 'center', 'right'.
  String widgetAlignment = 'left';
}

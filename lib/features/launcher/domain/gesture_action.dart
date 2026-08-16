/// Represents the action that can be bound to a home-screen gesture.
enum GestureAction {
  drawer,
  search,
  lockScreen,
  settings,
  none;

  /// Human-readable label shown in the settings UI.
  String get label => switch (this) {
        GestureAction.drawer => 'Open App Drawer',
        GestureAction.search => 'Open Search',
        GestureAction.lockScreen => 'Lock Screen',
        GestureAction.settings => 'Open Settings',
        GestureAction.none => 'Do Nothing',
      };

  /// Parses a stored string key back to the enum value.
  /// Falls back to [GestureAction.none] for unknown strings.
  static GestureAction fromKey(String key) => switch (key) {
        'drawer' => GestureAction.drawer,
        'search' => GestureAction.search,
        'lockScreen' => GestureAction.lockScreen,
        'settings' => GestureAction.settings,
        _ => GestureAction.none,
      };

  String get key => name;
}

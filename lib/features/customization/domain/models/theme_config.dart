import 'package:isar_community/isar.dart';

part 'theme_config.g.dart';

/// Complete appearance configuration for one Nudge theme.
///
/// This is the single source of truth for all visual settings.
/// Custom themes are stored as rows in this collection.
/// Built-in presets are seeded at startup if absent.
@collection
class ThemeConfig {
  Id id = Isar.autoIncrement;

  /// Human-readable name. Built-in presets use their preset name.
  late String name;

  /// Whether this is a user-created custom theme (can be edited/deleted).
  bool isCustom = false;

  // ─── Typography ────────────────────────────────────────────────────────────

  /// Font family identifier. Use values from NudgeFontFamily.id.
  /// Defaults to 'Inter'. Use 'system' for the Android default font.
  String fontFamily = 'Inter';

  /// Font weight (100–900). Clamped to available weights per font.
  int fontWeight = 400;

  /// Multiplier applied to all base font sizes. Range: 0.8–1.5.
  double fontSizeScale = 1.0;

  /// Delta added to all base letter-spacing values. Range: -0.5 to +2.0.
  double letterSpacingDelta = 0.0;

  /// Multiplier applied to all line-height values. Range: 0.9–2.0.
  double lineHeightScale = 1.0;

  /// Text alignment for app labels. One of: 'left', 'center', 'right'.
  String textAlignment = 'left';

  /// Text case transform for app labels. One of: 'none', 'upper', 'lower'.
  String textCase = 'none';

  // ─── Icons ─────────────────────────────────────────────────────────────────

  /// Icon pack identifier. One of: 'material', 'lucide', 'phosphor',
  /// 'tabler', 'remix'.
  String iconPack = 'material';

  /// Icon size in logical pixels. Range: 16.0–40.0.
  double iconSize = 20.0;

  /// Stroke thickness for packs that support it (lucide, tabler, phosphor-outline).
  /// Range: 1.0–2.5. Ignored for packs that don't support it.
  double iconThickness = 1.5;

  /// Icon style. One of: 'outline', 'filled'.
  /// Not all packs support both.
  String iconStyle = 'outline';

  /// Icon color as ARGB int. Null means "use primaryText color".
  int? iconColorValue;

  /// Icon opacity. Range: 0.3–1.0.
  double iconOpacity = 1.0;

  // ─── Colors ────────────────────────────────────────────────────────────────

  /// Color preset identifier. One of: 'light', 'dark', 'oled', 'custom'.
  /// When 'custom', the individual color fields below are used.
  String colorPreset = 'dark';

  /// Background color as ARGB int. Used only when colorPreset == 'custom'.
  int? backgroundColorValue;

  /// Primary text color as ARGB int. Used only when colorPreset == 'custom'.
  int? primaryTextColorValue;

  /// Secondary text color as ARGB int. Used only when colorPreset == 'custom'.
  int? secondaryTextColorValue;

  /// Accent color as ARGB int. Used only when colorPreset == 'custom'.
  int? accentColorValue;

  // ─── Layout ────────────────────────────────────────────────────────────────

  /// Horizontal padding in logical pixels. Range: 12.0–48.0.
  double horizontalPadding = 24.0;

  /// Vertical spacing between elements. Range: 4.0–32.0.
  double verticalSpacing = 12.0;

  /// App list density. One of: 'compact', 'normal', 'comfortable'.
  String appDensity = 'normal';

  /// App list alignment. One of: 'left', 'center', 'right'.
  String appAlignment = 'left';

  /// Number of favorite apps shown on home screen. Range: 3–12.
  int visibleAppCount = 6;

  /// Whether to show app icons alongside names.
  bool showIcons = false;

  /// Clock position relative to app list. One of: 'top', 'bottom', 'hidden'.
  String clockPosition = 'top';

  // ─── Clock ─────────────────────────────────────────────────────────────────

  /// Clock format. One of: '12', '24'.
  String clockFormat = '24';

  /// Whether to show seconds in the clock.
  bool showSeconds = false;

  /// Multiplier for clock size. Range: 0.6–2.0.
  double clockSizeScale = 1.0;

  /// Override font family for the clock. Null = same as fontFamily.
  String? clockFontFamily;

  /// Override font weight for the clock. Null = same as fontWeight.
  int? clockFontWeight;

  /// Clock alignment. One of: 'left', 'center', 'right'.
  String clockAlignment = 'left';

  /// Whether to show the date below the clock.
  bool showDate = true;

  /// Date format pattern. E.g. 'EEE, MMM d' or 'dd/MM/yyyy'.
  String dateFormat = 'EEE, MMM d';

  // ─── Motion ────────────────────────────────────────────────────────────────

  /// Motion mode. One of: 'none', 'calm', 'smooth'.
  String motionMode = 'calm';

  /// Multiplier for all animation durations. Range: 0.5–2.0.
  double animationSpeedScale = 1.0;

  /// When true, overrides motionMode to 'none' and disables animations.
  bool reducedMotion = false;

  /// Whether to trigger haptic feedback on taps.
  bool hapticFeedback = true;
}

import 'package:flutter/widgets.dart';

/// Nudge Design System — Icon Abstraction
///
/// Widgets must use [NudgeIconToken] to request icons, never reference a
/// concrete icon library directly. This allows the icon pack to be swapped
/// globally without touching individual widgets.

// ---------------------------------------------------------------------------
// Semantic icon tokens
// ---------------------------------------------------------------------------

/// Semantic names for icons used throughout Nudge.
///
/// Add new tokens here when a new icon is needed. Map them in all
/// [NudgeIconResolver] implementations.
enum NudgeIconToken {
  home,
  search,
  settings,
  close,
  add,
  check,
  warning,
  error,
  info,
  success,
  arrowBack,
  arrowForward,
  chevronDown,
  chevronRight,
  apps,
  grid,
  list,
  focus,
  usage,
  notification,
  edit,
  delete,
  more,
  share,
  favorite,
  clock,
  calendar,
  theme,
  palette,
  font,
  lock,
  unlock,
  eye,
  eyeOff,
  moon,
  sun,
  device,
  developer,
}

// ---------------------------------------------------------------------------
// Supported icon packs
// ---------------------------------------------------------------------------

/// The icon pack currently active in the app.
enum NudgeIconPack {
  material,
  cupertino;
  // Future: lucide, phosphor, tabler, remix

  String get label => switch (this) {
        NudgeIconPack.material => 'Material Symbols',
        NudgeIconPack.cupertino => 'Cupertino Icons',
      };
}

// ---------------------------------------------------------------------------
// Resolver interface
// ---------------------------------------------------------------------------

/// Abstract icon resolver — maps [NudgeIconToken] → [IconData].
///
/// Implement this for each icon pack. Widgets call
/// `resolver.resolve(NudgeIconToken.home)` to get the correct glyph.
abstract class NudgeIconResolver {
  const NudgeIconResolver();

  /// Returns the [IconData] for the given semantic [token].
  IconData resolve(NudgeIconToken token);

  /// The pack this resolver implements.
  NudgeIconPack get pack;
}

// ---------------------------------------------------------------------------
// Material implementation (default)
// ---------------------------------------------------------------------------

/// Default resolver using Flutter's built-in [Icons] (Material Symbols subset).
final class MaterialIconResolver extends NudgeIconResolver {
  const MaterialIconResolver();

  @override
  NudgeIconPack get pack => NudgeIconPack.material;

  @override
  IconData resolve(NudgeIconToken token) => switch (token) {
        NudgeIconToken.home => const IconData(0xe318, fontFamily: 'MaterialIcons'),
        NudgeIconToken.search => const IconData(0xe8b6, fontFamily: 'MaterialIcons'),
        NudgeIconToken.settings => const IconData(0xe8b8, fontFamily: 'MaterialIcons'),
        NudgeIconToken.close => const IconData(0xe5cd, fontFamily: 'MaterialIcons'),
        NudgeIconToken.add => const IconData(0xe145, fontFamily: 'MaterialIcons'),
        NudgeIconToken.check => const IconData(0xe5ca, fontFamily: 'MaterialIcons'),
        NudgeIconToken.warning => const IconData(0xe002, fontFamily: 'MaterialIcons'),
        NudgeIconToken.error => const IconData(0xe000, fontFamily: 'MaterialIcons'),
        NudgeIconToken.info => const IconData(0xe88e, fontFamily: 'MaterialIcons'),
        NudgeIconToken.success => const IconData(0xe86c, fontFamily: 'MaterialIcons'),
        NudgeIconToken.arrowBack => const IconData(0xe5c4, fontFamily: 'MaterialIcons'),
        NudgeIconToken.arrowForward => const IconData(0xe5c8, fontFamily: 'MaterialIcons'),
        NudgeIconToken.chevronDown => const IconData(0xe313, fontFamily: 'MaterialIcons'),
        NudgeIconToken.chevronRight => const IconData(0xe315, fontFamily: 'MaterialIcons'),
        NudgeIconToken.apps => const IconData(0xe5c3, fontFamily: 'MaterialIcons'),
        NudgeIconToken.grid => const IconData(0xe3ec, fontFamily: 'MaterialIcons'),
        NudgeIconToken.list => const IconData(0xe896, fontFamily: 'MaterialIcons'),
        NudgeIconToken.focus => const IconData(0xe3a9, fontFamily: 'MaterialIcons'),
        NudgeIconToken.usage => const IconData(0xe1db, fontFamily: 'MaterialIcons'),
        NudgeIconToken.notification => const IconData(0xe7f4, fontFamily: 'MaterialIcons'),
        NudgeIconToken.edit => const IconData(0xe3c9, fontFamily: 'MaterialIcons'),
        NudgeIconToken.delete => const IconData(0xe872, fontFamily: 'MaterialIcons'),
        NudgeIconToken.more => const IconData(0xe5d4, fontFamily: 'MaterialIcons'),
        NudgeIconToken.share => const IconData(0xe80d, fontFamily: 'MaterialIcons'),
        NudgeIconToken.favorite => const IconData(0xe87d, fontFamily: 'MaterialIcons'),
        NudgeIconToken.clock => const IconData(0xe192, fontFamily: 'MaterialIcons'),
        NudgeIconToken.calendar => const IconData(0xe935, fontFamily: 'MaterialIcons'),
        NudgeIconToken.theme => const IconData(0xe40a, fontFamily: 'MaterialIcons'),
        NudgeIconToken.palette => const IconData(0xe40a, fontFamily: 'MaterialIcons'),
        NudgeIconToken.font => const IconData(0xe165, fontFamily: 'MaterialIcons'),
        NudgeIconToken.lock => const IconData(0xe897, fontFamily: 'MaterialIcons'),
        NudgeIconToken.unlock => const IconData(0xe898, fontFamily: 'MaterialIcons'),
        NudgeIconToken.eye => const IconData(0xe8f4, fontFamily: 'MaterialIcons'),
        NudgeIconToken.eyeOff => const IconData(0xe8f5, fontFamily: 'MaterialIcons'),
        NudgeIconToken.moon => const IconData(0xe51c, fontFamily: 'MaterialIcons'),
        NudgeIconToken.sun => const IconData(0xe518, fontFamily: 'MaterialIcons'),
        NudgeIconToken.device => const IconData(0xe1b1, fontFamily: 'MaterialIcons'),
        NudgeIconToken.developer => const IconData(0xe1b0, fontFamily: 'MaterialIcons'),
      };
}

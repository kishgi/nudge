import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../features/customization/domain/models/theme_config.dart';

/// Semantic names for icons used throughout Nudge.
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

/// The icon packs supported by the theme system.
enum NudgeIconPack {
  material,
  lucide,
  phosphor,
  tabler,
  remix;

  static NudgeIconPack parse(String value) {
    return NudgeIconPack.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => NudgeIconPack.material,
    );
  }

  String get label => switch (this) {
        NudgeIconPack.material => 'Material Symbols',
        NudgeIconPack.lucide => 'Lucide',
        NudgeIconPack.phosphor => 'Phosphor',
        NudgeIconPack.tabler => 'Tabler Icons',
        NudgeIconPack.remix => 'Remix Icon',
      };
}

/// Value class representing active icon configuration.
class NudgeIconSettings {
  const NudgeIconSettings({
    required this.pack,
    required this.size,
    required this.thickness,
    required this.style,
    required this.colorOverride,
    required this.opacity,
  });

  final NudgeIconPack pack;
  final double size;
  final double thickness;
  final String style; // 'outline' or 'filled'
  final Color? colorOverride;
  final double opacity;

  factory NudgeIconSettings.fromConfig(ThemeConfig config) {
    return NudgeIconSettings(
      pack: NudgeIconPack.parse(config.iconPack),
      size: config.iconSize,
      thickness: config.iconThickness,
      style: config.iconStyle,
      colorOverride: config.iconColorValue != null ? Color(config.iconColorValue!) : null,
      opacity: config.iconOpacity,
    );
  }

  NudgeIconSettings copyWith({
    NudgeIconPack? pack,
    double? size,
    double? thickness,
    String? style,
    Color? colorOverride,
    double? opacity,
  }) {
    return NudgeIconSettings(
      pack: pack ?? this.pack,
      size: size ?? this.size,
      thickness: thickness ?? this.thickness,
      style: style ?? this.style,
      colorOverride: colorOverride ?? this.colorOverride,
      opacity: opacity ?? this.opacity,
    );
  }
}

/// Abstract icon resolver mapping [NudgeIconToken] to [IconData].
abstract class NudgeIconResolver {
  const NudgeIconResolver();

  IconData resolve(NudgeIconToken token);
  NudgeIconPack get pack;

  /// Factory to get correct resolver for a given pack.
  static NudgeIconResolver forSettings(NudgeIconSettings settings) {
    return switch (settings.pack) {
      NudgeIconPack.material => const MaterialIconResolver(),
      NudgeIconPack.lucide => const LucideIconResolver(),
      NudgeIconPack.phosphor => PhosphorIconResolver(settings.thickness, settings.style),
      NudgeIconPack.tabler => const TablerIconResolver(),
      NudgeIconPack.remix => const RemixIconResolver(),
    };
  }
}

/// Default Material Icon resolver.
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

/// Lucide Icon Resolver.
/// Uses lucide_icons_flutter which is Dart 3.x compatible.
final class LucideIconResolver extends NudgeIconResolver {
  const LucideIconResolver();

  @override
  NudgeIconPack get pack => NudgeIconPack.lucide;

  @override
  IconData resolve(NudgeIconToken token) => switch (token) {
        NudgeIconToken.home => LucideIcons.house,
        NudgeIconToken.search => LucideIcons.search,
        NudgeIconToken.settings => LucideIcons.settings,
        NudgeIconToken.close => LucideIcons.x,
        NudgeIconToken.add => LucideIcons.plus,
        NudgeIconToken.check => LucideIcons.check,
        NudgeIconToken.warning => LucideIcons.triangleAlert,
        NudgeIconToken.error => LucideIcons.circleAlert,
        NudgeIconToken.info => LucideIcons.info,
        NudgeIconToken.success => LucideIcons.circleCheck,
        NudgeIconToken.arrowBack => LucideIcons.arrowLeft,
        NudgeIconToken.arrowForward => LucideIcons.arrowRight,
        NudgeIconToken.chevronDown => LucideIcons.chevronDown,
        NudgeIconToken.chevronRight => LucideIcons.chevronRight,
        NudgeIconToken.apps => LucideIcons.layoutGrid,
        NudgeIconToken.grid => LucideIcons.grid3x3,
        NudgeIconToken.list => LucideIcons.list,
        NudgeIconToken.focus => LucideIcons.target,
        NudgeIconToken.usage => LucideIcons.chartBar,
        NudgeIconToken.notification => LucideIcons.bell,
        NudgeIconToken.edit => LucideIcons.pencil,
        NudgeIconToken.delete => LucideIcons.trash2,
        NudgeIconToken.more => LucideIcons.ellipsis,
        NudgeIconToken.share => LucideIcons.share2,
        NudgeIconToken.favorite => LucideIcons.star,
        NudgeIconToken.clock => LucideIcons.clock,
        NudgeIconToken.calendar => LucideIcons.calendar,
        NudgeIconToken.theme => LucideIcons.palette,
        NudgeIconToken.palette => LucideIcons.palette,
        NudgeIconToken.font => LucideIcons.type,
        NudgeIconToken.lock => LucideIcons.lock,
        NudgeIconToken.unlock => LucideIcons.lockOpen,
        NudgeIconToken.eye => LucideIcons.eye,
        NudgeIconToken.eyeOff => LucideIcons.eyeOff,
        NudgeIconToken.moon => LucideIcons.moon,
        NudgeIconToken.sun => LucideIcons.sun,
        NudgeIconToken.device => LucideIcons.smartphone,
        NudgeIconToken.developer => LucideIcons.code,
      };
}

// ---------------------------------------------------------------------------
// Phosphor style selector
// ---------------------------------------------------------------------------
// phosphoricons_flutter uses suffix-based static const properties instead of
// function calls, so we select the right suffix based on thickness/style.

/// Returns one of the five resolved Phosphor icon data values for a token.
/// Each entry is [thin, light, regular, bold, fill].
typedef _PhosphorSet = ({
  IconData thin,
  IconData light,
  IconData regular,
  IconData bold,
  IconData fill,
});

_PhosphorSet _p(
  IconData thin,
  IconData light,
  IconData regular,
  IconData bold,
  IconData fill,
) => (thin: thin, light: light, regular: regular, bold: bold, fill: fill);

/// Phosphor Icon Resolver.
/// Uses phosphoricons_flutter which is Dart 3.x compatible.
final class PhosphorIconResolver extends NudgeIconResolver {
  const PhosphorIconResolver(this.thickness, this.style);

  final double thickness;
  final String style;

  @override
  NudgeIconPack get pack => NudgeIconPack.phosphor;

  IconData _pick(_PhosphorSet s) {
    if (style == 'filled') return s.fill;
    if (thickness < 1.2) return s.thin;
    if (thickness < 1.5) return s.light;
    if (thickness < 2.0) return s.regular;
    return s.bold;
  }

  static final Map<NudgeIconToken, _PhosphorSet> _icons = {
    NudgeIconToken.home: _p(
      PhosphorIcons.houseThin, PhosphorIcons.houseLight,
      PhosphorIcons.house, PhosphorIcons.houseBold, PhosphorIcons.houseFill,
    ),
    NudgeIconToken.search: _p(
      PhosphorIcons.magnifyingGlassThin, PhosphorIcons.magnifyingGlassLight,
      PhosphorIcons.magnifyingGlass, PhosphorIcons.magnifyingGlassBold, PhosphorIcons.magnifyingGlassFill,
    ),
    NudgeIconToken.settings: _p(
      PhosphorIcons.gearThin, PhosphorIcons.gearLight,
      PhosphorIcons.gear, PhosphorIcons.gearBold, PhosphorIcons.gearFill,
    ),
    NudgeIconToken.close: _p(
      PhosphorIcons.xThin, PhosphorIcons.xLight,
      PhosphorIcons.x, PhosphorIcons.xBold, PhosphorIcons.xFill,
    ),
    NudgeIconToken.add: _p(
      PhosphorIcons.plusThin, PhosphorIcons.plusLight,
      PhosphorIcons.plus, PhosphorIcons.plusBold, PhosphorIcons.plusFill,
    ),
    NudgeIconToken.check: _p(
      PhosphorIcons.checkThin, PhosphorIcons.checkLight,
      PhosphorIcons.check, PhosphorIcons.checkBold, PhosphorIcons.checkFill,
    ),
    NudgeIconToken.warning: _p(
      PhosphorIcons.warningThin, PhosphorIcons.warningLight,
      PhosphorIcons.warning, PhosphorIcons.warningBold, PhosphorIcons.warningFill,
    ),
    NudgeIconToken.error: _p(
      PhosphorIcons.xCircleThin, PhosphorIcons.xCircleLight,
      PhosphorIcons.xCircle, PhosphorIcons.xCircleBold, PhosphorIcons.xCircleFill,
    ),
    NudgeIconToken.info: _p(
      PhosphorIcons.infoThin, PhosphorIcons.infoLight,
      PhosphorIcons.info, PhosphorIcons.infoBold, PhosphorIcons.infoFill,
    ),
    NudgeIconToken.success: _p(
      PhosphorIcons.checkCircleThin, PhosphorIcons.checkCircleLight,
      PhosphorIcons.checkCircle, PhosphorIcons.checkCircleBold, PhosphorIcons.checkCircleFill,
    ),
    NudgeIconToken.arrowBack: _p(
      PhosphorIcons.arrowLeftThin, PhosphorIcons.arrowLeftLight,
      PhosphorIcons.arrowLeft, PhosphorIcons.arrowLeftBold, PhosphorIcons.arrowLeftFill,
    ),
    NudgeIconToken.arrowForward: _p(
      PhosphorIcons.arrowRightThin, PhosphorIcons.arrowRightLight,
      PhosphorIcons.arrowRight, PhosphorIcons.arrowRightBold, PhosphorIcons.arrowRightFill,
    ),
    NudgeIconToken.chevronDown: _p(
      PhosphorIcons.caretDownThin, PhosphorIcons.caretDownLight,
      PhosphorIcons.caretDown, PhosphorIcons.caretDownBold, PhosphorIcons.caretDownFill,
    ),
    NudgeIconToken.chevronRight: _p(
      PhosphorIcons.caretRightThin, PhosphorIcons.caretRightLight,
      PhosphorIcons.caretRight, PhosphorIcons.caretRightBold, PhosphorIcons.caretRightFill,
    ),
    NudgeIconToken.apps: _p(
      PhosphorIcons.squaresFourThin, PhosphorIcons.squaresFourLight,
      PhosphorIcons.squaresFour, PhosphorIcons.squaresFourBold, PhosphorIcons.squaresFourFill,
    ),
    NudgeIconToken.grid: _p(
      PhosphorIcons.gridFourThin, PhosphorIcons.gridFourLight,
      PhosphorIcons.gridFour, PhosphorIcons.gridFourBold, PhosphorIcons.gridFourFill,
    ),
    NudgeIconToken.list: _p(
      PhosphorIcons.listThin, PhosphorIcons.listLight,
      PhosphorIcons.list, PhosphorIcons.listBold, PhosphorIcons.listFill,
    ),
    NudgeIconToken.focus: _p(
      PhosphorIcons.targetThin, PhosphorIcons.targetLight,
      PhosphorIcons.target, PhosphorIcons.targetBold, PhosphorIcons.targetFill,
    ),
    NudgeIconToken.usage: _p(
      PhosphorIcons.chartBarThin, PhosphorIcons.chartBarLight,
      PhosphorIcons.chartBar, PhosphorIcons.chartBarBold, PhosphorIcons.chartBarFill,
    ),
    NudgeIconToken.notification: _p(
      PhosphorIcons.bellThin, PhosphorIcons.bellLight,
      PhosphorIcons.bell, PhosphorIcons.bellBold, PhosphorIcons.bellFill,
    ),
    NudgeIconToken.edit: _p(
      PhosphorIcons.pencilThin, PhosphorIcons.pencilLight,
      PhosphorIcons.pencil, PhosphorIcons.pencilBold, PhosphorIcons.pencilFill,
    ),
    NudgeIconToken.delete: _p(
      PhosphorIcons.trashThin, PhosphorIcons.trashLight,
      PhosphorIcons.trash, PhosphorIcons.trashBold, PhosphorIcons.trashFill,
    ),
    NudgeIconToken.more: _p(
      PhosphorIcons.dotsThreeThin, PhosphorIcons.dotsThreeLight,
      PhosphorIcons.dotsThree, PhosphorIcons.dotsThreeBold, PhosphorIcons.dotsThreeFill,
    ),
    NudgeIconToken.share: _p(
      PhosphorIcons.shareNetworkThin, PhosphorIcons.shareNetworkLight,
      PhosphorIcons.shareNetwork, PhosphorIcons.shareNetworkBold, PhosphorIcons.shareNetworkFill,
    ),
    NudgeIconToken.favorite: _p(
      PhosphorIcons.starThin, PhosphorIcons.starLight,
      PhosphorIcons.star, PhosphorIcons.starBold, PhosphorIcons.starFill,
    ),
    NudgeIconToken.clock: _p(
      PhosphorIcons.clockThin, PhosphorIcons.clockLight,
      PhosphorIcons.clock, PhosphorIcons.clockBold, PhosphorIcons.clockFill,
    ),
    NudgeIconToken.calendar: _p(
      PhosphorIcons.calendarThin, PhosphorIcons.calendarLight,
      PhosphorIcons.calendar, PhosphorIcons.calendarBold, PhosphorIcons.calendarFill,
    ),
    NudgeIconToken.theme: _p(
      PhosphorIcons.paletteThin, PhosphorIcons.paletteLight,
      PhosphorIcons.palette, PhosphorIcons.paletteBold, PhosphorIcons.paletteFill,
    ),
    NudgeIconToken.palette: _p(
      PhosphorIcons.paletteThin, PhosphorIcons.paletteLight,
      PhosphorIcons.palette, PhosphorIcons.paletteBold, PhosphorIcons.paletteFill,
    ),
    NudgeIconToken.font: _p(
      PhosphorIcons.textTThin, PhosphorIcons.textTLight,
      PhosphorIcons.textT, PhosphorIcons.textTBold, PhosphorIcons.textTFill,
    ),
    NudgeIconToken.lock: _p(
      PhosphorIcons.lockThin, PhosphorIcons.lockLight,
      PhosphorIcons.lock, PhosphorIcons.lockBold, PhosphorIcons.lockFill,
    ),
    NudgeIconToken.unlock: _p(
      PhosphorIcons.lockOpenThin, PhosphorIcons.lockOpenLight,
      PhosphorIcons.lockOpen, PhosphorIcons.lockOpenBold, PhosphorIcons.lockOpenFill,
    ),
    NudgeIconToken.eye: _p(
      PhosphorIcons.eyeThin, PhosphorIcons.eyeLight,
      PhosphorIcons.eye, PhosphorIcons.eyeBold, PhosphorIcons.eyeFill,
    ),
    NudgeIconToken.eyeOff: _p(
      PhosphorIcons.eyeSlashThin, PhosphorIcons.eyeSlashLight,
      PhosphorIcons.eyeSlash, PhosphorIcons.eyeSlashBold, PhosphorIcons.eyeSlashFill,
    ),
    NudgeIconToken.moon: _p(
      PhosphorIcons.moonThin, PhosphorIcons.moonLight,
      PhosphorIcons.moon, PhosphorIcons.moonBold, PhosphorIcons.moonFill,
    ),
    NudgeIconToken.sun: _p(
      PhosphorIcons.sunThin, PhosphorIcons.sunLight,
      PhosphorIcons.sun, PhosphorIcons.sunBold, PhosphorIcons.sunFill,
    ),
    NudgeIconToken.device: _p(
      PhosphorIcons.deviceMobileThin, PhosphorIcons.deviceMobileLight,
      PhosphorIcons.deviceMobile, PhosphorIcons.deviceMobileBold, PhosphorIcons.deviceMobileFill,
    ),
    NudgeIconToken.developer: _p(
      PhosphorIcons.codeThin, PhosphorIcons.codeLight,
      PhosphorIcons.code, PhosphorIcons.codeBold, PhosphorIcons.codeFill,
    ),
  };

  @override
  IconData resolve(NudgeIconToken token) {
    final set = _icons[token];
    if (set == null) {
      // Fallback to material icon for unknown tokens
      return const IconData(0xe318, fontFamily: 'MaterialIcons');
    }
    return _pick(set);
  }
}

/// Tabler Icon Resolver (Custom TTF font based).
final class TablerIconResolver extends NudgeIconResolver {
  const TablerIconResolver();

  @override
  NudgeIconPack get pack => NudgeIconPack.tabler;

  @override
  IconData resolve(NudgeIconToken token) => switch (token) {
        NudgeIconToken.home => const IconData(0xeac1, fontFamily: 'TablerIcons'),
        NudgeIconToken.search => const IconData(0xeb1c, fontFamily: 'TablerIcons'),
        NudgeIconToken.settings => const IconData(0xeb20, fontFamily: 'TablerIcons'),
        NudgeIconToken.close => const IconData(0xeb55, fontFamily: 'TablerIcons'),
        NudgeIconToken.add => const IconData(0xeb0b, fontFamily: 'TablerIcons'),
        NudgeIconToken.check => const IconData(0xea5e, fontFamily: 'TablerIcons'),
        NudgeIconToken.warning => const IconData(0xea06, fontFamily: 'TablerIcons'),
        NudgeIconToken.error => const IconData(0xea05, fontFamily: 'TablerIcons'),
        NudgeIconToken.info => const IconData(0xeac5, fontFamily: 'TablerIcons'),
        NudgeIconToken.success => const IconData(0xea67, fontFamily: 'TablerIcons'),
        NudgeIconToken.arrowBack => const IconData(0xea19, fontFamily: 'TablerIcons'),
        NudgeIconToken.arrowForward => const IconData(0xea1f, fontFamily: 'TablerIcons'),
        NudgeIconToken.chevronDown => const IconData(0xea5f, fontFamily: 'TablerIcons'),
        NudgeIconToken.chevronRight => const IconData(0xea61, fontFamily: 'TablerIcons'),
        NudgeIconToken.apps => const IconData(0xebb6, fontFamily: 'TablerIcons'),
        NudgeIconToken.grid => const IconData(0xedba, fontFamily: 'TablerIcons'),
        NudgeIconToken.list => const IconData(0xeb6b, fontFamily: 'TablerIcons'),
        NudgeIconToken.focus => const IconData(0xeb8d, fontFamily: 'TablerIcons'),
        NudgeIconToken.usage => const IconData(0xea59, fontFamily: 'TablerIcons'),
        NudgeIconToken.notification => const IconData(0xea35, fontFamily: 'TablerIcons'),
        NudgeIconToken.edit => const IconData(0xeb04, fontFamily: 'TablerIcons'),
        NudgeIconToken.delete => const IconData(0xeb41, fontFamily: 'TablerIcons'),
        NudgeIconToken.more => const IconData(0xea95, fontFamily: 'TablerIcons'),
        NudgeIconToken.share => const IconData(0xeb21, fontFamily: 'TablerIcons'),
        NudgeIconToken.favorite => const IconData(0xeb2e, fontFamily: 'TablerIcons'),
        NudgeIconToken.clock => const IconData(0xea70, fontFamily: 'TablerIcons'),
        NudgeIconToken.calendar => const IconData(0xea53, fontFamily: 'TablerIcons'),
        NudgeIconToken.theme => const IconData(0xeb01, fontFamily: 'TablerIcons'),
        NudgeIconToken.palette => const IconData(0xeb01, fontFamily: 'TablerIcons'),
        NudgeIconToken.font => const IconData(0xebc5, fontFamily: 'TablerIcons'),
        NudgeIconToken.lock => const IconData(0xeae2, fontFamily: 'TablerIcons'),
        NudgeIconToken.unlock => const IconData(0xeae1, fontFamily: 'TablerIcons'),
        NudgeIconToken.eye => const IconData(0xea9a, fontFamily: 'TablerIcons'),
        NudgeIconToken.eyeOff => const IconData(0xecf0, fontFamily: 'TablerIcons'),
        NudgeIconToken.moon => const IconData(0xeaf8, fontFamily: 'TablerIcons'),
        NudgeIconToken.sun => const IconData(0xeb30, fontFamily: 'TablerIcons'),
        NudgeIconToken.device => const IconData(0xea8a, fontFamily: 'TablerIcons'),
        NudgeIconToken.developer => const IconData(0xea77, fontFamily: 'TablerIcons'),
      };
}

/// Remix Icon Resolver (Custom TTF font based).
final class RemixIconResolver extends NudgeIconResolver {
  const RemixIconResolver();

  @override
  NudgeIconPack get pack => NudgeIconPack.remix;

  @override
  IconData resolve(NudgeIconToken token) => switch (token) {
        NudgeIconToken.home => const IconData(0xee2b, fontFamily: 'RemixIcon'),
        NudgeIconToken.search => const IconData(0xf0d1, fontFamily: 'RemixIcon'),
        NudgeIconToken.settings => const IconData(0xf0ee, fontFamily: 'RemixIcon'),
        NudgeIconToken.close => const IconData(0xeb99, fontFamily: 'RemixIcon'),
        NudgeIconToken.add => const IconData(0xea13, fontFamily: 'RemixIcon'),
        NudgeIconToken.check => const IconData(0xeb7b, fontFamily: 'RemixIcon'),
        NudgeIconToken.warning => const IconData(0xeca1, fontFamily: 'RemixIcon'),
        NudgeIconToken.error => const IconData(0xeb97, fontFamily: 'RemixIcon'),
        NudgeIconToken.info => const IconData(0xee59, fontFamily: 'RemixIcon'),
        NudgeIconToken.success => const IconData(0xeb81, fontFamily: 'RemixIcon'),
        NudgeIconToken.arrowBack => const IconData(0xea60, fontFamily: 'RemixIcon'),
        NudgeIconToken.arrowForward => const IconData(0xea6c, fontFamily: 'RemixIcon'),
        NudgeIconToken.chevronDown => const IconData(0xea4e, fontFamily: 'RemixIcon'),
        NudgeIconToken.chevronRight => const IconData(0xea6e, fontFamily: 'RemixIcon'),
        NudgeIconToken.apps => const IconData(0xedde, fontFamily: 'RemixIcon'),
        NudgeIconToken.grid => const IconData(0xeddf, fontFamily: 'RemixIcon'),
        NudgeIconToken.list => const IconData(0xeeba, fontFamily: 'RemixIcon'),
        NudgeIconToken.focus => const IconData(0xed4e, fontFamily: 'RemixIcon'),
        NudgeIconToken.usage => const IconData(0xea9e, fontFamily: 'RemixIcon'),
        NudgeIconToken.notification => const IconData(0xef9a, fontFamily: 'RemixIcon'),
        NudgeIconToken.edit => const IconData(0xec86, fontFamily: 'RemixIcon'),
        NudgeIconToken.delete => const IconData(0xec2a, fontFamily: 'RemixIcon'),
        NudgeIconToken.more => const IconData(0xef79, fontFamily: 'RemixIcon'),
        NudgeIconToken.share => const IconData(0xf0fe, fontFamily: 'RemixIcon'),
        NudgeIconToken.favorite => const IconData(0xf18b, fontFamily: 'RemixIcon'),
        NudgeIconToken.clock => const IconData(0xf20f, fontFamily: 'RemixIcon'),
        NudgeIconToken.calendar => const IconData(0xeb27, fontFamily: 'RemixIcon'),
        NudgeIconToken.theme => const IconData(0xefc5, fontFamily: 'RemixIcon'),
        NudgeIconToken.palette => const IconData(0xefc5, fontFamily: 'RemixIcon'),
        NudgeIconToken.font => const IconData(0xf201, fontFamily: 'RemixIcon'),
        NudgeIconToken.lock => const IconData(0xeece, fontFamily: 'RemixIcon'),
        NudgeIconToken.unlock => const IconData(0xeed2, fontFamily: 'RemixIcon'),
        NudgeIconToken.eye => const IconData(0xecb5, fontFamily: 'RemixIcon'),
        NudgeIconToken.eyeOff => const IconData(0xecb3, fontFamily: 'RemixIcon'),
        NudgeIconToken.moon => const IconData(0xef75, fontFamily: 'RemixIcon'),
        NudgeIconToken.sun => const IconData(0xf1bf, fontFamily: 'RemixIcon'),
        NudgeIconToken.device => const IconData(0xf15a, fontFamily: 'RemixIcon'),
        NudgeIconToken.developer => const IconData(0xeba9, fontFamily: 'RemixIcon'),
      };
}

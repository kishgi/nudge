import 'package:flutter/widgets.dart';
import '../../features/customization/domain/models/theme_config.dart';

/// Supported font families.
enum NudgeFontFamily {
  inter,
  manrope,
  plusJakartaSans,
  spaceGrotesk,
  ibmPlexSans,
  ibmPlexMono,
  jetBrainsMono,
  system;

  static NudgeFontFamily parse(String value) {
    return NudgeFontFamily.values.firstWhere(
      (e) => e.id.toLowerCase() == value.toLowerCase() || e.name == value.toLowerCase(),
      orElse: () => NudgeFontFamily.system, // unknown → system passthrough
    );
  }

  /// String identifier used in database and config.
  String get id => switch (this) {
        NudgeFontFamily.inter => 'Inter',
        NudgeFontFamily.manrope => 'Manrope',
        NudgeFontFamily.plusJakartaSans => 'Plus Jakarta Sans',
        NudgeFontFamily.spaceGrotesk => 'Space Grotesk',
        NudgeFontFamily.ibmPlexSans => 'IBM Plex Sans',
        NudgeFontFamily.ibmPlexMono => 'IBM Plex Mono',
        NudgeFontFamily.jetBrainsMono => 'JetBrains Mono',
        NudgeFontFamily.system => 'system',
      };

  /// The font family name declared in pubspec.yaml.
  String? get fontFamilyName => switch (this) {
        NudgeFontFamily.inter => 'Inter',
        NudgeFontFamily.manrope => 'Manrope',
        NudgeFontFamily.plusJakartaSans => 'PlusJakartaSans',
        NudgeFontFamily.spaceGrotesk => 'SpaceGrotesk',
        NudgeFontFamily.ibmPlexSans => 'IBMPlexSans',
        NudgeFontFamily.ibmPlexMono => 'IBMPlexMono',
        NudgeFontFamily.jetBrainsMono => 'JetBrainsMono',
        NudgeFontFamily.system => null, // default system font
      };

  /// List of weights actually available for this font.
  List<FontWeight> get availableWeights => switch (this) {
        NudgeFontFamily.inter => const [
            FontWeight.w100,
            FontWeight.w200,
            FontWeight.w300,
            FontWeight.w400,
            FontWeight.w500,
            FontWeight.w600,
            FontWeight.w700,
            FontWeight.w800,
            FontWeight.w900,
          ],
        NudgeFontFamily.manrope => const [
            FontWeight.w200,
            FontWeight.w300,
            FontWeight.w400,
            FontWeight.w500,
            FontWeight.w600,
            FontWeight.w700,
            FontWeight.w800,
          ],
        NudgeFontFamily.plusJakartaSans => const [
            FontWeight.w200,
            FontWeight.w300,
            FontWeight.w400,
            FontWeight.w500,
            FontWeight.w600,
            FontWeight.w700,
            FontWeight.w800,
          ],
        NudgeFontFamily.spaceGrotesk => const [
            FontWeight.w300,
            FontWeight.w400,
            FontWeight.w500,
            FontWeight.w600,
            FontWeight.w700,
          ],
        NudgeFontFamily.ibmPlexSans => const [
            FontWeight.w100,
            FontWeight.w200,
            FontWeight.w300,
            FontWeight.w400,
            FontWeight.w500,
            FontWeight.w600,
            FontWeight.w700,
          ],
        NudgeFontFamily.ibmPlexMono => const [
            FontWeight.w100,
            FontWeight.w200,
            FontWeight.w300,
            FontWeight.w400,
            FontWeight.w500,
            FontWeight.w600,
            FontWeight.w700,
          ],
        NudgeFontFamily.jetBrainsMono => const [
            FontWeight.w100,
            FontWeight.w200,
            FontWeight.w300,
            FontWeight.w400,
            FontWeight.w500,
            FontWeight.w600,
            FontWeight.w700,
            FontWeight.w800,
          ],
        NudgeFontFamily.system => const [
            FontWeight.w300,
            FontWeight.w400,
            FontWeight.w500,
            FontWeight.w700,
          ],
      };

  /// Find the nearest available FontWeight supported by this font family.
  FontWeight getNearestWeight(int targetWeightValue) {
    final list = availableWeights;
    if (list.isEmpty) return FontWeight.normal;

    FontWeight best = list.first;
    int minDiff = (best.value - targetWeightValue).abs();

    for (final w in list) {
      final diff = (w.value - targetWeightValue).abs();
      // On equal distance prefer higher weight (round-up convention)
      if (diff < minDiff || (diff == minDiff && w.value > best.value)) {
        minDiff = diff;
        best = w;
      }
    }
    return best;
  }
}

/// Text case transformations.
enum NudgeTextCase {
  none,
  upper,
  lower;

  static NudgeTextCase parse(String value) {
    return NudgeTextCase.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => NudgeTextCase.none,
    );
  }

  String apply(String text) => switch (this) {
        NudgeTextCase.none => text,
        NudgeTextCase.upper => text.toUpperCase(),
        NudgeTextCase.lower => text.toLowerCase(),
      };
}

/// Dynamic type scale built from ThemeConfig settings.
class NudgeTypeScale {
  const NudgeTypeScale({
    required this.display,
    required this.headline,
    required this.title,
    required this.body,
    required this.label,
    required this.caption,
    required this.fontFamily,
    required this.textAlign,
    required this.textCase,
  });

  final TextStyle display;
  final TextStyle headline;
  final TextStyle title;
  final TextStyle body;
  final TextStyle label;
  final TextStyle caption;

  final String fontFamily;
  final TextAlign textAlign;
  final NudgeTextCase textCase;

  String applyCase(String text) => textCase.apply(text);

  /// Default baseline scales
  factory NudgeTypeScale.defaults({String fontFamily = 'Inter'}) {
    final family = NudgeFontFamily.parse(fontFamily);
    // For known families, use the mapped font name; for unknown/raw strings
    // (e.g. 'monospace'), pass the raw string through to TextStyle directly.
    final fontName = family == NudgeFontFamily.system
        ? fontFamily  // preserve raw value (e.g. 'monospace', 'serif')
        : family.fontFamilyName;

    return NudgeTypeScale(
      fontFamily: fontFamily,
      textAlign: TextAlign.left,
      textCase: NudgeTextCase.none,
      display: TextStyle(
        fontFamily: fontName,
        fontSize: 48,
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: -1.5,
        leadingDistribution: TextLeadingDistribution.even,
      ),
      headline: TextStyle(
        fontFamily: fontName,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: -0.5,
        leadingDistribution: TextLeadingDistribution.even,
      ),
      title: TextStyle(
        fontFamily: fontName,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.3,
        letterSpacing: -0.2,
        leadingDistribution: TextLeadingDistribution.even,
      ),
      body: TextStyle(
        fontFamily: fontName,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.55,
        letterSpacing: 0.1,
        leadingDistribution: TextLeadingDistribution.even,
      ),
      label: TextStyle(
        fontFamily: fontName,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.1,
        leadingDistribution: TextLeadingDistribution.even,
      ),
      caption: TextStyle(
        fontFamily: fontName,
        fontSize: 11,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.2,
        leadingDistribution: TextLeadingDistribution.even,
      ),
    );
  }

  factory NudgeTypeScale.mono({String fontFamily = 'monospace'}) {
    return NudgeTypeScale.defaults(fontFamily: fontFamily);
  }

  /// Builds a type scale dynamically based on the [ThemeConfig].
  factory NudgeTypeScale.fromConfig(ThemeConfig config) {
    final family = NudgeFontFamily.parse(config.fontFamily);
    final fontName = family.fontFamilyName;

    // Nearest supported weight
    final baseWeight = family.getNearestWeight(config.fontWeight);

    // Apply text alignment
    TextAlign align = TextAlign.left;
    if (config.textAlignment == 'center') {
      align = TextAlign.center;
    } else if (config.textAlignment == 'right') {
      align = TextAlign.right;
    }

    final tCase = NudgeTextCase.parse(config.textCase);

    TextStyle buildStyle({
      required double baseSize,
      required FontWeight baseWeightOverride,
      required double baseHeight,
      required double baseSpacing,
    }) {
      final double scaledSize = baseSize * config.fontSizeScale;
      final double letterSpacing = baseSpacing + config.letterSpacingDelta;
      final double lineHeight = baseHeight * config.lineHeightScale;

      // Adjust weight: use baseWeight if it is standard (e.g. body/caption usually have lighter weights, 
      // but let's scale it relative to the slider setting if user changed it from default 400).
      FontWeight styleWeight = baseWeightOverride;
      if (config.fontWeight != 400) {
        // If user changed the slider weight, use the slider weight (clamped to the font's capability)
        styleWeight = baseWeight;
      }

      return TextStyle(
        fontFamily: fontName,
        fontSize: scaledSize,
        fontWeight: styleWeight,
        height: lineHeight,
        letterSpacing: letterSpacing,
        leadingDistribution: TextLeadingDistribution.even,
      );
    }

    return NudgeTypeScale(
      fontFamily: config.fontFamily,
      textAlign: align,
      textCase: tCase,
      display: buildStyle(
        baseSize: 48,
        baseWeightOverride: family.getNearestWeight(config.fontWeight != 400 ? config.fontWeight : 700),
        baseHeight: 1.1,
        baseSpacing: -1.5,
      ),
      headline: buildStyle(
        baseSize: 28,
        baseWeightOverride: family.getNearestWeight(config.fontWeight != 400 ? config.fontWeight : 600),
        baseHeight: 1.2,
        baseSpacing: -0.5,
      ),
      title: buildStyle(
        baseSize: 18,
        baseWeightOverride: family.getNearestWeight(config.fontWeight != 400 ? config.fontWeight : 500),
        baseHeight: 1.3,
        baseSpacing: -0.2,
      ),
      body: buildStyle(
        baseSize: 15,
        baseWeightOverride: family.getNearestWeight(config.fontWeight != 400 ? config.fontWeight : 400),
        baseHeight: 1.55,
        baseSpacing: 0.1,
      ),
      label: buildStyle(
        baseSize: 13,
        baseWeightOverride: family.getNearestWeight(config.fontWeight != 400 ? config.fontWeight : 500),
        baseHeight: 1.4,
        baseSpacing: 0.1,
      ),
      caption: buildStyle(
        baseSize: 11,
        baseWeightOverride: family.getNearestWeight(config.fontWeight != 400 ? config.fontWeight : 400),
        baseHeight: 1.5,
        baseSpacing: 0.2,
      ),
    );
  }

  NudgeTypeScale withFontFamily(String newFamily) {
    return NudgeTypeScale.defaults(fontFamily: newFamily).copyWith(
      textAlign: textAlign,
      textCase: textCase,
    );
  }

  NudgeTypeScale copyWith({
    TextStyle? display,
    TextStyle? headline,
    TextStyle? title,
    TextStyle? body,
    TextStyle? label,
    TextStyle? caption,
    String? fontFamily,
    TextAlign? textAlign,
    NudgeTextCase? textCase,
  }) {
    return NudgeTypeScale(
      display: display ?? this.display,
      headline: headline ?? this.headline,
      title: title ?? this.title,
      body: body ?? this.body,
      label: label ?? this.label,
      caption: caption ?? this.caption,
      fontFamily: fontFamily ?? this.fontFamily,
      textAlign: textAlign ?? this.textAlign,
      textCase: textCase ?? this.textCase,
    );
  }
}

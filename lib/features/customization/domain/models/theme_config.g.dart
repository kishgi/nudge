// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_config.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetThemeConfigCollection on Isar {
  IsarCollection<ThemeConfig> get themeConfigs => this.collection();
}

const ThemeConfigSchema = CollectionSchema(
  name: r'ThemeConfig',
  id: 5264690155697542449,
  properties: {
    r'accentColorValue': PropertySchema(
      id: 0,
      name: r'accentColorValue',
      type: IsarType.long,
    ),
    r'animationSpeedScale': PropertySchema(
      id: 1,
      name: r'animationSpeedScale',
      type: IsarType.double,
    ),
    r'appAlignment': PropertySchema(
      id: 2,
      name: r'appAlignment',
      type: IsarType.string,
    ),
    r'appDensity': PropertySchema(
      id: 3,
      name: r'appDensity',
      type: IsarType.string,
    ),
    r'backgroundColorValue': PropertySchema(
      id: 4,
      name: r'backgroundColorValue',
      type: IsarType.long,
    ),
    r'clockAlignment': PropertySchema(
      id: 5,
      name: r'clockAlignment',
      type: IsarType.string,
    ),
    r'clockFontFamily': PropertySchema(
      id: 6,
      name: r'clockFontFamily',
      type: IsarType.string,
    ),
    r'clockFontWeight': PropertySchema(
      id: 7,
      name: r'clockFontWeight',
      type: IsarType.long,
    ),
    r'clockFormat': PropertySchema(
      id: 8,
      name: r'clockFormat',
      type: IsarType.string,
    ),
    r'clockPosition': PropertySchema(
      id: 9,
      name: r'clockPosition',
      type: IsarType.string,
    ),
    r'clockSizeScale': PropertySchema(
      id: 10,
      name: r'clockSizeScale',
      type: IsarType.double,
    ),
    r'colorPreset': PropertySchema(
      id: 11,
      name: r'colorPreset',
      type: IsarType.string,
    ),
    r'dateFormat': PropertySchema(
      id: 12,
      name: r'dateFormat',
      type: IsarType.string,
    ),
    r'fontFamily': PropertySchema(
      id: 13,
      name: r'fontFamily',
      type: IsarType.string,
    ),
    r'fontSizeScale': PropertySchema(
      id: 14,
      name: r'fontSizeScale',
      type: IsarType.double,
    ),
    r'fontWeight': PropertySchema(
      id: 15,
      name: r'fontWeight',
      type: IsarType.long,
    ),
    r'hapticFeedback': PropertySchema(
      id: 16,
      name: r'hapticFeedback',
      type: IsarType.bool,
    ),
    r'highContrast': PropertySchema(
      id: 17,
      name: r'highContrast',
      type: IsarType.bool,
    ),
    r'horizontalPadding': PropertySchema(
      id: 18,
      name: r'horizontalPadding',
      type: IsarType.double,
    ),
    r'iconColorValue': PropertySchema(
      id: 19,
      name: r'iconColorValue',
      type: IsarType.long,
    ),
    r'iconOpacity': PropertySchema(
      id: 20,
      name: r'iconOpacity',
      type: IsarType.double,
    ),
    r'iconPack': PropertySchema(
      id: 21,
      name: r'iconPack',
      type: IsarType.string,
    ),
    r'iconSize': PropertySchema(
      id: 22,
      name: r'iconSize',
      type: IsarType.double,
    ),
    r'iconStyle': PropertySchema(
      id: 23,
      name: r'iconStyle',
      type: IsarType.string,
    ),
    r'iconThickness': PropertySchema(
      id: 24,
      name: r'iconThickness',
      type: IsarType.double,
    ),
    r'isCustom': PropertySchema(id: 25, name: r'isCustom', type: IsarType.bool),
    r'letterSpacingDelta': PropertySchema(
      id: 26,
      name: r'letterSpacingDelta',
      type: IsarType.double,
    ),
    r'lineHeightScale': PropertySchema(
      id: 27,
      name: r'lineHeightScale',
      type: IsarType.double,
    ),
    r'motionMode': PropertySchema(
      id: 28,
      name: r'motionMode',
      type: IsarType.string,
    ),
    r'name': PropertySchema(id: 29, name: r'name', type: IsarType.string),
    r'primaryTextColorValue': PropertySchema(
      id: 30,
      name: r'primaryTextColorValue',
      type: IsarType.long,
    ),
    r'reducedMotion': PropertySchema(
      id: 31,
      name: r'reducedMotion',
      type: IsarType.bool,
    ),
    r'secondaryTextColorValue': PropertySchema(
      id: 32,
      name: r'secondaryTextColorValue',
      type: IsarType.long,
    ),
    r'showDate': PropertySchema(id: 33, name: r'showDate', type: IsarType.bool),
    r'showIcons': PropertySchema(
      id: 34,
      name: r'showIcons',
      type: IsarType.bool,
    ),
    r'showSeconds': PropertySchema(
      id: 35,
      name: r'showSeconds',
      type: IsarType.bool,
    ),
    r'textAlignment': PropertySchema(
      id: 36,
      name: r'textAlignment',
      type: IsarType.string,
    ),
    r'textCase': PropertySchema(
      id: 37,
      name: r'textCase',
      type: IsarType.string,
    ),
    r'verticalSpacing': PropertySchema(
      id: 38,
      name: r'verticalSpacing',
      type: IsarType.double,
    ),
    r'visibleAppCount': PropertySchema(
      id: 39,
      name: r'visibleAppCount',
      type: IsarType.long,
    ),
  },

  estimateSize: _themeConfigEstimateSize,
  serialize: _themeConfigSerialize,
  deserialize: _themeConfigDeserialize,
  deserializeProp: _themeConfigDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _themeConfigGetId,
  getLinks: _themeConfigGetLinks,
  attach: _themeConfigAttach,
  version: '3.3.2',
);

int _themeConfigEstimateSize(
  ThemeConfig object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.appAlignment.length * 3;
  bytesCount += 3 + object.appDensity.length * 3;
  bytesCount += 3 + object.clockAlignment.length * 3;
  {
    final value = object.clockFontFamily;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.clockFormat.length * 3;
  bytesCount += 3 + object.clockPosition.length * 3;
  bytesCount += 3 + object.colorPreset.length * 3;
  bytesCount += 3 + object.dateFormat.length * 3;
  bytesCount += 3 + object.fontFamily.length * 3;
  bytesCount += 3 + object.iconPack.length * 3;
  bytesCount += 3 + object.iconStyle.length * 3;
  bytesCount += 3 + object.motionMode.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.textAlignment.length * 3;
  bytesCount += 3 + object.textCase.length * 3;
  return bytesCount;
}

void _themeConfigSerialize(
  ThemeConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.accentColorValue);
  writer.writeDouble(offsets[1], object.animationSpeedScale);
  writer.writeString(offsets[2], object.appAlignment);
  writer.writeString(offsets[3], object.appDensity);
  writer.writeLong(offsets[4], object.backgroundColorValue);
  writer.writeString(offsets[5], object.clockAlignment);
  writer.writeString(offsets[6], object.clockFontFamily);
  writer.writeLong(offsets[7], object.clockFontWeight);
  writer.writeString(offsets[8], object.clockFormat);
  writer.writeString(offsets[9], object.clockPosition);
  writer.writeDouble(offsets[10], object.clockSizeScale);
  writer.writeString(offsets[11], object.colorPreset);
  writer.writeString(offsets[12], object.dateFormat);
  writer.writeString(offsets[13], object.fontFamily);
  writer.writeDouble(offsets[14], object.fontSizeScale);
  writer.writeLong(offsets[15], object.fontWeight);
  writer.writeBool(offsets[16], object.hapticFeedback);
  writer.writeBool(offsets[17], object.highContrast);
  writer.writeDouble(offsets[18], object.horizontalPadding);
  writer.writeLong(offsets[19], object.iconColorValue);
  writer.writeDouble(offsets[20], object.iconOpacity);
  writer.writeString(offsets[21], object.iconPack);
  writer.writeDouble(offsets[22], object.iconSize);
  writer.writeString(offsets[23], object.iconStyle);
  writer.writeDouble(offsets[24], object.iconThickness);
  writer.writeBool(offsets[25], object.isCustom);
  writer.writeDouble(offsets[26], object.letterSpacingDelta);
  writer.writeDouble(offsets[27], object.lineHeightScale);
  writer.writeString(offsets[28], object.motionMode);
  writer.writeString(offsets[29], object.name);
  writer.writeLong(offsets[30], object.primaryTextColorValue);
  writer.writeBool(offsets[31], object.reducedMotion);
  writer.writeLong(offsets[32], object.secondaryTextColorValue);
  writer.writeBool(offsets[33], object.showDate);
  writer.writeBool(offsets[34], object.showIcons);
  writer.writeBool(offsets[35], object.showSeconds);
  writer.writeString(offsets[36], object.textAlignment);
  writer.writeString(offsets[37], object.textCase);
  writer.writeDouble(offsets[38], object.verticalSpacing);
  writer.writeLong(offsets[39], object.visibleAppCount);
}

ThemeConfig _themeConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ThemeConfig();
  object.accentColorValue = reader.readLongOrNull(offsets[0]);
  object.animationSpeedScale = reader.readDouble(offsets[1]);
  object.appAlignment = reader.readString(offsets[2]);
  object.appDensity = reader.readString(offsets[3]);
  object.backgroundColorValue = reader.readLongOrNull(offsets[4]);
  object.clockAlignment = reader.readString(offsets[5]);
  object.clockFontFamily = reader.readStringOrNull(offsets[6]);
  object.clockFontWeight = reader.readLongOrNull(offsets[7]);
  object.clockFormat = reader.readString(offsets[8]);
  object.clockPosition = reader.readString(offsets[9]);
  object.clockSizeScale = reader.readDouble(offsets[10]);
  object.colorPreset = reader.readString(offsets[11]);
  object.dateFormat = reader.readString(offsets[12]);
  object.fontFamily = reader.readString(offsets[13]);
  object.fontSizeScale = reader.readDouble(offsets[14]);
  object.fontWeight = reader.readLong(offsets[15]);
  object.hapticFeedback = reader.readBool(offsets[16]);
  object.highContrast = reader.readBool(offsets[17]);
  object.horizontalPadding = reader.readDouble(offsets[18]);
  object.iconColorValue = reader.readLongOrNull(offsets[19]);
  object.iconOpacity = reader.readDouble(offsets[20]);
  object.iconPack = reader.readString(offsets[21]);
  object.iconSize = reader.readDouble(offsets[22]);
  object.iconStyle = reader.readString(offsets[23]);
  object.iconThickness = reader.readDouble(offsets[24]);
  object.id = id;
  object.isCustom = reader.readBool(offsets[25]);
  object.letterSpacingDelta = reader.readDouble(offsets[26]);
  object.lineHeightScale = reader.readDouble(offsets[27]);
  object.motionMode = reader.readString(offsets[28]);
  object.name = reader.readString(offsets[29]);
  object.primaryTextColorValue = reader.readLongOrNull(offsets[30]);
  object.reducedMotion = reader.readBool(offsets[31]);
  object.secondaryTextColorValue = reader.readLongOrNull(offsets[32]);
  object.showDate = reader.readBool(offsets[33]);
  object.showIcons = reader.readBool(offsets[34]);
  object.showSeconds = reader.readBool(offsets[35]);
  object.textAlignment = reader.readString(offsets[36]);
  object.textCase = reader.readString(offsets[37]);
  object.verticalSpacing = reader.readDouble(offsets[38]);
  object.visibleAppCount = reader.readLong(offsets[39]);
  return object;
}

P _themeConfigDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readDouble(offset)) as P;
    case 15:
      return (reader.readLong(offset)) as P;
    case 16:
      return (reader.readBool(offset)) as P;
    case 17:
      return (reader.readBool(offset)) as P;
    case 18:
      return (reader.readDouble(offset)) as P;
    case 19:
      return (reader.readLongOrNull(offset)) as P;
    case 20:
      return (reader.readDouble(offset)) as P;
    case 21:
      return (reader.readString(offset)) as P;
    case 22:
      return (reader.readDouble(offset)) as P;
    case 23:
      return (reader.readString(offset)) as P;
    case 24:
      return (reader.readDouble(offset)) as P;
    case 25:
      return (reader.readBool(offset)) as P;
    case 26:
      return (reader.readDouble(offset)) as P;
    case 27:
      return (reader.readDouble(offset)) as P;
    case 28:
      return (reader.readString(offset)) as P;
    case 29:
      return (reader.readString(offset)) as P;
    case 30:
      return (reader.readLongOrNull(offset)) as P;
    case 31:
      return (reader.readBool(offset)) as P;
    case 32:
      return (reader.readLongOrNull(offset)) as P;
    case 33:
      return (reader.readBool(offset)) as P;
    case 34:
      return (reader.readBool(offset)) as P;
    case 35:
      return (reader.readBool(offset)) as P;
    case 36:
      return (reader.readString(offset)) as P;
    case 37:
      return (reader.readString(offset)) as P;
    case 38:
      return (reader.readDouble(offset)) as P;
    case 39:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _themeConfigGetId(ThemeConfig object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _themeConfigGetLinks(ThemeConfig object) {
  return [];
}

void _themeConfigAttach(
  IsarCollection<dynamic> col,
  Id id,
  ThemeConfig object,
) {
  object.id = id;
}

extension ThemeConfigQueryWhereSort
    on QueryBuilder<ThemeConfig, ThemeConfig, QWhere> {
  QueryBuilder<ThemeConfig, ThemeConfig, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ThemeConfigQueryWhere
    on QueryBuilder<ThemeConfig, ThemeConfig, QWhereClause> {
  QueryBuilder<ThemeConfig, ThemeConfig, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ThemeConfigQueryFilter
    on QueryBuilder<ThemeConfig, ThemeConfig, QFilterCondition> {
  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  accentColorValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'accentColorValue'),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  accentColorValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'accentColorValue'),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  accentColorValueEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'accentColorValue', value: value),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  accentColorValueGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'accentColorValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  accentColorValueLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'accentColorValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  accentColorValueBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'accentColorValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  animationSpeedScaleEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'animationSpeedScale',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  animationSpeedScaleGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'animationSpeedScale',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  animationSpeedScaleLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'animationSpeedScale',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  animationSpeedScaleBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'animationSpeedScale',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appAlignmentEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'appAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appAlignmentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'appAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appAlignmentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'appAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appAlignmentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'appAlignment',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appAlignmentStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'appAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appAlignmentEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'appAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appAlignmentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'appAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appAlignmentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'appAlignment',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appAlignmentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'appAlignment', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appAlignmentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'appAlignment', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appDensityEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'appDensity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appDensityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'appDensity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appDensityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'appDensity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appDensityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'appDensity',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appDensityStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'appDensity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appDensityEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'appDensity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appDensityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'appDensity',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appDensityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'appDensity',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appDensityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'appDensity', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  appDensityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'appDensity', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  backgroundColorValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'backgroundColorValue'),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  backgroundColorValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'backgroundColorValue'),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  backgroundColorValueEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'backgroundColorValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  backgroundColorValueGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'backgroundColorValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  backgroundColorValueLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'backgroundColorValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  backgroundColorValueBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'backgroundColorValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockAlignmentEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'clockAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockAlignmentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'clockAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockAlignmentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'clockAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockAlignmentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'clockAlignment',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockAlignmentStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'clockAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockAlignmentEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'clockAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockAlignmentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'clockAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockAlignmentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'clockAlignment',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockAlignmentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'clockAlignment', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockAlignmentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'clockAlignment', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontFamilyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'clockFontFamily'),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontFamilyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'clockFontFamily'),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontFamilyEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'clockFontFamily',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontFamilyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'clockFontFamily',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontFamilyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'clockFontFamily',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontFamilyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'clockFontFamily',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontFamilyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'clockFontFamily',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontFamilyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'clockFontFamily',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontFamilyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'clockFontFamily',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontFamilyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'clockFontFamily',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontFamilyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'clockFontFamily', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontFamilyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'clockFontFamily', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontWeightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'clockFontWeight'),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontWeightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'clockFontWeight'),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontWeightEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'clockFontWeight', value: value),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontWeightGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'clockFontWeight',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontWeightLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'clockFontWeight',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFontWeightBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'clockFontWeight',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFormatEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'clockFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFormatGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'clockFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFormatLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'clockFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFormatBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'clockFormat',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFormatStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'clockFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFormatEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'clockFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFormatContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'clockFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFormatMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'clockFormat',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFormatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'clockFormat', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockFormatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'clockFormat', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockPositionEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'clockPosition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockPositionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'clockPosition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockPositionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'clockPosition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockPositionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'clockPosition',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockPositionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'clockPosition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockPositionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'clockPosition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockPositionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'clockPosition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockPositionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'clockPosition',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockPositionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'clockPosition', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockPositionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'clockPosition', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockSizeScaleEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'clockSizeScale',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockSizeScaleGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'clockSizeScale',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockSizeScaleLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'clockSizeScale',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  clockSizeScaleBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'clockSizeScale',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  colorPresetEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'colorPreset',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  colorPresetGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'colorPreset',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  colorPresetLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'colorPreset',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  colorPresetBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'colorPreset',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  colorPresetStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'colorPreset',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  colorPresetEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'colorPreset',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  colorPresetContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'colorPreset',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  colorPresetMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'colorPreset',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  colorPresetIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'colorPreset', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  colorPresetIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'colorPreset', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  dateFormatEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'dateFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  dateFormatGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dateFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  dateFormatLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dateFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  dateFormatBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dateFormat',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  dateFormatStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'dateFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  dateFormatEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'dateFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  dateFormatContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'dateFormat',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  dateFormatMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'dateFormat',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  dateFormatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dateFormat', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  dateFormatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'dateFormat', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontFamilyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fontFamily',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontFamilyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fontFamily',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontFamilyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fontFamily',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontFamilyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fontFamily',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontFamilyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'fontFamily',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontFamilyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'fontFamily',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontFamilyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'fontFamily',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontFamilyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'fontFamily',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontFamilyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fontFamily', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontFamilyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'fontFamily', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontSizeScaleEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fontSizeScale',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontSizeScaleGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fontSizeScale',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontSizeScaleLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fontSizeScale',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontSizeScaleBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fontSizeScale',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontWeightEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fontWeight', value: value),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontWeightGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fontWeight',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontWeightLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fontWeight',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  fontWeightBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fontWeight',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  hapticFeedbackEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hapticFeedback', value: value),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  highContrastEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'highContrast', value: value),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  horizontalPaddingEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'horizontalPadding',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  horizontalPaddingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'horizontalPadding',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  horizontalPaddingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'horizontalPadding',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  horizontalPaddingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'horizontalPadding',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconColorValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'iconColorValue'),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconColorValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'iconColorValue'),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconColorValueEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'iconColorValue', value: value),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconColorValueGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'iconColorValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconColorValueLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'iconColorValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconColorValueBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'iconColorValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconOpacityEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'iconOpacity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconOpacityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'iconOpacity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconOpacityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'iconOpacity',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconOpacityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'iconOpacity',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> iconPackEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'iconPack',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconPackGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'iconPack',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconPackLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'iconPack',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> iconPackBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'iconPack',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconPackStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'iconPack',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconPackEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'iconPack',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconPackContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'iconPack',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> iconPackMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'iconPack',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconPackIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'iconPack', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconPackIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'iconPack', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> iconSizeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'iconSize',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconSizeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'iconSize',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconSizeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'iconSize',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> iconSizeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'iconSize',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconStyleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'iconStyle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconStyleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'iconStyle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconStyleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'iconStyle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconStyleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'iconStyle',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconStyleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'iconStyle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconStyleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'iconStyle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconStyleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'iconStyle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconStyleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'iconStyle',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconStyleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'iconStyle', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconStyleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'iconStyle', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconThicknessEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'iconThickness',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconThicknessGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'iconThickness',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconThicknessLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'iconThickness',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  iconThicknessBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'iconThickness',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> isCustomEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isCustom', value: value),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  letterSpacingDeltaEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'letterSpacingDelta',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  letterSpacingDeltaGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'letterSpacingDelta',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  letterSpacingDeltaLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'letterSpacingDelta',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  letterSpacingDeltaBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'letterSpacingDelta',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  lineHeightScaleEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'lineHeightScale',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  lineHeightScaleGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lineHeightScale',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  lineHeightScaleLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lineHeightScale',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  lineHeightScaleBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lineHeightScale',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  motionModeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'motionMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  motionModeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'motionMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  motionModeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'motionMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  motionModeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'motionMode',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  motionModeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'motionMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  motionModeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'motionMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  motionModeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'motionMode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  motionModeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'motionMode',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  motionModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'motionMode', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  motionModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'motionMode', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> nameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> nameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  primaryTextColorValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'primaryTextColorValue'),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  primaryTextColorValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'primaryTextColorValue'),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  primaryTextColorValueEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'primaryTextColorValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  primaryTextColorValueGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'primaryTextColorValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  primaryTextColorValueLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'primaryTextColorValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  primaryTextColorValueBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'primaryTextColorValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  reducedMotionEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'reducedMotion', value: value),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  secondaryTextColorValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'secondaryTextColorValue'),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  secondaryTextColorValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'secondaryTextColorValue'),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  secondaryTextColorValueEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'secondaryTextColorValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  secondaryTextColorValueGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'secondaryTextColorValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  secondaryTextColorValueLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'secondaryTextColorValue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  secondaryTextColorValueBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'secondaryTextColorValue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> showDateEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'showDate', value: value),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  showIconsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'showIcons', value: value),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  showSecondsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'showSeconds', value: value),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  textAlignmentEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'textAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  textAlignmentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'textAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  textAlignmentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'textAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  textAlignmentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'textAlignment',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  textAlignmentStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'textAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  textAlignmentEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'textAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  textAlignmentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'textAlignment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  textAlignmentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'textAlignment',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  textAlignmentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'textAlignment', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  textAlignmentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'textAlignment', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> textCaseEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'textCase',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  textCaseGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'textCase',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  textCaseLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'textCase',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> textCaseBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'textCase',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  textCaseStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'textCase',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  textCaseEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'textCase',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  textCaseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'textCase',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition> textCaseMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'textCase',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  textCaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'textCase', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  textCaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'textCase', value: ''),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  verticalSpacingEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'verticalSpacing',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  verticalSpacingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'verticalSpacing',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  verticalSpacingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'verticalSpacing',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  verticalSpacingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'verticalSpacing',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  visibleAppCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'visibleAppCount', value: value),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  visibleAppCountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'visibleAppCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  visibleAppCountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'visibleAppCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterFilterCondition>
  visibleAppCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'visibleAppCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ThemeConfigQueryObject
    on QueryBuilder<ThemeConfig, ThemeConfig, QFilterCondition> {}

extension ThemeConfigQueryLinks
    on QueryBuilder<ThemeConfig, ThemeConfig, QFilterCondition> {}

extension ThemeConfigQuerySortBy
    on QueryBuilder<ThemeConfig, ThemeConfig, QSortBy> {
  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByAccentColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accentColorValue', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByAccentColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accentColorValue', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByAnimationSpeedScale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animationSpeedScale', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByAnimationSpeedScaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animationSpeedScale', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByAppAlignment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appAlignment', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByAppAlignmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appAlignment', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByAppDensity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appDensity', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByAppDensityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appDensity', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByBackgroundColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundColorValue', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByBackgroundColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundColorValue', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByClockAlignment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockAlignment', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByClockAlignmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockAlignment', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByClockFontFamily() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockFontFamily', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByClockFontFamilyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockFontFamily', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByClockFontWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockFontWeight', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByClockFontWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockFontWeight', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByClockFormat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockFormat', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByClockFormatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockFormat', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByClockPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockPosition', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByClockPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockPosition', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByClockSizeScale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockSizeScale', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByClockSizeScaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockSizeScale', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByColorPreset() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorPreset', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByColorPresetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorPreset', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByDateFormat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFormat', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByDateFormatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFormat', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByFontFamily() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontFamily', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByFontFamilyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontFamily', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByFontSizeScale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontSizeScale', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByFontSizeScaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontSizeScale', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByFontWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontWeight', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByFontWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontWeight', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByHapticFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hapticFeedback', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByHapticFeedbackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hapticFeedback', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByHighContrast() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'highContrast', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByHighContrastDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'highContrast', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByHorizontalPadding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horizontalPadding', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByHorizontalPaddingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horizontalPadding', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByIconColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconColorValue', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByIconColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconColorValue', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByIconOpacity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconOpacity', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByIconOpacityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconOpacity', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByIconPack() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconPack', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByIconPackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconPack', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByIconSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconSize', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByIconSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconSize', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByIconStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconStyle', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByIconStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconStyle', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByIconThickness() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconThickness', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByIconThicknessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconThickness', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByIsCustomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByLetterSpacingDelta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterSpacingDelta', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByLetterSpacingDeltaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterSpacingDelta', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByLineHeightScale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineHeightScale', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByLineHeightScaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineHeightScale', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByMotionMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motionMode', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByMotionModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motionMode', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByPrimaryTextColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryTextColorValue', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByPrimaryTextColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryTextColorValue', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByReducedMotion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reducedMotion', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByReducedMotionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reducedMotion', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortBySecondaryTextColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryTextColorValue', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortBySecondaryTextColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryTextColorValue', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByShowDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showDate', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByShowDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showDate', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByShowIcons() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showIcons', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByShowIconsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showIcons', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByShowSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showSeconds', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByShowSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showSeconds', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByTextAlignment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textAlignment', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByTextAlignmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textAlignment', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByTextCase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textCase', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByTextCaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textCase', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByVerticalSpacing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verticalSpacing', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByVerticalSpacingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verticalSpacing', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> sortByVisibleAppCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visibleAppCount', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  sortByVisibleAppCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visibleAppCount', Sort.desc);
    });
  }
}

extension ThemeConfigQuerySortThenBy
    on QueryBuilder<ThemeConfig, ThemeConfig, QSortThenBy> {
  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByAccentColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accentColorValue', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByAccentColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accentColorValue', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByAnimationSpeedScale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animationSpeedScale', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByAnimationSpeedScaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animationSpeedScale', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByAppAlignment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appAlignment', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByAppAlignmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appAlignment', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByAppDensity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appDensity', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByAppDensityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appDensity', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByBackgroundColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundColorValue', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByBackgroundColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backgroundColorValue', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByClockAlignment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockAlignment', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByClockAlignmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockAlignment', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByClockFontFamily() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockFontFamily', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByClockFontFamilyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockFontFamily', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByClockFontWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockFontWeight', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByClockFontWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockFontWeight', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByClockFormat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockFormat', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByClockFormatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockFormat', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByClockPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockPosition', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByClockPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockPosition', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByClockSizeScale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockSizeScale', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByClockSizeScaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockSizeScale', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByColorPreset() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorPreset', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByColorPresetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorPreset', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByDateFormat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFormat', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByDateFormatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFormat', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByFontFamily() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontFamily', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByFontFamilyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontFamily', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByFontSizeScale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontSizeScale', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByFontSizeScaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontSizeScale', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByFontWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontWeight', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByFontWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontWeight', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByHapticFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hapticFeedback', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByHapticFeedbackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hapticFeedback', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByHighContrast() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'highContrast', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByHighContrastDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'highContrast', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByHorizontalPadding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horizontalPadding', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByHorizontalPaddingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'horizontalPadding', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByIconColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconColorValue', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByIconColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconColorValue', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByIconOpacity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconOpacity', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByIconOpacityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconOpacity', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByIconPack() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconPack', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByIconPackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconPack', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByIconSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconSize', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByIconSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconSize', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByIconStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconStyle', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByIconStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconStyle', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByIconThickness() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconThickness', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByIconThicknessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconThickness', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByIsCustomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByLetterSpacingDelta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterSpacingDelta', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByLetterSpacingDeltaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterSpacingDelta', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByLineHeightScale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineHeightScale', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByLineHeightScaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineHeightScale', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByMotionMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motionMode', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByMotionModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'motionMode', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByPrimaryTextColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryTextColorValue', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByPrimaryTextColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryTextColorValue', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByReducedMotion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reducedMotion', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByReducedMotionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reducedMotion', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenBySecondaryTextColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryTextColorValue', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenBySecondaryTextColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secondaryTextColorValue', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByShowDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showDate', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByShowDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showDate', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByShowIcons() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showIcons', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByShowIconsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showIcons', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByShowSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showSeconds', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByShowSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showSeconds', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByTextAlignment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textAlignment', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByTextAlignmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textAlignment', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByTextCase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textCase', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByTextCaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textCase', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByVerticalSpacing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verticalSpacing', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByVerticalSpacingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verticalSpacing', Sort.desc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy> thenByVisibleAppCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visibleAppCount', Sort.asc);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QAfterSortBy>
  thenByVisibleAppCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visibleAppCount', Sort.desc);
    });
  }
}

extension ThemeConfigQueryWhereDistinct
    on QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> {
  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct>
  distinctByAccentColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accentColorValue');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct>
  distinctByAnimationSpeedScale() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'animationSpeedScale');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByAppAlignment({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appAlignment', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByAppDensity({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appDensity', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct>
  distinctByBackgroundColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'backgroundColorValue');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByClockAlignment({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'clockAlignment',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByClockFontFamily({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'clockFontFamily',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct>
  distinctByClockFontWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clockFontWeight');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByClockFormat({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clockFormat', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByClockPosition({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'clockPosition',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByClockSizeScale() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clockSizeScale');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByColorPreset({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'colorPreset', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByDateFormat({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateFormat', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByFontFamily({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fontFamily', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByFontSizeScale() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fontSizeScale');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByFontWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fontWeight');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByHapticFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hapticFeedback');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByHighContrast() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'highContrast');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct>
  distinctByHorizontalPadding() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'horizontalPadding');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByIconColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconColorValue');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByIconOpacity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconOpacity');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByIconPack({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconPack', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByIconSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconSize');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByIconStyle({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconStyle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByIconThickness() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconThickness');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCustom');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct>
  distinctByLetterSpacingDelta() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'letterSpacingDelta');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct>
  distinctByLineHeightScale() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lineHeightScale');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByMotionMode({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'motionMode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct>
  distinctByPrimaryTextColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'primaryTextColorValue');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByReducedMotion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reducedMotion');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct>
  distinctBySecondaryTextColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'secondaryTextColorValue');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByShowDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'showDate');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByShowIcons() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'showIcons');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByShowSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'showSeconds');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByTextAlignment({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'textAlignment',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct> distinctByTextCase({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textCase', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct>
  distinctByVerticalSpacing() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verticalSpacing');
    });
  }

  QueryBuilder<ThemeConfig, ThemeConfig, QDistinct>
  distinctByVisibleAppCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'visibleAppCount');
    });
  }
}

extension ThemeConfigQueryProperty
    on QueryBuilder<ThemeConfig, ThemeConfig, QQueryProperty> {
  QueryBuilder<ThemeConfig, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ThemeConfig, int?, QQueryOperations> accentColorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accentColorValue');
    });
  }

  QueryBuilder<ThemeConfig, double, QQueryOperations>
  animationSpeedScaleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'animationSpeedScale');
    });
  }

  QueryBuilder<ThemeConfig, String, QQueryOperations> appAlignmentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appAlignment');
    });
  }

  QueryBuilder<ThemeConfig, String, QQueryOperations> appDensityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appDensity');
    });
  }

  QueryBuilder<ThemeConfig, int?, QQueryOperations>
  backgroundColorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'backgroundColorValue');
    });
  }

  QueryBuilder<ThemeConfig, String, QQueryOperations> clockAlignmentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clockAlignment');
    });
  }

  QueryBuilder<ThemeConfig, String?, QQueryOperations>
  clockFontFamilyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clockFontFamily');
    });
  }

  QueryBuilder<ThemeConfig, int?, QQueryOperations> clockFontWeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clockFontWeight');
    });
  }

  QueryBuilder<ThemeConfig, String, QQueryOperations> clockFormatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clockFormat');
    });
  }

  QueryBuilder<ThemeConfig, String, QQueryOperations> clockPositionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clockPosition');
    });
  }

  QueryBuilder<ThemeConfig, double, QQueryOperations> clockSizeScaleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clockSizeScale');
    });
  }

  QueryBuilder<ThemeConfig, String, QQueryOperations> colorPresetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'colorPreset');
    });
  }

  QueryBuilder<ThemeConfig, String, QQueryOperations> dateFormatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateFormat');
    });
  }

  QueryBuilder<ThemeConfig, String, QQueryOperations> fontFamilyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fontFamily');
    });
  }

  QueryBuilder<ThemeConfig, double, QQueryOperations> fontSizeScaleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fontSizeScale');
    });
  }

  QueryBuilder<ThemeConfig, int, QQueryOperations> fontWeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fontWeight');
    });
  }

  QueryBuilder<ThemeConfig, bool, QQueryOperations> hapticFeedbackProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hapticFeedback');
    });
  }

  QueryBuilder<ThemeConfig, bool, QQueryOperations> highContrastProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'highContrast');
    });
  }

  QueryBuilder<ThemeConfig, double, QQueryOperations>
  horizontalPaddingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'horizontalPadding');
    });
  }

  QueryBuilder<ThemeConfig, int?, QQueryOperations> iconColorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconColorValue');
    });
  }

  QueryBuilder<ThemeConfig, double, QQueryOperations> iconOpacityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconOpacity');
    });
  }

  QueryBuilder<ThemeConfig, String, QQueryOperations> iconPackProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconPack');
    });
  }

  QueryBuilder<ThemeConfig, double, QQueryOperations> iconSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconSize');
    });
  }

  QueryBuilder<ThemeConfig, String, QQueryOperations> iconStyleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconStyle');
    });
  }

  QueryBuilder<ThemeConfig, double, QQueryOperations> iconThicknessProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconThickness');
    });
  }

  QueryBuilder<ThemeConfig, bool, QQueryOperations> isCustomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCustom');
    });
  }

  QueryBuilder<ThemeConfig, double, QQueryOperations>
  letterSpacingDeltaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'letterSpacingDelta');
    });
  }

  QueryBuilder<ThemeConfig, double, QQueryOperations>
  lineHeightScaleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lineHeightScale');
    });
  }

  QueryBuilder<ThemeConfig, String, QQueryOperations> motionModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'motionMode');
    });
  }

  QueryBuilder<ThemeConfig, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ThemeConfig, int?, QQueryOperations>
  primaryTextColorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'primaryTextColorValue');
    });
  }

  QueryBuilder<ThemeConfig, bool, QQueryOperations> reducedMotionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reducedMotion');
    });
  }

  QueryBuilder<ThemeConfig, int?, QQueryOperations>
  secondaryTextColorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'secondaryTextColorValue');
    });
  }

  QueryBuilder<ThemeConfig, bool, QQueryOperations> showDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'showDate');
    });
  }

  QueryBuilder<ThemeConfig, bool, QQueryOperations> showIconsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'showIcons');
    });
  }

  QueryBuilder<ThemeConfig, bool, QQueryOperations> showSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'showSeconds');
    });
  }

  QueryBuilder<ThemeConfig, String, QQueryOperations> textAlignmentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textAlignment');
    });
  }

  QueryBuilder<ThemeConfig, String, QQueryOperations> textCaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textCase');
    });
  }

  QueryBuilder<ThemeConfig, double, QQueryOperations>
  verticalSpacingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verticalSpacing');
    });
  }

  QueryBuilder<ThemeConfig, int, QQueryOperations> visibleAppCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'visibleAppCount');
    });
  }
}

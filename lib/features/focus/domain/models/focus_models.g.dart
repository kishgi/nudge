// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFocusRuleCollection on Isar {
  IsarCollection<FocusRule> get focusRules => this.collection();
}

const FocusRuleSchema = CollectionSchema(
  name: r'FocusRule',
  id: 6548921015924622523,
  properties: {
    r'customMessage': PropertySchema(
      id: 0,
      name: r'customMessage',
      type: IsarType.string,
    ),
    r'delaySeconds': PropertySchema(
      id: 1,
      name: r'delaySeconds',
      type: IsarType.long,
    ),
    r'endHour': PropertySchema(id: 2, name: r'endHour', type: IsarType.long),
    r'endMinute': PropertySchema(
      id: 3,
      name: r'endMinute',
      type: IsarType.long,
    ),
    r'isBlocked': PropertySchema(
      id: 4,
      name: r'isBlocked',
      type: IsarType.bool,
    ),
    r'packageName': PropertySchema(
      id: 5,
      name: r'packageName',
      type: IsarType.string,
    ),
    r'scheduleDays': PropertySchema(
      id: 6,
      name: r'scheduleDays',
      type: IsarType.longList,
    ),
    r'scheduleEnabled': PropertySchema(
      id: 7,
      name: r'scheduleEnabled',
      type: IsarType.bool,
    ),
    r'startHour': PropertySchema(
      id: 8,
      name: r'startHour',
      type: IsarType.long,
    ),
    r'startMinute': PropertySchema(
      id: 9,
      name: r'startMinute',
      type: IsarType.long,
    ),
  },

  estimateSize: _focusRuleEstimateSize,
  serialize: _focusRuleSerialize,
  deserialize: _focusRuleDeserialize,
  deserializeProp: _focusRuleDeserializeProp,
  idName: r'id',
  indexes: {
    r'packageName': IndexSchema(
      id: -3211024755902609907,
      name: r'packageName',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'packageName',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _focusRuleGetId,
  getLinks: _focusRuleGetLinks,
  attach: _focusRuleAttach,
  version: '3.3.2',
);

int _focusRuleEstimateSize(
  FocusRule object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.customMessage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.packageName.length * 3;
  bytesCount += 3 + object.scheduleDays.length * 8;
  return bytesCount;
}

void _focusRuleSerialize(
  FocusRule object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.customMessage);
  writer.writeLong(offsets[1], object.delaySeconds);
  writer.writeLong(offsets[2], object.endHour);
  writer.writeLong(offsets[3], object.endMinute);
  writer.writeBool(offsets[4], object.isBlocked);
  writer.writeString(offsets[5], object.packageName);
  writer.writeLongList(offsets[6], object.scheduleDays);
  writer.writeBool(offsets[7], object.scheduleEnabled);
  writer.writeLong(offsets[8], object.startHour);
  writer.writeLong(offsets[9], object.startMinute);
}

FocusRule _focusRuleDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FocusRule();
  object.customMessage = reader.readStringOrNull(offsets[0]);
  object.delaySeconds = reader.readLong(offsets[1]);
  object.endHour = reader.readLong(offsets[2]);
  object.endMinute = reader.readLong(offsets[3]);
  object.id = id;
  object.isBlocked = reader.readBool(offsets[4]);
  object.packageName = reader.readString(offsets[5]);
  object.scheduleDays = reader.readLongList(offsets[6]) ?? [];
  object.scheduleEnabled = reader.readBool(offsets[7]);
  object.startHour = reader.readLong(offsets[8]);
  object.startMinute = reader.readLong(offsets[9]);
  return object;
}

P _focusRuleDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLongList(offset) ?? []) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _focusRuleGetId(FocusRule object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _focusRuleGetLinks(FocusRule object) {
  return [];
}

void _focusRuleAttach(IsarCollection<dynamic> col, Id id, FocusRule object) {
  object.id = id;
}

extension FocusRuleByIndex on IsarCollection<FocusRule> {
  Future<FocusRule?> getByPackageName(String packageName) {
    return getByIndex(r'packageName', [packageName]);
  }

  FocusRule? getByPackageNameSync(String packageName) {
    return getByIndexSync(r'packageName', [packageName]);
  }

  Future<bool> deleteByPackageName(String packageName) {
    return deleteByIndex(r'packageName', [packageName]);
  }

  bool deleteByPackageNameSync(String packageName) {
    return deleteByIndexSync(r'packageName', [packageName]);
  }

  Future<List<FocusRule?>> getAllByPackageName(List<String> packageNameValues) {
    final values = packageNameValues.map((e) => [e]).toList();
    return getAllByIndex(r'packageName', values);
  }

  List<FocusRule?> getAllByPackageNameSync(List<String> packageNameValues) {
    final values = packageNameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'packageName', values);
  }

  Future<int> deleteAllByPackageName(List<String> packageNameValues) {
    final values = packageNameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'packageName', values);
  }

  int deleteAllByPackageNameSync(List<String> packageNameValues) {
    final values = packageNameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'packageName', values);
  }

  Future<Id> putByPackageName(FocusRule object) {
    return putByIndex(r'packageName', object);
  }

  Id putByPackageNameSync(FocusRule object, {bool saveLinks = true}) {
    return putByIndexSync(r'packageName', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByPackageName(List<FocusRule> objects) {
    return putAllByIndex(r'packageName', objects);
  }

  List<Id> putAllByPackageNameSync(
    List<FocusRule> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'packageName', objects, saveLinks: saveLinks);
  }
}

extension FocusRuleQueryWhereSort
    on QueryBuilder<FocusRule, FocusRule, QWhere> {
  QueryBuilder<FocusRule, FocusRule, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FocusRuleQueryWhere
    on QueryBuilder<FocusRule, FocusRule, QWhereClause> {
  QueryBuilder<FocusRule, FocusRule, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<FocusRule, FocusRule, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterWhereClause> idBetween(
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

  QueryBuilder<FocusRule, FocusRule, QAfterWhereClause> packageNameEqualTo(
    String packageName,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'packageName',
          value: [packageName],
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterWhereClause> packageNameNotEqualTo(
    String packageName,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'packageName',
                lower: [],
                upper: [packageName],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'packageName',
                lower: [packageName],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'packageName',
                lower: [packageName],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'packageName',
                lower: [],
                upper: [packageName],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension FocusRuleQueryFilter
    on QueryBuilder<FocusRule, FocusRule, QFilterCondition> {
  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  customMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'customMessage'),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  customMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'customMessage'),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  customMessageEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'customMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  customMessageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'customMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  customMessageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'customMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  customMessageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'customMessage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  customMessageStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'customMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  customMessageEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'customMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  customMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'customMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  customMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'customMessage',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  customMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'customMessage', value: ''),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  customMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'customMessage', value: ''),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> delaySecondsEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'delaySeconds', value: value),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  delaySecondsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'delaySeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  delaySecondsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'delaySeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> delaySecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'delaySeconds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> endHourEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'endHour', value: value),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> endHourGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'endHour',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> endHourLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'endHour',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> endHourBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'endHour',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> endMinuteEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'endMinute', value: value),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  endMinuteGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'endMinute',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> endMinuteLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'endMinute',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> endMinuteBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'endMinute',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> isBlockedEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isBlocked', value: value),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> packageNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'packageName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  packageNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'packageName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> packageNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'packageName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> packageNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'packageName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  packageNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'packageName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> packageNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'packageName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> packageNameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'packageName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> packageNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'packageName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  packageNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'packageName', value: ''),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  packageNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'packageName', value: ''),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  scheduleDaysElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'scheduleDays', value: value),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  scheduleDaysElementGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'scheduleDays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  scheduleDaysElementLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'scheduleDays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  scheduleDaysElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'scheduleDays',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  scheduleDaysLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'scheduleDays', length, true, length, true);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  scheduleDaysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'scheduleDays', 0, true, 0, true);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  scheduleDaysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'scheduleDays', 0, false, 999999, true);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  scheduleDaysLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'scheduleDays', 0, true, length, include);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  scheduleDaysLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'scheduleDays', length, include, 999999, true);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  scheduleDaysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scheduleDays',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  scheduleEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'scheduleEnabled', value: value),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> startHourEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'startHour', value: value),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  startHourGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'startHour',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> startHourLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'startHour',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> startHourBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'startHour',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> startMinuteEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'startMinute', value: value),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition>
  startMinuteGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'startMinute',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> startMinuteLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'startMinute',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterFilterCondition> startMinuteBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'startMinute',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension FocusRuleQueryObject
    on QueryBuilder<FocusRule, FocusRule, QFilterCondition> {}

extension FocusRuleQueryLinks
    on QueryBuilder<FocusRule, FocusRule, QFilterCondition> {}

extension FocusRuleQuerySortBy on QueryBuilder<FocusRule, FocusRule, QSortBy> {
  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByCustomMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customMessage', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByCustomMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customMessage', Sort.desc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByDelaySeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delaySeconds', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByDelaySecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delaySeconds', Sort.desc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByEndHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endHour', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByEndHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endHour', Sort.desc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByEndMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endMinute', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByEndMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endMinute', Sort.desc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByIsBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlocked', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByIsBlockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlocked', Sort.desc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByPackageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packageName', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByPackageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packageName', Sort.desc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByScheduleEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleEnabled', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByScheduleEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleEnabled', Sort.desc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByStartHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startHour', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByStartHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startHour', Sort.desc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByStartMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startMinute', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> sortByStartMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startMinute', Sort.desc);
    });
  }
}

extension FocusRuleQuerySortThenBy
    on QueryBuilder<FocusRule, FocusRule, QSortThenBy> {
  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByCustomMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customMessage', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByCustomMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customMessage', Sort.desc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByDelaySeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delaySeconds', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByDelaySecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delaySeconds', Sort.desc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByEndHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endHour', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByEndHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endHour', Sort.desc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByEndMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endMinute', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByEndMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endMinute', Sort.desc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByIsBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlocked', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByIsBlockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBlocked', Sort.desc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByPackageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packageName', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByPackageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packageName', Sort.desc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByScheduleEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleEnabled', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByScheduleEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleEnabled', Sort.desc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByStartHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startHour', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByStartHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startHour', Sort.desc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByStartMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startMinute', Sort.asc);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QAfterSortBy> thenByStartMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startMinute', Sort.desc);
    });
  }
}

extension FocusRuleQueryWhereDistinct
    on QueryBuilder<FocusRule, FocusRule, QDistinct> {
  QueryBuilder<FocusRule, FocusRule, QDistinct> distinctByCustomMessage({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'customMessage',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<FocusRule, FocusRule, QDistinct> distinctByDelaySeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'delaySeconds');
    });
  }

  QueryBuilder<FocusRule, FocusRule, QDistinct> distinctByEndHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endHour');
    });
  }

  QueryBuilder<FocusRule, FocusRule, QDistinct> distinctByEndMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endMinute');
    });
  }

  QueryBuilder<FocusRule, FocusRule, QDistinct> distinctByIsBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isBlocked');
    });
  }

  QueryBuilder<FocusRule, FocusRule, QDistinct> distinctByPackageName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'packageName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FocusRule, FocusRule, QDistinct> distinctByScheduleDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduleDays');
    });
  }

  QueryBuilder<FocusRule, FocusRule, QDistinct> distinctByScheduleEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduleEnabled');
    });
  }

  QueryBuilder<FocusRule, FocusRule, QDistinct> distinctByStartHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startHour');
    });
  }

  QueryBuilder<FocusRule, FocusRule, QDistinct> distinctByStartMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startMinute');
    });
  }
}

extension FocusRuleQueryProperty
    on QueryBuilder<FocusRule, FocusRule, QQueryProperty> {
  QueryBuilder<FocusRule, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FocusRule, String?, QQueryOperations> customMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customMessage');
    });
  }

  QueryBuilder<FocusRule, int, QQueryOperations> delaySecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'delaySeconds');
    });
  }

  QueryBuilder<FocusRule, int, QQueryOperations> endHourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endHour');
    });
  }

  QueryBuilder<FocusRule, int, QQueryOperations> endMinuteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endMinute');
    });
  }

  QueryBuilder<FocusRule, bool, QQueryOperations> isBlockedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isBlocked');
    });
  }

  QueryBuilder<FocusRule, String, QQueryOperations> packageNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'packageName');
    });
  }

  QueryBuilder<FocusRule, List<int>, QQueryOperations> scheduleDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduleDays');
    });
  }

  QueryBuilder<FocusRule, bool, QQueryOperations> scheduleEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduleEnabled');
    });
  }

  QueryBuilder<FocusRule, int, QQueryOperations> startHourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startHour');
    });
  }

  QueryBuilder<FocusRule, int, QQueryOperations> startMinuteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startMinute');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFocusSessionCollection on Isar {
  IsarCollection<FocusSession> get focusSessions => this.collection();
}

const FocusSessionSchema = CollectionSchema(
  name: r'FocusSession',
  id: 7529488139707530527,
  properties: {
    r'customName': PropertySchema(
      id: 0,
      name: r'customName',
      type: IsarType.string,
    ),
    r'endTime': PropertySchema(
      id: 1,
      name: r'endTime',
      type: IsarType.dateTime,
    ),
    r'isActive': PropertySchema(id: 2, name: r'isActive', type: IsarType.bool),
    r'isCompleted': PropertySchema(
      id: 3,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'mode': PropertySchema(id: 4, name: r'mode', type: IsarType.string),
    r'startTime': PropertySchema(
      id: 5,
      name: r'startTime',
      type: IsarType.dateTime,
    ),
    r'targetDurationMinutes': PropertySchema(
      id: 6,
      name: r'targetDurationMinutes',
      type: IsarType.long,
    ),
  },

  estimateSize: _focusSessionEstimateSize,
  serialize: _focusSessionSerialize,
  deserialize: _focusSessionDeserialize,
  deserializeProp: _focusSessionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _focusSessionGetId,
  getLinks: _focusSessionGetLinks,
  attach: _focusSessionAttach,
  version: '3.3.2',
);

int _focusSessionEstimateSize(
  FocusSession object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.customName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.mode.length * 3;
  return bytesCount;
}

void _focusSessionSerialize(
  FocusSession object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.customName);
  writer.writeDateTime(offsets[1], object.endTime);
  writer.writeBool(offsets[2], object.isActive);
  writer.writeBool(offsets[3], object.isCompleted);
  writer.writeString(offsets[4], object.mode);
  writer.writeDateTime(offsets[5], object.startTime);
  writer.writeLong(offsets[6], object.targetDurationMinutes);
}

FocusSession _focusSessionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FocusSession();
  object.customName = reader.readStringOrNull(offsets[0]);
  object.endTime = reader.readDateTimeOrNull(offsets[1]);
  object.id = id;
  object.isCompleted = reader.readBool(offsets[3]);
  object.mode = reader.readString(offsets[4]);
  object.startTime = reader.readDateTime(offsets[5]);
  object.targetDurationMinutes = reader.readLong(offsets[6]);
  return object;
}

P _focusSessionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _focusSessionGetId(FocusSession object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _focusSessionGetLinks(FocusSession object) {
  return [];
}

void _focusSessionAttach(
  IsarCollection<dynamic> col,
  Id id,
  FocusSession object,
) {
  object.id = id;
}

extension FocusSessionQueryWhereSort
    on QueryBuilder<FocusSession, FocusSession, QWhere> {
  QueryBuilder<FocusSession, FocusSession, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FocusSessionQueryWhere
    on QueryBuilder<FocusSession, FocusSession, QWhereClause> {
  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause> idBetween(
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

extension FocusSessionQueryFilter
    on QueryBuilder<FocusSession, FocusSession, QFilterCondition> {
  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  customNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'customName'),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  customNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'customName'),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  customNameEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'customName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  customNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'customName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  customNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'customName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  customNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'customName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  customNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'customName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  customNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'customName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  customNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'customName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  customNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'customName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  customNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'customName', value: ''),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  customNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'customName', value: ''),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  endTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'endTime'),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  endTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'endTime'),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  endTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'endTime', value: value),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  endTimeGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'endTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  endTimeLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'endTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  endTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'endTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isActive', value: value),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isCompleted', value: value),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> modeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'mode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  modeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'mode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> modeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'mode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> modeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'mode',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  modeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'mode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> modeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'mode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> modeContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'mode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> modeMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'mode',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  modeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'mode', value: ''),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  modeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'mode', value: ''),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  startTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'startTime', value: value),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  startTimeGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'startTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  startTimeLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'startTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  startTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'startTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  targetDurationMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'targetDurationMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  targetDurationMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'targetDurationMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  targetDurationMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'targetDurationMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
  targetDurationMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'targetDurationMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension FocusSessionQueryObject
    on QueryBuilder<FocusSession, FocusSession, QFilterCondition> {}

extension FocusSessionQueryLinks
    on QueryBuilder<FocusSession, FocusSession, QFilterCondition> {}

extension FocusSessionQuerySortBy
    on QueryBuilder<FocusSession, FocusSession, QSortBy> {
  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByCustomName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
  sortByCustomNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
  sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
  sortByTargetDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetDurationMinutes', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
  sortByTargetDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetDurationMinutes', Sort.desc);
    });
  }
}

extension FocusSessionQuerySortThenBy
    on QueryBuilder<FocusSession, FocusSession, QSortThenBy> {
  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByCustomName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
  thenByCustomNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
  thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
  thenByTargetDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetDurationMinutes', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
  thenByTargetDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetDurationMinutes', Sort.desc);
    });
  }
}

extension FocusSessionQueryWhereDistinct
    on QueryBuilder<FocusSession, FocusSession, QDistinct> {
  QueryBuilder<FocusSession, FocusSession, QDistinct> distinctByCustomName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct> distinctByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime');
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct> distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct> distinctByMode({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct> distinctByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime');
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct>
  distinctByTargetDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetDurationMinutes');
    });
  }
}

extension FocusSessionQueryProperty
    on QueryBuilder<FocusSession, FocusSession, QQueryProperty> {
  QueryBuilder<FocusSession, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FocusSession, String?, QQueryOperations> customNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customName');
    });
  }

  QueryBuilder<FocusSession, DateTime?, QQueryOperations> endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<FocusSession, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<FocusSession, bool, QQueryOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<FocusSession, String, QQueryOperations> modeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mode');
    });
  }

  QueryBuilder<FocusSession, DateTime, QQueryOperations> startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }

  QueryBuilder<FocusSession, int, QQueryOperations>
  targetDurationMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetDurationMinutes');
    });
  }
}

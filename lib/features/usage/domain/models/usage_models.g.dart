// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usage_models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUsageSummaryCollection on Isar {
  IsarCollection<UsageSummary> get usageSummarys => this.collection();
}

const UsageSummarySchema = CollectionSchema(
  name: r'UsageSummary',
  id: -5533975665090210697,
  properties: {
    r'appSummaries': PropertySchema(
      id: 0,
      name: r'appSummaries',
      type: IsarType.objectList,

      target: r'AppUsageSummary',
    ),
    r'date': PropertySchema(id: 1, name: r'date', type: IsarType.dateTime),
    r'totalFocusTimeMs': PropertySchema(
      id: 2,
      name: r'totalFocusTimeMs',
      type: IsarType.long,
    ),
    r'totalScreenTimeMs': PropertySchema(
      id: 3,
      name: r'totalScreenTimeMs',
      type: IsarType.long,
    ),
  },

  estimateSize: _usageSummaryEstimateSize,
  serialize: _usageSummarySerialize,
  deserialize: _usageSummaryDeserialize,
  deserializeProp: _usageSummaryDeserializeProp,
  idName: r'id',
  indexes: {
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {r'AppUsageSummary': AppUsageSummarySchema},

  getId: _usageSummaryGetId,
  getLinks: _usageSummaryGetLinks,
  attach: _usageSummaryAttach,
  version: '3.3.2',
);

int _usageSummaryEstimateSize(
  UsageSummary object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.appSummaries.length * 3;
  {
    final offsets = allOffsets[AppUsageSummary]!;
    for (var i = 0; i < object.appSummaries.length; i++) {
      final value = object.appSummaries[i];
      bytesCount += AppUsageSummarySchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  return bytesCount;
}

void _usageSummarySerialize(
  UsageSummary object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<AppUsageSummary>(
    offsets[0],
    allOffsets,
    AppUsageSummarySchema.serialize,
    object.appSummaries,
  );
  writer.writeDateTime(offsets[1], object.date);
  writer.writeLong(offsets[2], object.totalFocusTimeMs);
  writer.writeLong(offsets[3], object.totalScreenTimeMs);
}

UsageSummary _usageSummaryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UsageSummary();
  object.appSummaries =
      reader.readObjectList<AppUsageSummary>(
        offsets[0],
        AppUsageSummarySchema.deserialize,
        allOffsets,
        AppUsageSummary(),
      ) ??
      [];
  object.date = reader.readDateTime(offsets[1]);
  object.id = id;
  object.totalFocusTimeMs = reader.readLong(offsets[2]);
  object.totalScreenTimeMs = reader.readLong(offsets[3]);
  return object;
}

P _usageSummaryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<AppUsageSummary>(
                offset,
                AppUsageSummarySchema.deserialize,
                allOffsets,
                AppUsageSummary(),
              ) ??
              [])
          as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _usageSummaryGetId(UsageSummary object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _usageSummaryGetLinks(UsageSummary object) {
  return [];
}

void _usageSummaryAttach(
  IsarCollection<dynamic> col,
  Id id,
  UsageSummary object,
) {
  object.id = id;
}

extension UsageSummaryByIndex on IsarCollection<UsageSummary> {
  Future<UsageSummary?> getByDate(DateTime date) {
    return getByIndex(r'date', [date]);
  }

  UsageSummary? getByDateSync(DateTime date) {
    return getByIndexSync(r'date', [date]);
  }

  Future<bool> deleteByDate(DateTime date) {
    return deleteByIndex(r'date', [date]);
  }

  bool deleteByDateSync(DateTime date) {
    return deleteByIndexSync(r'date', [date]);
  }

  Future<List<UsageSummary?>> getAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndex(r'date', values);
  }

  List<UsageSummary?> getAllByDateSync(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'date', values);
  }

  Future<int> deleteAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'date', values);
  }

  int deleteAllByDateSync(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'date', values);
  }

  Future<Id> putByDate(UsageSummary object) {
    return putByIndex(r'date', object);
  }

  Id putByDateSync(UsageSummary object, {bool saveLinks = true}) {
    return putByIndexSync(r'date', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDate(List<UsageSummary> objects) {
    return putAllByIndex(r'date', objects);
  }

  List<Id> putAllByDateSync(
    List<UsageSummary> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'date', objects, saveLinks: saveLinks);
  }
}

extension UsageSummaryQueryWhereSort
    on QueryBuilder<UsageSummary, UsageSummary, QWhere> {
  QueryBuilder<UsageSummary, UsageSummary, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension UsageSummaryQueryWhere
    on QueryBuilder<UsageSummary, UsageSummary, QWhereClause> {
  QueryBuilder<UsageSummary, UsageSummary, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<UsageSummary, UsageSummary, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterWhereClause> idBetween(
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

  QueryBuilder<UsageSummary, UsageSummary, QAfterWhereClause> dateEqualTo(
    DateTime date,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'date', value: [date]),
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterWhereClause> dateNotEqualTo(
    DateTime date,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [],
                upper: [date],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [date],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [date],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [],
                upper: [date],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterWhereClause> dateGreaterThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'date',
          lower: [date],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterWhereClause> dateLessThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'date',
          lower: [],
          upper: [date],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterWhereClause> dateBetween(
    DateTime lowerDate,
    DateTime upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'date',
          lower: [lowerDate],
          includeLower: includeLower,
          upper: [upperDate],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension UsageSummaryQueryFilter
    on QueryBuilder<UsageSummary, UsageSummary, QFilterCondition> {
  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition>
  appSummariesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'appSummaries', length, true, length, true);
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition>
  appSummariesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'appSummaries', 0, true, 0, true);
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition>
  appSummariesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'appSummaries', 0, false, 999999, true);
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition>
  appSummariesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'appSummaries', 0, true, length, include);
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition>
  appSummariesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'appSummaries', length, include, 999999, true);
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition>
  appSummariesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'appSummaries',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition> dateEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'date', value: value),
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition>
  dateGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'date',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'date',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'date',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition> idBetween(
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

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition>
  totalFocusTimeMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'totalFocusTimeMs', value: value),
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition>
  totalFocusTimeMsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'totalFocusTimeMs',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition>
  totalFocusTimeMsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'totalFocusTimeMs',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition>
  totalFocusTimeMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'totalFocusTimeMs',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition>
  totalScreenTimeMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'totalScreenTimeMs', value: value),
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition>
  totalScreenTimeMsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'totalScreenTimeMs',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition>
  totalScreenTimeMsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'totalScreenTimeMs',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition>
  totalScreenTimeMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'totalScreenTimeMs',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension UsageSummaryQueryObject
    on QueryBuilder<UsageSummary, UsageSummary, QFilterCondition> {
  QueryBuilder<UsageSummary, UsageSummary, QAfterFilterCondition>
  appSummariesElement(FilterQuery<AppUsageSummary> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'appSummaries');
    });
  }
}

extension UsageSummaryQueryLinks
    on QueryBuilder<UsageSummary, UsageSummary, QFilterCondition> {}

extension UsageSummaryQuerySortBy
    on QueryBuilder<UsageSummary, UsageSummary, QSortBy> {
  QueryBuilder<UsageSummary, UsageSummary, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterSortBy>
  sortByTotalFocusTimeMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFocusTimeMs', Sort.asc);
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterSortBy>
  sortByTotalFocusTimeMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFocusTimeMs', Sort.desc);
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterSortBy>
  sortByTotalScreenTimeMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalScreenTimeMs', Sort.asc);
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterSortBy>
  sortByTotalScreenTimeMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalScreenTimeMs', Sort.desc);
    });
  }
}

extension UsageSummaryQuerySortThenBy
    on QueryBuilder<UsageSummary, UsageSummary, QSortThenBy> {
  QueryBuilder<UsageSummary, UsageSummary, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterSortBy>
  thenByTotalFocusTimeMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFocusTimeMs', Sort.asc);
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterSortBy>
  thenByTotalFocusTimeMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFocusTimeMs', Sort.desc);
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterSortBy>
  thenByTotalScreenTimeMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalScreenTimeMs', Sort.asc);
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QAfterSortBy>
  thenByTotalScreenTimeMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalScreenTimeMs', Sort.desc);
    });
  }
}

extension UsageSummaryQueryWhereDistinct
    on QueryBuilder<UsageSummary, UsageSummary, QDistinct> {
  QueryBuilder<UsageSummary, UsageSummary, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QDistinct>
  distinctByTotalFocusTimeMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalFocusTimeMs');
    });
  }

  QueryBuilder<UsageSummary, UsageSummary, QDistinct>
  distinctByTotalScreenTimeMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalScreenTimeMs');
    });
  }
}

extension UsageSummaryQueryProperty
    on QueryBuilder<UsageSummary, UsageSummary, QQueryProperty> {
  QueryBuilder<UsageSummary, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UsageSummary, List<AppUsageSummary>, QQueryOperations>
  appSummariesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appSummaries');
    });
  }

  QueryBuilder<UsageSummary, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<UsageSummary, int, QQueryOperations> totalFocusTimeMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalFocusTimeMs');
    });
  }

  QueryBuilder<UsageSummary, int, QQueryOperations>
  totalScreenTimeMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalScreenTimeMs');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const AppUsageSummarySchema = Schema(
  name: r'AppUsageSummary',
  id: 6453341165569536133,
  properties: {
    r'appName': PropertySchema(id: 0, name: r'appName', type: IsarType.string),
    r'durationMs': PropertySchema(
      id: 1,
      name: r'durationMs',
      type: IsarType.long,
    ),
    r'launchCount': PropertySchema(
      id: 2,
      name: r'launchCount',
      type: IsarType.long,
    ),
    r'packageName': PropertySchema(
      id: 3,
      name: r'packageName',
      type: IsarType.string,
    ),
  },

  estimateSize: _appUsageSummaryEstimateSize,
  serialize: _appUsageSummarySerialize,
  deserialize: _appUsageSummaryDeserialize,
  deserializeProp: _appUsageSummaryDeserializeProp,
);

int _appUsageSummaryEstimateSize(
  AppUsageSummary object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.appName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.packageName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _appUsageSummarySerialize(
  AppUsageSummary object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.appName);
  writer.writeLong(offsets[1], object.durationMs);
  writer.writeLong(offsets[2], object.launchCount);
  writer.writeString(offsets[3], object.packageName);
}

AppUsageSummary _appUsageSummaryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppUsageSummary();
  object.appName = reader.readStringOrNull(offsets[0]);
  object.durationMs = reader.readLongOrNull(offsets[1]);
  object.launchCount = reader.readLongOrNull(offsets[2]);
  object.packageName = reader.readStringOrNull(offsets[3]);
  return object;
}

P _appUsageSummaryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension AppUsageSummaryQueryFilter
    on QueryBuilder<AppUsageSummary, AppUsageSummary, QFilterCondition> {
  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  appNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'appName'),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  appNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'appName'),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  appNameEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'appName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  appNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'appName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  appNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'appName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  appNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'appName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  appNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'appName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  appNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'appName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  appNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'appName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  appNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'appName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  appNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'appName', value: ''),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  appNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'appName', value: ''),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  durationMsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'durationMs'),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  durationMsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'durationMs'),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  durationMsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'durationMs', value: value),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  durationMsGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'durationMs',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  durationMsLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'durationMs',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  durationMsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'durationMs',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  launchCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'launchCount'),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  launchCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'launchCount'),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  launchCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'launchCount', value: value),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  launchCountGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'launchCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  launchCountLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'launchCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  launchCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'launchCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  packageNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'packageName'),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  packageNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'packageName'),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  packageNameEqualTo(String? value, {bool caseSensitive = true}) {
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

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  packageNameGreaterThan(
    String? value, {
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

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  packageNameLessThan(
    String? value, {
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

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  packageNameBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
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

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  packageNameEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  packageNameContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  packageNameMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  packageNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'packageName', value: ''),
      );
    });
  }

  QueryBuilder<AppUsageSummary, AppUsageSummary, QAfterFilterCondition>
  packageNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'packageName', value: ''),
      );
    });
  }
}

extension AppUsageSummaryQueryObject
    on QueryBuilder<AppUsageSummary, AppUsageSummary, QFilterCondition> {}

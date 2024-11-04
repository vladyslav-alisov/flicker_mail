// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info_db_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppInfoEntityCollection on Isar {
  IsarCollection<AppInfoEntity> get appInfoEntitys => this.collection();
}

const AppInfoEntitySchema = CollectionSchema(
  name: r'AppInfoEntity',
  id: 1337516825938634386,
  properties: {
    r'appName': PropertySchema(
      id: 0,
      name: r'appName',
      type: IsarType.string,
    ),
    r'buildNumber': PropertySchema(
      id: 1,
      name: r'buildNumber',
      type: IsarType.string,
    ),
    r'buildSignature': PropertySchema(
      id: 2,
      name: r'buildSignature',
      type: IsarType.string,
    ),
    r'lastUpdated': PropertySchema(
      id: 3,
      name: r'lastUpdated',
      type: IsarType.dateTime,
    ),
    r'packageName': PropertySchema(
      id: 4,
      name: r'packageName',
      type: IsarType.string,
    ),
    r'version': PropertySchema(
      id: 5,
      name: r'version',
      type: IsarType.string,
    )
  },
  estimateSize: _appInfoEntityEstimateSize,
  serialize: _appInfoEntitySerialize,
  deserialize: _appInfoEntityDeserialize,
  deserializeProp: _appInfoEntityDeserializeProp,
  idName: r'localeId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _appInfoEntityGetId,
  getLinks: _appInfoEntityGetLinks,
  attach: _appInfoEntityAttach,
  version: '3.1.0+1',
);

int _appInfoEntityEstimateSize(
  AppInfoEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.appName.length * 3;
  bytesCount += 3 + object.buildNumber.length * 3;
  bytesCount += 3 + object.buildSignature.length * 3;
  bytesCount += 3 + object.packageName.length * 3;
  bytesCount += 3 + object.version.length * 3;
  return bytesCount;
}

void _appInfoEntitySerialize(
  AppInfoEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.appName);
  writer.writeString(offsets[1], object.buildNumber);
  writer.writeString(offsets[2], object.buildSignature);
  writer.writeDateTime(offsets[3], object.lastUpdated);
  writer.writeString(offsets[4], object.packageName);
  writer.writeString(offsets[5], object.version);
}

AppInfoEntity _appInfoEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppInfoEntity(
    reader.readString(offsets[0]),
    reader.readString(offsets[4]),
    reader.readString(offsets[5]),
    reader.readString(offsets[1]),
    reader.readString(offsets[2]),
    reader.readDateTime(offsets[3]),
  );
  return object;
}

P _appInfoEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _appInfoEntityGetId(AppInfoEntity object) {
  return object.localeId;
}

List<IsarLinkBase<dynamic>> _appInfoEntityGetLinks(AppInfoEntity object) {
  return [];
}

void _appInfoEntityAttach(
    IsarCollection<dynamic> col, Id id, AppInfoEntity object) {}

extension AppInfoEntityQueryWhereSort
    on QueryBuilder<AppInfoEntity, AppInfoEntity, QWhere> {
  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterWhere> anyLocaleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppInfoEntityQueryWhere
    on QueryBuilder<AppInfoEntity, AppInfoEntity, QWhereClause> {
  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterWhereClause> localeIdEqualTo(
      Id localeId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localeId,
        upper: localeId,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterWhereClause>
      localeIdNotEqualTo(Id localeId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: localeId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: localeId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: localeId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: localeId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterWhereClause>
      localeIdGreaterThan(Id localeId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localeId, includeLower: include),
      );
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterWhereClause>
      localeIdLessThan(Id localeId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localeId, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterWhereClause> localeIdBetween(
    Id lowerLocaleId,
    Id upperLocaleId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerLocaleId,
        includeLower: includeLower,
        upper: upperLocaleId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AppInfoEntityQueryFilter
    on QueryBuilder<AppInfoEntity, AppInfoEntity, QFilterCondition> {
  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      appNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      appNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'appName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      appNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'appName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      appNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'appName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      appNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'appName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      appNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'appName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      appNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'appName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      appNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'appName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      appNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appName',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      appNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'appName',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'buildNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'buildNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'buildNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'buildNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'buildNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'buildNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'buildNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'buildNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'buildNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'buildNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildSignatureEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'buildSignature',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildSignatureGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'buildSignature',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildSignatureLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'buildSignature',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildSignatureBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'buildSignature',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildSignatureStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'buildSignature',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildSignatureEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'buildSignature',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildSignatureContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'buildSignature',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildSignatureMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'buildSignature',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildSignatureIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'buildSignature',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      buildSignatureIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'buildSignature',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      lastUpdatedEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      lastUpdatedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      lastUpdatedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      lastUpdatedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      localeIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localeId',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      localeIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localeId',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      localeIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localeId',
        value: value,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      localeIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      packageNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      packageNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      packageNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      packageNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'packageName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      packageNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      packageNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      packageNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      packageNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'packageName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      packageNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'packageName',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      packageNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'packageName',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      versionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      versionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      versionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      versionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'version',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      versionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      versionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      versionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      versionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'version',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      versionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: '',
      ));
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterFilterCondition>
      versionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'version',
        value: '',
      ));
    });
  }
}

extension AppInfoEntityQueryObject
    on QueryBuilder<AppInfoEntity, AppInfoEntity, QFilterCondition> {}

extension AppInfoEntityQueryLinks
    on QueryBuilder<AppInfoEntity, AppInfoEntity, QFilterCondition> {}

extension AppInfoEntityQuerySortBy
    on QueryBuilder<AppInfoEntity, AppInfoEntity, QSortBy> {
  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy> sortByAppName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appName', Sort.asc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy> sortByAppNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appName', Sort.desc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy> sortByBuildNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buildNumber', Sort.asc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy>
      sortByBuildNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buildNumber', Sort.desc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy>
      sortByBuildSignature() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buildSignature', Sort.asc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy>
      sortByBuildSignatureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buildSignature', Sort.desc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy> sortByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy>
      sortByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy> sortByPackageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packageName', Sort.asc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy>
      sortByPackageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packageName', Sort.desc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy> sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy> sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension AppInfoEntityQuerySortThenBy
    on QueryBuilder<AppInfoEntity, AppInfoEntity, QSortThenBy> {
  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy> thenByAppName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appName', Sort.asc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy> thenByAppNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appName', Sort.desc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy> thenByBuildNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buildNumber', Sort.asc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy>
      thenByBuildNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buildNumber', Sort.desc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy>
      thenByBuildSignature() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buildSignature', Sort.asc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy>
      thenByBuildSignatureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buildSignature', Sort.desc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy> thenByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy>
      thenByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy> thenByLocaleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localeId', Sort.asc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy>
      thenByLocaleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localeId', Sort.desc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy> thenByPackageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packageName', Sort.asc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy>
      thenByPackageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packageName', Sort.desc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy> thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QAfterSortBy> thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension AppInfoEntityQueryWhereDistinct
    on QueryBuilder<AppInfoEntity, AppInfoEntity, QDistinct> {
  QueryBuilder<AppInfoEntity, AppInfoEntity, QDistinct> distinctByAppName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QDistinct> distinctByBuildNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'buildNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QDistinct>
      distinctByBuildSignature({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'buildSignature',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QDistinct>
      distinctByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdated');
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QDistinct> distinctByPackageName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'packageName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppInfoEntity, AppInfoEntity, QDistinct> distinctByVersion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version', caseSensitive: caseSensitive);
    });
  }
}

extension AppInfoEntityQueryProperty
    on QueryBuilder<AppInfoEntity, AppInfoEntity, QQueryProperty> {
  QueryBuilder<AppInfoEntity, int, QQueryOperations> localeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localeId');
    });
  }

  QueryBuilder<AppInfoEntity, String, QQueryOperations> appNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appName');
    });
  }

  QueryBuilder<AppInfoEntity, String, QQueryOperations> buildNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'buildNumber');
    });
  }

  QueryBuilder<AppInfoEntity, String, QQueryOperations>
      buildSignatureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'buildSignature');
    });
  }

  QueryBuilder<AppInfoEntity, DateTime, QQueryOperations>
      lastUpdatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdated');
    });
  }

  QueryBuilder<AppInfoEntity, String, QQueryOperations> packageNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'packageName');
    });
  }

  QueryBuilder<AppInfoEntity, String, QQueryOperations> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }
}

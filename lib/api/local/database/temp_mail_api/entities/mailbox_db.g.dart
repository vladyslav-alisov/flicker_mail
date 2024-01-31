// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox_db.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMailboxDBCollection on Isar {
  IsarCollection<MailboxDB> get mailboxDBs => this.collection();
}

const MailboxDBSchema = CollectionSchema(
  name: r'MailboxDB',
  id: 32633838476210657,
  properties: {
    r'domain': PropertySchema(
      id: 0,
      name: r'domain',
      type: IsarType.string,
    ),
    r'generatedAt': PropertySchema(
      id: 1,
      name: r'generatedAt',
      type: IsarType.dateTime,
    ),
    r'login': PropertySchema(
      id: 2,
      name: r'login',
      type: IsarType.string,
    )
  },
  estimateSize: _mailboxDBEstimateSize,
  serialize: _mailboxDBSerialize,
  deserialize: _mailboxDBDeserialize,
  deserializeProp: _mailboxDBDeserializeProp,
  idName: r'mailboxIsarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _mailboxDBGetId,
  getLinks: _mailboxDBGetLinks,
  attach: _mailboxDBAttach,
  version: '3.1.0+1',
);

int _mailboxDBEstimateSize(
  MailboxDB object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.domain.length * 3;
  bytesCount += 3 + object.login.length * 3;
  return bytesCount;
}

void _mailboxDBSerialize(
  MailboxDB object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.domain);
  writer.writeDateTime(offsets[1], object.generatedAt);
  writer.writeString(offsets[2], object.login);
}

MailboxDB _mailboxDBDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MailboxDB(
    domain: reader.readString(offsets[0]),
    generatedAt: reader.readDateTime(offsets[1]),
    login: reader.readString(offsets[2]),
  );
  return object;
}

P _mailboxDBDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _mailboxDBGetId(MailboxDB object) {
  return object.mailboxIsarId;
}

List<IsarLinkBase<dynamic>> _mailboxDBGetLinks(MailboxDB object) {
  return [];
}

void _mailboxDBAttach(IsarCollection<dynamic> col, Id id, MailboxDB object) {}

extension MailboxDBQueryWhereSort
    on QueryBuilder<MailboxDB, MailboxDB, QWhere> {
  QueryBuilder<MailboxDB, MailboxDB, QAfterWhere> anyMailboxIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MailboxDBQueryWhere
    on QueryBuilder<MailboxDB, MailboxDB, QWhereClause> {
  QueryBuilder<MailboxDB, MailboxDB, QAfterWhereClause> mailboxIsarIdEqualTo(
      Id mailboxIsarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: mailboxIsarId,
        upper: mailboxIsarId,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterWhereClause> mailboxIsarIdNotEqualTo(
      Id mailboxIsarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: mailboxIsarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: mailboxIsarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: mailboxIsarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: mailboxIsarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterWhereClause>
      mailboxIsarIdGreaterThan(Id mailboxIsarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: mailboxIsarId, includeLower: include),
      );
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterWhereClause> mailboxIsarIdLessThan(
      Id mailboxIsarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: mailboxIsarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterWhereClause> mailboxIsarIdBetween(
    Id lowerMailboxIsarId,
    Id upperMailboxIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerMailboxIsarId,
        includeLower: includeLower,
        upper: upperMailboxIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MailboxDBQueryFilter
    on QueryBuilder<MailboxDB, MailboxDB, QFilterCondition> {
  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> domainEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'domain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> domainGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'domain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> domainLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'domain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> domainBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'domain',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> domainStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'domain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> domainEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'domain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> domainContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'domain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> domainMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'domain',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> domainIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'domain',
        value: '',
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> domainIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'domain',
        value: '',
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> generatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'generatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition>
      generatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'generatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> generatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'generatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> generatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'generatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> loginEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'login',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> loginGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'login',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> loginLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'login',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> loginBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'login',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> loginStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'login',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> loginEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'login',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> loginContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'login',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> loginMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'login',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> loginIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'login',
        value: '',
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition> loginIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'login',
        value: '',
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition>
      mailboxIsarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mailboxIsarId',
        value: value,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition>
      mailboxIsarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mailboxIsarId',
        value: value,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition>
      mailboxIsarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mailboxIsarId',
        value: value,
      ));
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterFilterCondition>
      mailboxIsarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mailboxIsarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MailboxDBQueryObject
    on QueryBuilder<MailboxDB, MailboxDB, QFilterCondition> {}

extension MailboxDBQueryLinks
    on QueryBuilder<MailboxDB, MailboxDB, QFilterCondition> {}

extension MailboxDBQuerySortBy on QueryBuilder<MailboxDB, MailboxDB, QSortBy> {
  QueryBuilder<MailboxDB, MailboxDB, QAfterSortBy> sortByDomain() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domain', Sort.asc);
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterSortBy> sortByDomainDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domain', Sort.desc);
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterSortBy> sortByGeneratedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedAt', Sort.asc);
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterSortBy> sortByGeneratedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedAt', Sort.desc);
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterSortBy> sortByLogin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'login', Sort.asc);
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterSortBy> sortByLoginDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'login', Sort.desc);
    });
  }
}

extension MailboxDBQuerySortThenBy
    on QueryBuilder<MailboxDB, MailboxDB, QSortThenBy> {
  QueryBuilder<MailboxDB, MailboxDB, QAfterSortBy> thenByDomain() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domain', Sort.asc);
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterSortBy> thenByDomainDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domain', Sort.desc);
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterSortBy> thenByGeneratedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedAt', Sort.asc);
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterSortBy> thenByGeneratedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generatedAt', Sort.desc);
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterSortBy> thenByLogin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'login', Sort.asc);
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterSortBy> thenByLoginDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'login', Sort.desc);
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterSortBy> thenByMailboxIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mailboxIsarId', Sort.asc);
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QAfterSortBy> thenByMailboxIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mailboxIsarId', Sort.desc);
    });
  }
}

extension MailboxDBQueryWhereDistinct
    on QueryBuilder<MailboxDB, MailboxDB, QDistinct> {
  QueryBuilder<MailboxDB, MailboxDB, QDistinct> distinctByDomain(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'domain', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QDistinct> distinctByGeneratedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'generatedAt');
    });
  }

  QueryBuilder<MailboxDB, MailboxDB, QDistinct> distinctByLogin(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'login', caseSensitive: caseSensitive);
    });
  }
}

extension MailboxDBQueryProperty
    on QueryBuilder<MailboxDB, MailboxDB, QQueryProperty> {
  QueryBuilder<MailboxDB, int, QQueryOperations> mailboxIsarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mailboxIsarId');
    });
  }

  QueryBuilder<MailboxDB, String, QQueryOperations> domainProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'domain');
    });
  }

  QueryBuilder<MailboxDB, DateTime, QQueryOperations> generatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'generatedAt');
    });
  }

  QueryBuilder<MailboxDB, String, QQueryOperations> loginProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'login');
    });
  }
}

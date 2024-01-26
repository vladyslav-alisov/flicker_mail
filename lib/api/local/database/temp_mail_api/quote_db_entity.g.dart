// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_db_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuoteDBEntityCollection on Isar {
  IsarCollection<QuoteDBEntity> get quoteDBEntitys => this.collection();
}

const QuoteDBEntitySchema = CollectionSchema(
  name: r'QuoteDBEntity',
  id: -3401336965517695482,
  properties: {
    r'author': PropertySchema(
      id: 0,
      name: r'author',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'languageCode': PropertySchema(
      id: 2,
      name: r'languageCode',
      type: IsarType.string,
    ),
    r'quote': PropertySchema(
      id: 3,
      name: r'quote',
      type: IsarType.string,
    )
  },
  estimateSize: _quoteDBEntityEstimateSize,
  serialize: _quoteDBEntitySerialize,
  deserialize: _quoteDBEntityDeserialize,
  deserializeProp: _quoteDBEntityDeserializeProp,
  idName: r'quoteId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _quoteDBEntityGetId,
  getLinks: _quoteDBEntityGetLinks,
  attach: _quoteDBEntityAttach,
  version: '3.1.0+1',
);

int _quoteDBEntityEstimateSize(
  QuoteDBEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.author.length * 3;
  bytesCount += 3 + object.languageCode.length * 3;
  bytesCount += 3 + object.quote.length * 3;
  return bytesCount;
}

void _quoteDBEntitySerialize(
  QuoteDBEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.author);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.languageCode);
  writer.writeString(offsets[3], object.quote);
}

QuoteDBEntity _quoteDBEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuoteDBEntity(
    author: reader.readString(offsets[0]),
    createdAt: reader.readDateTime(offsets[1]),
    languageCode: reader.readString(offsets[2]),
    quote: reader.readString(offsets[3]),
  );
  return object;
}

P _quoteDBEntityDeserializeProp<P>(
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
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _quoteDBEntityGetId(QuoteDBEntity object) {
  return object.quoteId;
}

List<IsarLinkBase<dynamic>> _quoteDBEntityGetLinks(QuoteDBEntity object) {
  return [];
}

void _quoteDBEntityAttach(
    IsarCollection<dynamic> col, Id id, QuoteDBEntity object) {}

extension QuoteDBEntityQueryWhereSort
    on QueryBuilder<QuoteDBEntity, QuoteDBEntity, QWhere> {
  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterWhere> anyQuoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension QuoteDBEntityQueryWhere
    on QueryBuilder<QuoteDBEntity, QuoteDBEntity, QWhereClause> {
  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterWhereClause> quoteIdEqualTo(
      Id quoteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: quoteId,
        upper: quoteId,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterWhereClause>
      quoteIdNotEqualTo(Id quoteId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: quoteId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: quoteId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: quoteId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: quoteId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterWhereClause>
      quoteIdGreaterThan(Id quoteId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: quoteId, includeLower: include),
      );
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterWhereClause> quoteIdLessThan(
      Id quoteId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: quoteId, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterWhereClause> quoteIdBetween(
    Id lowerQuoteId,
    Id upperQuoteId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerQuoteId,
        includeLower: includeLower,
        upper: upperQuoteId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuoteDBEntityQueryFilter
    on QueryBuilder<QuoteDBEntity, QuoteDBEntity, QFilterCondition> {
  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      authorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      authorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      authorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      authorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'author',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      authorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      authorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      authorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'author',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      authorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'author',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      authorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'author',
        value: '',
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      authorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'author',
        value: '',
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      languageCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      languageCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      languageCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      languageCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'languageCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      languageCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      languageCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      languageCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      languageCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'languageCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      languageCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'languageCode',
        value: '',
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      languageCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'languageCode',
        value: '',
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      quoteEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      quoteGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      quoteLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      quoteBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quote',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      quoteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      quoteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      quoteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      quoteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quote',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      quoteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quote',
        value: '',
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      quoteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quote',
        value: '',
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      quoteIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quoteId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      quoteIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quoteId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      quoteIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quoteId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterFilterCondition>
      quoteIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quoteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuoteDBEntityQueryObject
    on QueryBuilder<QuoteDBEntity, QuoteDBEntity, QFilterCondition> {}

extension QuoteDBEntityQueryLinks
    on QueryBuilder<QuoteDBEntity, QuoteDBEntity, QFilterCondition> {}

extension QuoteDBEntityQuerySortBy
    on QueryBuilder<QuoteDBEntity, QuoteDBEntity, QSortBy> {
  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy> sortByAuthor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'author', Sort.asc);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy> sortByAuthorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'author', Sort.desc);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy>
      sortByLanguageCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'languageCode', Sort.asc);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy>
      sortByLanguageCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'languageCode', Sort.desc);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy> sortByQuote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quote', Sort.asc);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy> sortByQuoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quote', Sort.desc);
    });
  }
}

extension QuoteDBEntityQuerySortThenBy
    on QueryBuilder<QuoteDBEntity, QuoteDBEntity, QSortThenBy> {
  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy> thenByAuthor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'author', Sort.asc);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy> thenByAuthorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'author', Sort.desc);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy>
      thenByLanguageCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'languageCode', Sort.asc);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy>
      thenByLanguageCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'languageCode', Sort.desc);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy> thenByQuote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quote', Sort.asc);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy> thenByQuoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quote', Sort.desc);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy> thenByQuoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quoteId', Sort.asc);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QAfterSortBy> thenByQuoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quoteId', Sort.desc);
    });
  }
}

extension QuoteDBEntityQueryWhereDistinct
    on QueryBuilder<QuoteDBEntity, QuoteDBEntity, QDistinct> {
  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QDistinct> distinctByAuthor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'author', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QDistinct> distinctByLanguageCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'languageCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuoteDBEntity, QuoteDBEntity, QDistinct> distinctByQuote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quote', caseSensitive: caseSensitive);
    });
  }
}

extension QuoteDBEntityQueryProperty
    on QueryBuilder<QuoteDBEntity, QuoteDBEntity, QQueryProperty> {
  QueryBuilder<QuoteDBEntity, int, QQueryOperations> quoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quoteId');
    });
  }

  QueryBuilder<QuoteDBEntity, String, QQueryOperations> authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'author');
    });
  }

  QueryBuilder<QuoteDBEntity, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<QuoteDBEntity, String, QQueryOperations> languageCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'languageCode');
    });
  }

  QueryBuilder<QuoteDBEntity, String, QQueryOperations> quoteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quote');
    });
  }
}

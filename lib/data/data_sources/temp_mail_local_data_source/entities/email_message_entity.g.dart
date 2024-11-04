// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_message_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEmailMessageEntityCollection on Isar {
  IsarCollection<EmailMessageEntity> get emailMessageEntitys =>
      this.collection();
}

const EmailMessageEntitySchema = CollectionSchema(
  name: r'EmailMessageEntity',
  id: 3635494115254219919,
  properties: {
    r'attachmentList': PropertySchema(
      id: 0,
      name: r'attachmentList',
      type: IsarType.objectList,
      target: r'AttachmentEntity',
    ),
    r'body': PropertySchema(
      id: 1,
      name: r'body',
      type: IsarType.string,
    ),
    r'date': PropertySchema(
      id: 2,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'didRead': PropertySchema(
      id: 3,
      name: r'didRead',
      type: IsarType.bool,
    ),
    r'email': PropertySchema(
      id: 4,
      name: r'email',
      type: IsarType.string,
    ),
    r'from': PropertySchema(
      id: 5,
      name: r'from',
      type: IsarType.string,
    ),
    r'htmlBody': PropertySchema(
      id: 6,
      name: r'htmlBody',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 7,
      name: r'id',
      type: IsarType.long,
    ),
    r'isDeleted': PropertySchema(
      id: 8,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'subject': PropertySchema(
      id: 9,
      name: r'subject',
      type: IsarType.string,
    ),
    r'textBody': PropertySchema(
      id: 10,
      name: r'textBody',
      type: IsarType.string,
    )
  },
  estimateSize: _emailMessageEntityEstimateSize,
  serialize: _emailMessageEntitySerialize,
  deserialize: _emailMessageEntityDeserialize,
  deserializeProp: _emailMessageEntityDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {r'AttachmentEntity': AttachmentEntitySchema},
  getId: _emailMessageEntityGetId,
  getLinks: _emailMessageEntityGetLinks,
  attach: _emailMessageEntityAttach,
  version: '3.1.0+1',
);

int _emailMessageEntityEstimateSize(
  EmailMessageEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.attachmentList.length * 3;
  {
    final offsets = allOffsets[AttachmentEntity]!;
    for (var i = 0; i < object.attachmentList.length; i++) {
      final value = object.attachmentList[i];
      bytesCount +=
          AttachmentEntitySchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.body.length * 3;
  bytesCount += 3 + object.email.length * 3;
  bytesCount += 3 + object.from.length * 3;
  bytesCount += 3 + object.htmlBody.length * 3;
  bytesCount += 3 + object.subject.length * 3;
  bytesCount += 3 + object.textBody.length * 3;
  return bytesCount;
}

void _emailMessageEntitySerialize(
  EmailMessageEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<AttachmentEntity>(
    offsets[0],
    allOffsets,
    AttachmentEntitySchema.serialize,
    object.attachmentList,
  );
  writer.writeString(offsets[1], object.body);
  writer.writeDateTime(offsets[2], object.date);
  writer.writeBool(offsets[3], object.didRead);
  writer.writeString(offsets[4], object.email);
  writer.writeString(offsets[5], object.from);
  writer.writeString(offsets[6], object.htmlBody);
  writer.writeLong(offsets[7], object.id);
  writer.writeBool(offsets[8], object.isDeleted);
  writer.writeString(offsets[9], object.subject);
  writer.writeString(offsets[10], object.textBody);
}

EmailMessageEntity _emailMessageEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EmailMessageEntity(
    attachmentList: reader.readObjectList<AttachmentEntity>(
          offsets[0],
          AttachmentEntitySchema.deserialize,
          allOffsets,
          AttachmentEntity(),
        ) ??
        const [],
    body: reader.readStringOrNull(offsets[1]) ?? "",
    date: reader.readDateTime(offsets[2]),
    didRead: reader.readBoolOrNull(offsets[3]) ?? false,
    email: reader.readString(offsets[4]),
    from: reader.readStringOrNull(offsets[5]) ?? "",
    htmlBody: reader.readStringOrNull(offsets[6]) ?? "",
    id: reader.readLong(offsets[7]),
    isDeleted: reader.readBoolOrNull(offsets[8]) ?? false,
    subject: reader.readStringOrNull(offsets[9]) ?? "",
    textBody: reader.readStringOrNull(offsets[10]) ?? "",
  );
  object.isarId = id;
  return object;
}

P _emailMessageEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<AttachmentEntity>(
            offset,
            AttachmentEntitySchema.deserialize,
            allOffsets,
            AttachmentEntity(),
          ) ??
          const []) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 9:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 10:
      return (reader.readStringOrNull(offset) ?? "") as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _emailMessageEntityGetId(EmailMessageEntity object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _emailMessageEntityGetLinks(
    EmailMessageEntity object) {
  return [];
}

void _emailMessageEntityAttach(
    IsarCollection<dynamic> col, Id id, EmailMessageEntity object) {
  object.isarId = id;
}

extension EmailMessageEntityQueryWhereSort
    on QueryBuilder<EmailMessageEntity, EmailMessageEntity, QWhere> {
  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EmailMessageEntityQueryWhere
    on QueryBuilder<EmailMessageEntity, EmailMessageEntity, QWhereClause> {
  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterWhereClause>
      isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EmailMessageEntityQueryFilter
    on QueryBuilder<EmailMessageEntity, EmailMessageEntity, QFilterCondition> {
  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      attachmentListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attachmentList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      attachmentListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attachmentList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      attachmentListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attachmentList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      attachmentListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attachmentList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      attachmentListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attachmentList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      attachmentListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attachmentList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      bodyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'body',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      bodyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'body',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      bodyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'body',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      bodyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'body',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      bodyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'body',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      bodyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'body',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      bodyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'body',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      bodyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'body',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      bodyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'body',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      bodyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'body',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      didReadEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'didRead',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      emailEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      emailGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      emailLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      emailBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      emailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      emailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      fromEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      fromGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      fromLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      fromBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'from',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      fromStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      fromEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      fromContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      fromMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'from',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      fromIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'from',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      fromIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'from',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      htmlBodyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'htmlBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      htmlBodyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'htmlBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      htmlBodyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'htmlBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      htmlBodyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'htmlBody',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      htmlBodyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'htmlBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      htmlBodyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'htmlBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      htmlBodyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'htmlBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      htmlBodyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'htmlBody',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      htmlBodyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'htmlBody',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      htmlBodyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'htmlBody',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      idLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      isDeletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      subjectEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      subjectGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      subjectLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      subjectBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subject',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      subjectStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      subjectEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      subjectContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      subjectMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subject',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      subjectIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subject',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      subjectIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subject',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      textBodyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      textBodyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      textBodyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      textBodyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textBody',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      textBodyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      textBodyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      textBodyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      textBodyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textBody',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      textBodyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textBody',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      textBodyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textBody',
        value: '',
      ));
    });
  }
}

extension EmailMessageEntityQueryObject
    on QueryBuilder<EmailMessageEntity, EmailMessageEntity, QFilterCondition> {
  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterFilterCondition>
      attachmentListElement(FilterQuery<AttachmentEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'attachmentList');
    });
  }
}

extension EmailMessageEntityQueryLinks
    on QueryBuilder<EmailMessageEntity, EmailMessageEntity, QFilterCondition> {}

extension EmailMessageEntityQuerySortBy
    on QueryBuilder<EmailMessageEntity, EmailMessageEntity, QSortBy> {
  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortByBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'body', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortByBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'body', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortByDidRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'didRead', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortByDidReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'didRead', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortByFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortByFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortByHtmlBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'htmlBody', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortByHtmlBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'htmlBody', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortBySubject() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortBySubjectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortByTextBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textBody', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      sortByTextBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textBody', Sort.desc);
    });
  }
}

extension EmailMessageEntityQuerySortThenBy
    on QueryBuilder<EmailMessageEntity, EmailMessageEntity, QSortThenBy> {
  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'body', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'body', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByDidRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'didRead', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByDidReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'didRead', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByHtmlBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'htmlBody', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByHtmlBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'htmlBody', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenBySubject() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenBySubjectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.desc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByTextBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textBody', Sort.asc);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QAfterSortBy>
      thenByTextBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textBody', Sort.desc);
    });
  }
}

extension EmailMessageEntityQueryWhereDistinct
    on QueryBuilder<EmailMessageEntity, EmailMessageEntity, QDistinct> {
  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QDistinct>
      distinctByBody({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'body', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QDistinct>
      distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QDistinct>
      distinctByDidRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'didRead');
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QDistinct>
      distinctByEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QDistinct>
      distinctByFrom({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'from', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QDistinct>
      distinctByHtmlBody({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'htmlBody', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QDistinct>
      distinctById() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id');
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QDistinct>
      distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QDistinct>
      distinctBySubject({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subject', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmailMessageEntity, EmailMessageEntity, QDistinct>
      distinctByTextBody({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textBody', caseSensitive: caseSensitive);
    });
  }
}

extension EmailMessageEntityQueryProperty
    on QueryBuilder<EmailMessageEntity, EmailMessageEntity, QQueryProperty> {
  QueryBuilder<EmailMessageEntity, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<EmailMessageEntity, List<AttachmentEntity>, QQueryOperations>
      attachmentListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'attachmentList');
    });
  }

  QueryBuilder<EmailMessageEntity, String, QQueryOperations> bodyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'body');
    });
  }

  QueryBuilder<EmailMessageEntity, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<EmailMessageEntity, bool, QQueryOperations> didReadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'didRead');
    });
  }

  QueryBuilder<EmailMessageEntity, String, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<EmailMessageEntity, String, QQueryOperations> fromProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'from');
    });
  }

  QueryBuilder<EmailMessageEntity, String, QQueryOperations>
      htmlBodyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'htmlBody');
    });
  }

  QueryBuilder<EmailMessageEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EmailMessageEntity, bool, QQueryOperations> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<EmailMessageEntity, String, QQueryOperations> subjectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subject');
    });
  }

  QueryBuilder<EmailMessageEntity, String, QQueryOperations>
      textBodyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textBody');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const AttachmentEntitySchema = Schema(
  name: r'AttachmentEntity',
  id: -341653700705814053,
  properties: {
    r'contentType': PropertySchema(
      id: 0,
      name: r'contentType',
      type: IsarType.string,
    ),
    r'filename': PropertySchema(
      id: 1,
      name: r'filename',
      type: IsarType.string,
    ),
    r'savedPath': PropertySchema(
      id: 2,
      name: r'savedPath',
      type: IsarType.string,
    ),
    r'size': PropertySchema(
      id: 3,
      name: r'size',
      type: IsarType.long,
    )
  },
  estimateSize: _attachmentEntityEstimateSize,
  serialize: _attachmentEntitySerialize,
  deserialize: _attachmentEntityDeserialize,
  deserializeProp: _attachmentEntityDeserializeProp,
);

int _attachmentEntityEstimateSize(
  AttachmentEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.contentType.length * 3;
  bytesCount += 3 + object.filename.length * 3;
  bytesCount += 3 + object.savedPath.length * 3;
  return bytesCount;
}

void _attachmentEntitySerialize(
  AttachmentEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.contentType);
  writer.writeString(offsets[1], object.filename);
  writer.writeString(offsets[2], object.savedPath);
  writer.writeLong(offsets[3], object.size);
}

AttachmentEntity _attachmentEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AttachmentEntity(
    contentType: reader.readStringOrNull(offsets[0]) ?? "",
    filename: reader.readStringOrNull(offsets[1]) ?? "",
    savedPath: reader.readStringOrNull(offsets[2]) ?? "",
    size: reader.readLongOrNull(offsets[3]) ?? 0,
  );
  return object;
}

P _attachmentEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension AttachmentEntityQueryFilter
    on QueryBuilder<AttachmentEntity, AttachmentEntity, QFilterCondition> {
  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      contentTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      contentTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      contentTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      contentTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      contentTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      contentTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      contentTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      contentTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      contentTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentType',
        value: '',
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      contentTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentType',
        value: '',
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      filenameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'filename',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      filenameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'filename',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      filenameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'filename',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      filenameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'filename',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      filenameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'filename',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      filenameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'filename',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      filenameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'filename',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      filenameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'filename',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      filenameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'filename',
        value: '',
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      filenameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'filename',
        value: '',
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      savedPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'savedPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      savedPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'savedPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      savedPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'savedPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      savedPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'savedPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      savedPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'savedPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      savedPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'savedPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      savedPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'savedPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      savedPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'savedPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      savedPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'savedPath',
        value: '',
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      savedPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'savedPath',
        value: '',
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      sizeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      sizeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      sizeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<AttachmentEntity, AttachmentEntity, QAfterFilterCondition>
      sizeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'size',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AttachmentEntityQueryObject
    on QueryBuilder<AttachmentEntity, AttachmentEntity, QFilterCondition> {}

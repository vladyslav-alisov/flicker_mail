// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_details_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMessageDetailsEntityCollection on Isar {
  IsarCollection<MessageDetailsEntity> get messageDetailsEntitys =>
      this.collection();
}

const MessageDetailsEntitySchema = CollectionSchema(
  name: r'MessageDetailsEntity',
  id: -8182113994563722579,
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
    r'email': PropertySchema(
      id: 3,
      name: r'email',
      type: IsarType.string,
    ),
    r'from': PropertySchema(
      id: 4,
      name: r'from',
      type: IsarType.string,
    ),
    r'htmlBody': PropertySchema(
      id: 5,
      name: r'htmlBody',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 6,
      name: r'id',
      type: IsarType.long,
    ),
    r'messageDbId': PropertySchema(
      id: 7,
      name: r'messageDbId',
      type: IsarType.long,
    ),
    r'messageId': PropertySchema(
      id: 8,
      name: r'messageId',
      type: IsarType.long,
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
  estimateSize: _messageDetailsEntityEstimateSize,
  serialize: _messageDetailsEntitySerialize,
  deserialize: _messageDetailsEntityDeserialize,
  deserializeProp: _messageDetailsEntityDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {r'AttachmentEntity': AttachmentEntitySchema},
  getId: _messageDetailsEntityGetId,
  getLinks: _messageDetailsEntityGetLinks,
  attach: _messageDetailsEntityAttach,
  version: '3.1.0+1',
);

int _messageDetailsEntityEstimateSize(
  MessageDetailsEntity object,
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

void _messageDetailsEntitySerialize(
  MessageDetailsEntity object,
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
  writer.writeString(offsets[3], object.email);
  writer.writeString(offsets[4], object.from);
  writer.writeString(offsets[5], object.htmlBody);
  writer.writeLong(offsets[6], object.id);
  writer.writeLong(offsets[7], object.messageDbId);
  writer.writeLong(offsets[8], object.messageId);
  writer.writeString(offsets[9], object.subject);
  writer.writeString(offsets[10], object.textBody);
}

MessageDetailsEntity _messageDetailsEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MessageDetailsEntity(
    attachmentList: reader.readObjectList<AttachmentEntity>(
          offsets[0],
          AttachmentEntitySchema.deserialize,
          allOffsets,
          AttachmentEntity(),
        ) ??
        [],
    body: reader.readStringOrNull(offsets[1]) ?? "",
    date: reader.readDateTime(offsets[2]),
    email: reader.readString(offsets[3]),
    from: reader.readStringOrNull(offsets[4]) ?? "",
    htmlBody: reader.readStringOrNull(offsets[5]) ?? "",
    id: reader.readLong(offsets[6]),
    messageDbId: reader.readLong(offsets[7]),
    messageId: reader.readLong(offsets[8]),
    subject: reader.readStringOrNull(offsets[9]) ?? "",
    textBody: reader.readStringOrNull(offsets[10]) ?? "",
  );
  object.isarId = id;
  return object;
}

P _messageDetailsEntityDeserializeProp<P>(
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
          []) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 10:
      return (reader.readStringOrNull(offset) ?? "") as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _messageDetailsEntityGetId(MessageDetailsEntity object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _messageDetailsEntityGetLinks(
    MessageDetailsEntity object) {
  return [];
}

void _messageDetailsEntityAttach(
    IsarCollection<dynamic> col, Id id, MessageDetailsEntity object) {
  object.isarId = id;
}

extension MessageDetailsEntityQueryWhereSort
    on QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QWhere> {
  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MessageDetailsEntityQueryWhere
    on QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QWhereClause> {
  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterWhereClause>
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterWhereClause>
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

extension MessageDetailsEntityQueryFilter on QueryBuilder<MessageDetailsEntity,
    MessageDetailsEntity, QFilterCondition> {
  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> attachmentListLengthEqualTo(int length) {
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> attachmentListIsEmpty() {
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> attachmentListIsNotEmpty() {
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> attachmentListLengthLessThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> attachmentListLengthGreaterThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> attachmentListLengthBetween(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> bodyEqualTo(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> bodyGreaterThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> bodyLessThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> bodyBetween(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> bodyStartsWith(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> bodyEndsWith(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
          QAfterFilterCondition>
      bodyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'body',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
          QAfterFilterCondition>
      bodyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'body',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> bodyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'body',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> bodyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'body',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> dateGreaterThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> dateLessThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> dateBetween(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> emailEqualTo(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> emailGreaterThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> emailLessThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> emailBetween(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> emailStartsWith(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> emailEndsWith(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
          QAfterFilterCondition>
      emailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
          QAfterFilterCondition>
      emailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> fromEqualTo(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> fromGreaterThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> fromLessThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> fromBetween(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> fromStartsWith(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> fromEndsWith(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
          QAfterFilterCondition>
      fromContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'from',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
          QAfterFilterCondition>
      fromMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'from',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> fromIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'from',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> fromIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'from',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> htmlBodyEqualTo(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> htmlBodyGreaterThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> htmlBodyLessThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> htmlBodyBetween(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> htmlBodyStartsWith(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> htmlBodyEndsWith(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
          QAfterFilterCondition>
      htmlBodyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'htmlBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
          QAfterFilterCondition>
      htmlBodyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'htmlBody',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> htmlBodyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'htmlBody',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> htmlBodyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'htmlBody',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> messageDbIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageDbId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> messageDbIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageDbId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> messageDbIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageDbId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> messageDbIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageDbId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> messageIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> messageIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> messageIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> messageIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> subjectEqualTo(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> subjectGreaterThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> subjectLessThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> subjectBetween(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> subjectStartsWith(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> subjectEndsWith(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
          QAfterFilterCondition>
      subjectContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
          QAfterFilterCondition>
      subjectMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subject',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> subjectIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subject',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> subjectIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subject',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> textBodyEqualTo(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> textBodyGreaterThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> textBodyLessThan(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> textBodyBetween(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> textBodyStartsWith(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> textBodyEndsWith(
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

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
          QAfterFilterCondition>
      textBodyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
          QAfterFilterCondition>
      textBodyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textBody',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> textBodyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textBody',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
      QAfterFilterCondition> textBodyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textBody',
        value: '',
      ));
    });
  }
}

extension MessageDetailsEntityQueryObject on QueryBuilder<MessageDetailsEntity,
    MessageDetailsEntity, QFilterCondition> {
  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity,
          QAfterFilterCondition>
      attachmentListElement(FilterQuery<AttachmentEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'attachmentList');
    });
  }
}

extension MessageDetailsEntityQueryLinks on QueryBuilder<MessageDetailsEntity,
    MessageDetailsEntity, QFilterCondition> {}

extension MessageDetailsEntityQuerySortBy
    on QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QSortBy> {
  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortByBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'body', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortByBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'body', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortByFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortByFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortByHtmlBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'htmlBody', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortByHtmlBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'htmlBody', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortByMessageDbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageDbId', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortByMessageDbIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageDbId', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortBySubject() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortBySubjectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortByTextBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textBody', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      sortByTextBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textBody', Sort.desc);
    });
  }
}

extension MessageDetailsEntityQuerySortThenBy
    on QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QSortThenBy> {
  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'body', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'body', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'from', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByHtmlBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'htmlBody', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByHtmlBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'htmlBody', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByMessageDbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageDbId', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByMessageDbIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageDbId', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenBySubject() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenBySubjectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.desc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByTextBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textBody', Sort.asc);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QAfterSortBy>
      thenByTextBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textBody', Sort.desc);
    });
  }
}

extension MessageDetailsEntityQueryWhereDistinct
    on QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QDistinct> {
  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QDistinct>
      distinctByBody({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'body', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QDistinct>
      distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QDistinct>
      distinctByEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QDistinct>
      distinctByFrom({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'from', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QDistinct>
      distinctByHtmlBody({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'htmlBody', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QDistinct>
      distinctById() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id');
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QDistinct>
      distinctByMessageDbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageDbId');
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QDistinct>
      distinctByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageId');
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QDistinct>
      distinctBySubject({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subject', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDetailsEntity, MessageDetailsEntity, QDistinct>
      distinctByTextBody({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textBody', caseSensitive: caseSensitive);
    });
  }
}

extension MessageDetailsEntityQueryProperty on QueryBuilder<
    MessageDetailsEntity, MessageDetailsEntity, QQueryProperty> {
  QueryBuilder<MessageDetailsEntity, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<MessageDetailsEntity, List<AttachmentEntity>, QQueryOperations>
      attachmentListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'attachmentList');
    });
  }

  QueryBuilder<MessageDetailsEntity, String, QQueryOperations> bodyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'body');
    });
  }

  QueryBuilder<MessageDetailsEntity, DateTime, QQueryOperations>
      dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<MessageDetailsEntity, String, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<MessageDetailsEntity, String, QQueryOperations> fromProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'from');
    });
  }

  QueryBuilder<MessageDetailsEntity, String, QQueryOperations>
      htmlBodyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'htmlBody');
    });
  }

  QueryBuilder<MessageDetailsEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MessageDetailsEntity, int, QQueryOperations>
      messageDbIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageDbId');
    });
  }

  QueryBuilder<MessageDetailsEntity, int, QQueryOperations>
      messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageId');
    });
  }

  QueryBuilder<MessageDetailsEntity, String, QQueryOperations>
      subjectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subject');
    });
  }

  QueryBuilder<MessageDetailsEntity, String, QQueryOperations>
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

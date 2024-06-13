import 'package:flicker_mail/api/local/database/temp_mail_api/entities/message_details_entity.dart';
import 'package:flicker_mail/api/network/sec_mail_api/dto/mail_details_dto.dart';
import 'package:flicker_mail/models/message_attachment/message_attachment_mapper.dart';
import 'package:flicker_mail/models/message_details/message_details.dart';

class MessageDetailsMapper {
  final MessageAttachmentMapper _messageAttachmentMapper = MessageAttachmentMapper();

  MessageDetails mapEntityToModel(
    MessageDetailsEntity messageDetailsEntity,
  ) {
    return MessageDetails(
      id: messageDetailsEntity.id,
      dbId: messageDetailsEntity.isarId,
      messageId: messageDetailsEntity.messageId,
      messageDbId: messageDetailsEntity.messageDbId,
      email: messageDetailsEntity.email,
      attachments: _messageAttachmentMapper.mapEntityListToModelList(messageDetailsEntity.attachmentList),
      date: messageDetailsEntity.date,
      body: messageDetailsEntity.body,
      from: messageDetailsEntity.from,
      htmlBody: messageDetailsEntity.htmlBody,
      subject: messageDetailsEntity.subject,
      textBody: messageDetailsEntity.textBody,
    );
  }

  MessageDetailsEntity mapDtoToEntity(
    int messageId,
    int messageDbId,
    String email,
    MessageDetailsDto messageDetailsDto,
    List<AttachmentEntity> attachmentEntityList,
  ) {
    return MessageDetailsEntity(
      id: messageDetailsDto.id,
      messageId: messageId,
      messageDbId: messageDbId,
      email: email,
      attachmentList: attachmentEntityList,
      date: messageDetailsDto.date,
      body: messageDetailsDto.body,
      from: messageDetailsDto.from,
      htmlBody: messageDetailsDto.htmlBody,
      subject: messageDetailsDto.subject,
      textBody: messageDetailsDto.textBody,
    );
  }
}

import 'package:flicker_mail/api/local/database/temp_mail_api/entities/email_message_entity.dart';
import 'package:flicker_mail/api/network/sec_mail_api/dto/mail_details_dto.dart';
import 'package:flicker_mail/models/email_message/email_message.dart';
import 'package:flicker_mail/models/message_attachment/message_attachment.dart';
import 'package:flicker_mail/models/message_attachment/message_attachment_mapper.dart';

class EmailMessageMapper {
  final MessageAttachmentMapper _messageAttachmentMapper = MessageAttachmentMapper();

  EmailMessageEntity mapDtoToEntity(
    MessageDetailsDto messageDetailsDto,
    List<AttachmentEntity> attachmentEntities,
    String email,
  ) {
    return EmailMessageEntity(
      subject: messageDetailsDto.subject,
      from: messageDetailsDto.from,
      email: email,
      date: messageDetailsDto.date,
      id: messageDetailsDto.id,
      body: messageDetailsDto.body,
      textBody: messageDetailsDto.textBody,
      htmlBody: messageDetailsDto.htmlBody,
      attachmentList: attachmentEntities,
    );
  }

  EmailMessage mapEntityToModel(EmailMessageEntity emailMessageEntity) {
    List<MessageAttachment> messageAttachment = _messageAttachmentMapper.mapEntityListToModelList(
      emailMessageEntity.attachmentList,
    );

    return EmailMessage(
      id: emailMessageEntity.id,
      date: emailMessageEntity.date,
      from: emailMessageEntity.from,
      subject: emailMessageEntity.subject,
      dbId: emailMessageEntity.isarId,
      didRead: emailMessageEntity.didRead,
      email: emailMessageEntity.email,
      attachments: messageAttachment,
      body: emailMessageEntity.body,
      htmlBody: emailMessageEntity.htmlBody,
      textBody: emailMessageEntity.textBody,
    );
  }

  List<EmailMessage> mapEntityToModelList(List<EmailMessageEntity> emailMessageEntityList) {
    List<EmailMessage> result = [];

    for (EmailMessageEntity emailMessageEntity in emailMessageEntityList) {
      EmailMessage emailMessage = mapEntityToModel(emailMessageEntity);
      result.add(emailMessage);
    }

    return result;
  }
}

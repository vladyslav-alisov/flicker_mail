import 'package:flicker_mail/api/local/database/temp_mail_api/entities/message_details_entity.dart';
import 'package:flicker_mail/api/network/sec_mail_api/dto/attachment_dto.dart';
import 'package:flicker_mail/api/network/sec_mail_api/dto/mail_details_dto.dart';
import 'package:flicker_mail/models/message_details/message_attachment.dart';
import 'package:flicker_mail/models/message_details/message_details.dart';

class MessageDetailsMapper {
  MessageDetails mapEntityToModel(
    MessageDetailsEntity messageDetailsEntity,
  ) {
    return MessageDetails(
      id: messageDetailsEntity.id,
      dbId: messageDetailsEntity.isarId,
      messageId: messageDetailsEntity.messageId,
      messageDbId: messageDetailsEntity.messageDbId,
      email: messageDetailsEntity.email,
      attachments: [],
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
  ) {
    return MessageDetailsEntity(
      id: messageDetailsDto.id,
      messageId: messageId,
      messageDbId: messageDbId,
      email: email,
      date: messageDetailsDto.date,
      body: messageDetailsDto.body,
      from: messageDetailsDto.from,
      htmlBody: messageDetailsDto.htmlBody,
      subject: messageDetailsDto.subject,
      textBody: messageDetailsDto.textBody,
    );
  }

  MessageAttachment mapAttachmentNTWToMailAttachment(
    AttachmentDto attachmentNTW,
  ) {
    return MessageAttachment(
      filename: attachmentNTW.filename,
      contentType: attachmentNTW.contentType,
      size: attachmentNTW.size,
    );
  }

  List<MessageAttachment> mapAttachmentNTWToMailAttachmentList(
    List<AttachmentDto> attachmentNTWList,
  ) {
    List<MessageAttachment> result = [];

    for (AttachmentDto attachmentNTW in attachmentNTWList) {
      MessageAttachment mailAttachment = mapAttachmentNTWToMailAttachment(attachmentNTW);
      result.add(mailAttachment);
    }

    return result;
  }
}

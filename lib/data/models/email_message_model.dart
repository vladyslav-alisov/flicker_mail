import 'package:flicker_mail/data/data_sources/temp_mail_local_data_source/entities/email_message_entity.dart';
import 'package:flicker_mail/domain/models/email_message.dart';
import 'package:flicker_mail/domain/models/message_attachment.dart';

class EmailMessageModel extends EmailMessage {
  EmailMessageModel({
    required super.id,
    required super.dbId,
    required super.email,
    required super.date,
    super.attachments,
    super.body,
    super.didRead,
    super.from,
    super.htmlBody,
    super.subject,
    super.textBody,
  });

  factory EmailMessageModel.fromEntity(EmailMessageEntity emailMessageEntity) {
    List<MessageAttachment> messageAttachment =
        emailMessageEntity.attachmentList.map((e) => MessageAttachmentModel.fromEntity(e)).toList();

    return EmailMessageModel(
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
}

class MessageAttachmentModel extends MessageAttachment {
  MessageAttachmentModel({
    required super.filename,
    required super.contentType,
    required super.size,
    required super.filePath,
  });

  factory MessageAttachmentModel.fromEntity(AttachmentEntity entity) {
    return MessageAttachmentModel(
      filename: entity.filename,
      contentType: entity.contentType,
      size: entity.size,
      filePath: entity.savedPath,
    );
  }
}

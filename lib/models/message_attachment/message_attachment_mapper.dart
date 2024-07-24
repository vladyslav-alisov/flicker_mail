import 'package:flicker_mail/api/local/database/temp_mail_api/entities/email_message_entity.dart';
import 'package:flicker_mail/api/network/sec_mail_api/dto/attachment_dto.dart';
import 'package:flicker_mail/models/message_attachment/message_attachment.dart';

class MessageAttachmentMapper {
  AttachmentEntity mapDtoToEntity(AttachmentDto attachmentDto, String path) {
    return AttachmentEntity(
      filename: attachmentDto.filename,
      contentType: attachmentDto.contentType,
      size: attachmentDto.size,
      savedPath: path,
    );
  }

  MessageAttachment mapEntityToModel(AttachmentEntity entity) {
    return MessageAttachment(
      filename: entity.filename,
      contentType: entity.contentType,
      size: entity.size,
      filePath: entity.savedPath,
    );
  }

  List<MessageAttachment> mapEntityListToModelList(List<AttachmentEntity> entityList) {
    List<MessageAttachment> modelList = [];

    for (AttachmentEntity entity in entityList) {
      MessageAttachment messageAttachment = mapEntityToModel(entity);
      modelList.add(messageAttachment);
    }
    return modelList;
  }
}

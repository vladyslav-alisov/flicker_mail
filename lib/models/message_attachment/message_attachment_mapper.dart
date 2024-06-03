import 'package:flicker_mail/api/local/database/temp_mail_api/entities/message_details_entity.dart';
import 'package:flicker_mail/api/network/sec_mail_api/dto/attachment_dto.dart';
import 'package:flicker_mail/models/message_attachment/message_attachment.dart';

class MessageAttachmentMapper {
  AttachmentEntity mapDtoToEntity(AttachmentDto attachmentDto) {
    return AttachmentEntity(
      filename: attachmentDto.filename,
      contentType: attachmentDto.contentType,
      size: attachmentDto.size,
    );
  }

  List<AttachmentEntity> mapDtoListToEntityList(List<AttachmentDto> attachmentDtoList) {
    List<AttachmentEntity> attachmentEntityList = [];

    for (AttachmentDto attachmentDto in attachmentDtoList) {
      AttachmentEntity attachmentEntity = mapDtoToEntity(attachmentDto);
      attachmentEntityList.add(attachmentEntity);
    }
    return attachmentEntityList;
  }

  MessageAttachment mapEntityToModel(AttachmentEntity attachmentEntity) {
    return MessageAttachment(
      filename: attachmentEntity.filename,
      contentType: attachmentEntity.contentType,
      size: attachmentEntity.size,
    );
  }

  List<MessageAttachment> mapEntityListToModelList(List<AttachmentEntity> attachmentEntityList) {
    List<MessageAttachment> attachmentModelList = [];

    for (AttachmentEntity attachmentEntity in attachmentEntityList) {
      MessageAttachment messageAttachment = mapEntityToModel(attachmentEntity);
      attachmentModelList.add(messageAttachment);
    }
    return attachmentModelList;
  }
}

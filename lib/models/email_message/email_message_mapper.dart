import 'package:flicker_mail/api/local/database/temp_mail_api/entities/email_message_entity.dart';
import 'package:flicker_mail/api/network/sec_mail_api/dto/email_message_dto.dart';
import 'package:flicker_mail/models/email_message/email_message.dart';

class EmailMessageMapper {
  EmailMessageEntity mapDtoToEntity(EmailMessageDto emailMessageDto, String email) {
    return EmailMessageEntity(
      subject: emailMessageDto.subject,
      from: emailMessageDto.from,
      email: email,
      date: emailMessageDto.date,
      id: emailMessageDto.id,
    );
  }

  EmailMessage mapEntityToModel(EmailMessageEntity emailMessageEntity) {
    return EmailMessage(
      id: emailMessageEntity.id,
      date: emailMessageEntity.date,
      from: emailMessageEntity.from,
      subject: emailMessageEntity.subject,
      dbId: emailMessageEntity.isarId,
      didRead: emailMessageEntity.didRead,
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

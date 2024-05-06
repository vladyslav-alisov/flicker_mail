import 'package:flicker_mail/api/local/database/temp_mail_api/entities/email_message_db.dart';
import 'package:flicker_mail/api/network/sec_mail_api/entities/email_message_dto.dart';
import 'package:flicker_mail/models/email_message/email_message.dart';

class EmailMessageMapper {
  EmailMessageDB mapDtoToEntity(EmailMessageDto emailMessageDto, String email, [bool didRead = false]) {
    return EmailMessageDB(
      subject: emailMessageDto.subject,
      from: emailMessageDto.from,
      email: email,
      date: emailMessageDto.date,
      didRead: didRead,
      id: emailMessageDto.id,
    );
  }

  EmailMessage mapEntityToModel(EmailMessageDB emailMessageEntity) {
    return EmailMessage(
      id: emailMessageEntity.id,
      date: emailMessageEntity.date,
      from: emailMessageEntity.from,
      subject: emailMessageEntity.subject,
      isarId: emailMessageEntity.isarId,
    );
  }

  List<EmailMessage> mapEntityToModelList(List<EmailMessageDB> emailMessageEntityList) {
    List<EmailMessage> result = [];

    for (EmailMessageDB emailMessageEntity in emailMessageEntityList) {
      EmailMessage emailMessage = mapEntityToModel(emailMessageEntity);
      result.add(emailMessage);
    }

    return result;
  }
}

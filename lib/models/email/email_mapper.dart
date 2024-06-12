import 'package:flicker_mail/api/local/database/temp_mail_api/entities/email_entity.dart';
import 'package:flicker_mail/api/network/sec_mail_api/dto/email_dto.dart';
import 'package:flicker_mail/models/email/email.dart';

class EmailMapper {
  EmailEntity mapModelToEntity(Email email) {
    return EmailEntity(
      login: email.login,
      domain: email.domain,
      generatedAt: email.generatedAt,
      isActive: email.isActive,
      label: email.label,
    );
  }

  Email mapEntityToModel(EmailEntity entity) {
    return Email(
      login: entity.login,
      domain: entity.domain,
      isarId: entity.isarId,
      generatedAt: entity.generatedAt,
      isActive: entity.isActive,
      label: entity.label,
    );
  }

  List<Email> mapEntityToModelList(List<EmailEntity> emailsDB) {
    List<Email> result = [];

    for (EmailEntity emailDB in emailsDB) {
      Email email = mapEntityToModel(emailDB);
      result.add(email);
    }

    return result;
  }

  EmailEntity mapDtoToEntity(EmailDto emailNTW, {bool? isActive}) {
    return EmailEntity(
      login: emailNTW.login,
      domain: emailNTW.domain,
      generatedAt: emailNTW.generatedAt,
      isActive: isActive ?? true,
    );
  }
}

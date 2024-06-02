import 'package:flicker_mail/api/local/database/temp_mail_api/entities/email_entity.dart';
import 'package:flicker_mail/api/network/sec_mail_api/dto/email_dto.dart';
import 'package:flicker_mail/models/email/email.dart';

class EmailMapper {
  EmailEntity mapEmailToDBEntity(Email email) {
    return EmailEntity(
      login: email.login,
      domain: email.domain,
      generatedAt: email.generatedAt,
      isActive: email.isActive,
      label: email.label,
    );
  }

  Email mapDBEntityToEmail(EmailEntity emailDB) {
    return Email(
      login: emailDB.login,
      domain: emailDB.domain,
      isarId: emailDB.isarId,
      generatedAt: emailDB.generatedAt,
      isActive: emailDB.isActive,
      label: emailDB.label,
    );
  }

  List<Email> mapDBEntityToEmailList(List<EmailEntity> emailsDB) {
    List<Email> result = [];

    for (EmailEntity emailDB in emailsDB) {
      Email email = mapDBEntityToEmail(emailDB);
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

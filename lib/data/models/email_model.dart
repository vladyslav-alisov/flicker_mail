import 'package:flicker_mail/data/data_sources/temp_mail_local_data_source/entities/email_entity.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_remote_data_source/dto/email_dto.dart';
import 'package:flicker_mail/domain/models/email.dart';

class EmailModel extends Email {
  EmailModel({
    required super.login,
    required super.domain,
    required super.isarId,
    required super.generatedAt,
    required super.isActive,
    super.label,
  });

  EmailEntity toEntity(EmailModel email) {
    return EmailEntity(
      login: email.login,
      domain: email.domain,
      generatedAt: email.generatedAt,
      isActive: email.isActive,
      label: email.label,
    );
  }

  factory EmailModel.fromEntity(EmailEntity entity) {
    return EmailModel(
      login: entity.login,
      domain: entity.domain,
      isarId: entity.isarId,
      generatedAt: entity.generatedAt,
      isActive: entity.isActive,
      label: entity.label,
    );
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

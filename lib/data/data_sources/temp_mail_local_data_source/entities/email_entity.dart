import 'package:flicker_mail/data/data_sources/temp_mail_remote_data_source/dto/email_dto.dart';
import 'package:isar/isar.dart';

part 'email_entity.g.dart';

@collection
class EmailEntity {
  Id isarId = Isar.autoIncrement;
  final String domain;
  final String login;
  final DateTime generatedAt;
  bool isActive;
  String label;

  EmailEntity({
    required this.domain,
    required this.login,
    required this.generatedAt,
    required this.isActive,
    this.label = "",
  });

  factory EmailEntity.fromDto(EmailDto emailDto) {
    return EmailEntity(
      login: emailDto.login,
      domain: emailDto.domain,
      generatedAt: emailDto.generatedAt,
      isActive: true,
    );
  }

  @override
  String toString() {
    return 'MailboxDB{mailboxIsarId: $isarId, domain: $domain, login: $login, label:$label, generatedAt: $generatedAt}';
  }
}

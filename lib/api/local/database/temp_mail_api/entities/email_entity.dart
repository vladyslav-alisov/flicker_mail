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

  @override
  String toString() {
    return 'MailboxDB{mailboxIsarId: $isarId, domain: $domain, login: $login, label:$label, generatedAt: $generatedAt}';
  }
}

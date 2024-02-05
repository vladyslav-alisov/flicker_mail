import 'package:isar/isar.dart';
part 'mailbox_db.g.dart';

@collection
class MailboxDB {
  Id isarId = Isar.autoIncrement;
  final String domain;
  final String login;
  final DateTime generatedAt;
  bool isActive;

  MailboxDB({
    required this.domain,
    required this.login,
    required this.generatedAt,
    required this.isActive,
  });

  @override
  String toString() {
    return 'MailboxDB{mailboxIsarId: $isarId, domain: $domain, login: $login, generatedAt: $generatedAt}';
  }
}

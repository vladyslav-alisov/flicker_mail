import 'package:isar/isar.dart';
part 'mailbox_db.g.dart';

@collection
class MailboxDB {
  final Id mailboxIsarId = Isar.autoIncrement;
  final String domain;
  final String login;
  final DateTime generatedAt;

  MailboxDB({
    required this.domain,
    required this.login,
    required this.generatedAt,
  });

  @override
  String toString() {
    return 'MailboxDB{mailboxIsarId: $mailboxIsarId, domain: $domain, login: $login, generatedAt: $generatedAt}';
  }
}

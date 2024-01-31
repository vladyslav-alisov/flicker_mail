class Email {
  final int isarId;
  final String login;
  final String domain;
  final DateTime generatedAt;

  Email({
    required this.login,
    required this.domain,
    required this.isarId,
    required this.generatedAt,
  });

  String get email => "$login@$domain";
  String get domainWithAt => "@$domain";

  @override
  String toString() {
    return 'Mailbox{isarId: $isarId, login: $login, domain: $domain, generatedAt: $generatedAt}';
  }
}

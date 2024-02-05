class Email {
  final int isarId;
  final String login;
  final String domain;
  final DateTime generatedAt;
  final bool isActive;

  Email({
    required this.login,
    required this.domain,
    required this.isarId,
    required this.generatedAt,
    required this.isActive,
  });

  String get email => "$login@$domain";
  String get domainWithAt => "@$domain";

  @override
  String toString() {
    return 'Mailbox{isarId: $isarId, login: $login, domain: $domain, generatedAt: $generatedAt}';
  }
}

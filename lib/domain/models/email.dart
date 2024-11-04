class Email {
  final int isarId;
  final String login;
  final String domain;
  final DateTime generatedAt;
  final bool isActive;
  final String label;

  Email({
    required this.login,
    required this.domain,
    required this.isarId,
    required this.generatedAt,
    required this.isActive,
    this.label = "",
  });

  String get email => "$login@$domain";

  /// Generates ID from [generatedAt] and [isarId]
  /// Used in building list widgets
  String get generateID => generatedAt.toString() + isarId.toString();

  @override
  String toString() {
    return 'Mailbox{isarId: $isarId, login: $login, domain: $domain, generatedAt: $generatedAt}';
  }
}

class MailboxNTW {
  final String domain;
  final String login;
  final DateTime generatedAt;

  MailboxNTW({
    required this.domain,
    required this.login,
    required this.generatedAt,
  });

  factory MailboxNTW.fromString(String email) {
    List<String> elements = email.split("@");
    String login = elements.firstOrNull ?? "";
    String domain = elements.lastOrNull ?? "";
    DateTime now = DateTime.now();
    return MailboxNTW(login: login, domain: domain, generatedAt: now);
  }
}

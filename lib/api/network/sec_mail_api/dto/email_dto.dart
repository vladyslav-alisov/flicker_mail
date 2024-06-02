class EmailDto {
  final String domain;
  final String login;
  final DateTime generatedAt;

  EmailDto({
    required this.domain,
    required this.login,
    required this.generatedAt,
  });

  factory EmailDto.fromString(String email) {
    List<String> elements = email.split("@");
    String login = elements.firstOrNull ?? "";
    String domain = elements.lastOrNull ?? "";
    DateTime now = DateTime.now();
    return EmailDto(login: login, domain: domain, generatedAt: now);
  }
}

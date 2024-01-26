class Mailbox {
  late String login;
  late String domain;

  Mailbox(this.login, this.domain);

  String get email => "$login@$domain";

  Mailbox.fromString(String email) {
    List<String> elements = email.split("@");
    login = elements.firstOrNull ?? "";
    domain = elements.lastOrNull ?? "";
  }
}

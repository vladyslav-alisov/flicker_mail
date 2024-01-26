enum Routes {
  mailScreen("mail", "/mailbox/mail"),
  mailboxScreen("/mailbox", "/mailbox");

  const Routes(this.name, this.path);

  final String name;
  final String path;
}

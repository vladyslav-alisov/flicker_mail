class EmailMessage {
  final int id;
  final int dbId;
  final String from;
  final String subject;
  final DateTime date;
  bool didRead;

  EmailMessage({
    required this.id,
    required this.dbId,
    required this.from,
    required this.subject,
    required this.date,
    this.didRead = false,
  });
}

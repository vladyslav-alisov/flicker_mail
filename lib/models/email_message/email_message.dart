class EmailMessage {
  final int id;
  final int isarId;
  final String from;
  final String subject;
  final DateTime date;

  EmailMessage({
    required this.id,
    required this.isarId,
    required this.from,
    required this.subject,
    required this.date,
  });
}

import 'package:flicker_mail/models/message_attachment/message_attachment.dart';

class EmailMessage {
  final int id;
  final int dbId;
  final String from;
  final String subject;
  final DateTime date;
  String email;
  bool didRead;
  List<MessageAttachment> attachments;
  String body;
  String textBody;
  String htmlBody;

  EmailMessage({
    required this.id,
    required this.dbId,
    required this.email,
    this.from = "",
    this.subject = "",
    required this.date,
    this.didRead = false,
    this.attachments = const [],
    this.body = "",
    this.textBody = "",
    this.htmlBody = "",
  });

  @override
  String toString() {
    return 'EmailMessage{id: $id, dbId: $dbId, from: $from, subject: $subject, date: $date, email: $email, didRead: $didRead, attachments: $attachments}';
  }
}

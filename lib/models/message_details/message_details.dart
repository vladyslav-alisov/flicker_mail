import '../message_attachment/message_attachment.dart';

class MessageDetails {
  int id;
  int dbId;
  int messageId;
  int messageDbId;
  String from;
  String subject;
  DateTime date;
  String email;
  List<MessageAttachment> attachments;
  String body;
  String textBody;
  String htmlBody;

  MessageDetails({
    required this.id,
    required this.dbId,
    required this.messageId,
    required this.messageDbId,
    required this.email,
    this.from = "",
    this.subject = "",
    required this.date,
    this.attachments = const [],
    this.body = "",
    this.textBody = "",
    this.htmlBody = "",
  });

  @override
  String toString() {
    return 'MessageDetails{id: $id, dbId: $dbId, messageId: $messageId, messageDbId: $messageDbId, from: $from, subject: $subject, date: $date, email: $email, attachments: $attachments, body: $body, textBody: $textBody, htmlBody: $htmlBody}';
  }
}

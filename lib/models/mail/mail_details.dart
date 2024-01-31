import 'mail_attachment.dart';

class MailDetails {
  int id;
  String from;
  String subject;
  DateTime date;
  List<MailAttachment> attachments;
  String body;
  String textBody;
  String htmlBody;

  MailDetails({
    required this.id,
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
    return 'MailDetails{id: $id, from: $from, subject: $subject, date: $date, attachments: $attachments, body: $body, textBody: $textBody, htmlBody: $htmlBody}';
  }
}

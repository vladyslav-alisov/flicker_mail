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
}

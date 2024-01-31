import 'package:flicker_mail/api/network/temp_email_api/entities/attachment_ntw.dart';

class MailDetailsNTW {
  int id;
  String from;
  String subject;
  DateTime date;
  List<AttachmentNTW> attachments;
  String body;
  String textBody;
  String htmlBody;

  MailDetailsNTW({
    required this.id,
    this.from = "",
    this.subject = "",
    required this.date,
    this.attachments = const [],
    this.body = "",
    this.textBody = "",
    this.htmlBody = "",
  });

  factory MailDetailsNTW.fromJson(Map<String, dynamic> json) => MailDetailsNTW(
        id: json["id"],
        from: json["from"],
        subject: json["subject"],
        date: DateTime.parse(json["date"]),
        attachments: List<AttachmentNTW>.from(json["attachments"].map((x) => AttachmentNTW.fromJson(x))),
        body: json["body"],
        textBody: json["textBody"],
        htmlBody: json["htmlBody"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "subject": subject,
        "date": date.toIso8601String(),
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "body": body,
        "textBody": textBody,
        "htmlBody": htmlBody,
      };
}

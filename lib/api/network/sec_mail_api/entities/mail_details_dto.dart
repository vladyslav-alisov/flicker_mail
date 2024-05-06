import 'package:flicker_mail/api/network/sec_mail_api/entities/attachment_dto.dart';

class MailDetailsDto {
  int id;
  String from;
  String subject;
  DateTime date;
  List<AttachmentDto> attachments;
  String body;
  String textBody;
  String htmlBody;

  MailDetailsDto({
    required this.id,
    this.from = "",
    this.subject = "",
    required this.date,
    this.attachments = const [],
    this.body = "",
    this.textBody = "",
    this.htmlBody = "",
  });

  factory MailDetailsDto.fromJson(Map<String, dynamic> json) => MailDetailsDto(
        id: json["id"],
        from: json["from"],
        subject: json["subject"],
        date: DateTime.parse(json["date"]),
        attachments: List<AttachmentDto>.from(json["attachments"].map((x) => AttachmentDto.fromJson(x))),
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

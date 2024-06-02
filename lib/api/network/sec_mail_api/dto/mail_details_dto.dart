import 'package:flicker_mail/api/network/sec_mail_api/dto/attachment_dto.dart';

class MessageDetailsDto {
  int id;
  String from;
  String subject;
  DateTime date;
  List<AttachmentDto> attachments;
  String body;
  String textBody;
  String htmlBody;

  MessageDetailsDto({
    required this.id,
    this.from = "",
    this.subject = "",
    required this.date,
    this.attachments = const [],
    this.body = "",
    this.textBody = "",
    this.htmlBody = "",
  });

  factory MessageDetailsDto.fromJson(Map<String, dynamic> json) => MessageDetailsDto(
        id: json["id"],
        from: json["from"],
        subject: json["subject"],
        date: DateTime.parse(json["date"] + "Z"),
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

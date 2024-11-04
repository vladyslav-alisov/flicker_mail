class EmailMessageDto {
  int id;
  String from;
  String subject;
  DateTime date;

  EmailMessageDto({
    required this.id,
    this.from = "",
    this.subject = "",
    required this.date,
  });

  factory EmailMessageDto.fromJson(Map<String, dynamic> json) {
    var emailDto = EmailMessageDto(
      id: json["id"],
      from: json["from"],
      subject: json["subject"],
      date: DateTime.parse(json["date"] + "Z" ?? DateTime.now()),
    );
    return emailDto;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "subject": subject,
        "date": date.toIso8601String(),
      };
}

class MailNetworkEntity {
  int id;
  String from;
  String subject;
  DateTime date;

  MailNetworkEntity({
    required this.id,
    this.from = "",
    this.subject = "",
    required this.date,
  });

  factory MailNetworkEntity.fromJson(Map<String, dynamic> json) => MailNetworkEntity(
        id: json["id"],
        from: json["from"],
        subject: json["subject"],
        date: DateTime.parse(json["date"] ?? DateTime.now()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "subject": subject,
        "date": date.toIso8601String(),
      };
}

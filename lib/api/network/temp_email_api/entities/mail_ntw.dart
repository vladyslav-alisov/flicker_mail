class MailNTW {
  int id;
  String from;
  String subject;
  DateTime date;

  MailNTW({
    required this.id,
    this.from = "",
    this.subject = "",
    required this.date,
  });

  factory MailNTW.fromJson(Map<String, dynamic> json) => MailNTW(
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

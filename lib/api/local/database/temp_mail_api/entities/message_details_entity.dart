import 'package:isar/isar.dart';
part 'message_details_entity.g.dart';

@collection
class MessageDetailsEntity {
  Id isarId = Isar.autoIncrement;
  final int id;
  final int messageId;
  final int messageDbId;
  final String from;
  final String subject;
  final DateTime date;
  final String email;
  final String body;
  final String textBody;
  final String htmlBody;

  MessageDetailsEntity({
    required this.id,
    required this.messageId,
    required this.messageDbId,
    required this.email,
    required this.date,
    this.subject = "",
    this.from = "",
    this.body = "",
    this.textBody = "",
    this.htmlBody = "",
  });

  @override
  String toString() {
    return 'EmailMessageDetailsEntity{isarId: $isarId, id: $id, from: $from, subject: $subject, date: $date, email: $email, body: $body, textBody: $textBody, htmlBody: $htmlBody}';
  }
}

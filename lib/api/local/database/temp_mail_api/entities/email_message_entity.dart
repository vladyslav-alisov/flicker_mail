import 'package:isar/isar.dart';
part 'email_message_entity.g.dart';

@collection
class EmailMessageEntity {
  Id isarId = Isar.autoIncrement;
  final int id;
  final String from;
  final String subject;
  final DateTime date;
  final String email;
  bool didRead;
  bool isDeleted;

  EmailMessageEntity({
    required this.id,
    required this.from,
    required this.subject,
    required this.date,
    required this.email,
    this.didRead = false,
    this.isDeleted = false,
  });

  @override
  String toString() {
    return 'EmailMessageEntity{isarId: $isarId, id: $id, from: $from, subject: $subject, date: $date, email: $email, didRead: $didRead, isDeleted: $isDeleted}';
  }
}

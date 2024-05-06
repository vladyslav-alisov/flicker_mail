import 'package:isar/isar.dart';
part 'email_message_db.g.dart';

@collection
class EmailMessageDB {
  Id isarId = Isar.autoIncrement;
  final int id;
  final String from;
  final String subject;
  final DateTime date;
  final String email;
  bool didRead;

  EmailMessageDB({
    required this.id,
    required this.from,
    required this.subject,
    required this.date,
    required this.didRead,
    required this.email,
  });

  @override
  String toString() {
    return 'EmailMessageDB{isarId: $isarId, id:$id, from: $from, subject: $subject, date: $date, email: $email, didRead: $didRead}';
  }
}

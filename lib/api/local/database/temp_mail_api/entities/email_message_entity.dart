import 'package:isar/isar.dart';

part 'email_message_entity.g.dart';

@collection
class EmailMessageEntity {
  Id isarId = Isar.autoIncrement;
  final int id;
  final DateTime date;
  final String email;
  final String from;
  final String subject;
  final String body;
  final String textBody;
  final String htmlBody;
  final List<AttachmentEntity> attachmentList;
  bool didRead;
  bool isDeleted;

  EmailMessageEntity({
    required this.id,
    required this.date,
    required this.email,
    this.from = "",
    this.subject = "",
    this.body = "",
    this.textBody = "",
    this.htmlBody = "",
    this.attachmentList = const [],
    this.didRead = false,
    this.isDeleted = false,
  });

  @override
  String toString() {
    return 'EmailMessageEntity{isarId: $isarId, id: $id, from: $from, subject: $subject, date: $date, email: $email, didRead: $didRead, isDeleted: $isDeleted}';
  }
}

@embedded
class AttachmentEntity {
  String filename;
  String contentType;
  int size;
  String savedPath;

  AttachmentEntity({
    this.filename = "",
    this.contentType = "",
    this.size = 0,
    this.savedPath = "",
  });
}

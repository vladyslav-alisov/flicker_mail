import 'package:flicker_mail/core/utils/date_utils.dart';
import 'package:flicker_mail/domain/models/message_attachment.dart';
import 'package:intl/intl.dart';

class EmailMessage {
  final int id;
  final int dbId;
  final String from;
  final String subject;
  final DateTime date;
  String email;
  bool didRead;
  List<MessageAttachment> attachments;
  String body;
  String textBody;
  String htmlBody;

  EmailMessage({
    required this.id,
    required this.dbId,
    required this.email,
    this.from = "",
    this.subject = "",
    required this.date,
    this.didRead = false,
    this.attachments = const [],
    this.body = "",
    this.textBody = "",
    this.htmlBody = "",
  });

  String get formattedDate {
    if (date.isToday) {
      return DateFormat('HH:mm').format(date);
    } else if (date.isSameYear) {
      return DateFormat('d MMM').format(date);
    } else {
      return DateFormat('dd.MM.yyyy').format(date);
    }
  }

  @override
  String toString() {
    return 'EmailMessage{id: $id, dbId: $dbId, from: $from, subject: $subject, date: $date, email: $email, didRead: $didRead, attachments: $attachments}';
  }
}

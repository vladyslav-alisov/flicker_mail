import 'package:flicker_mail/api/local/database/database_client.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/entities/email_message_db.dart';
import 'package:isar/isar.dart';

class EmailMessageDBService {
  final DatabaseClient _dbService = DatabaseClient.instance;

  //TODO: add pagination
  Future<List<EmailMessageDB>> getMessagesByEmail(String email) async {
    List<EmailMessageDB> messages = await _dbService.db.emailMessageDBs.filter().emailEqualTo(email).findAll();
    return messages;
  }

  Future<EmailMessageDB?> getMessage(String email, int id) async {
    EmailMessageDB? message =
        await _dbService.db.emailMessageDBs.filter().emailEqualTo(email).idEqualTo(id).findFirst();
    return message;
  }

  Future<bool> checkIfMessageExists(String email, int id) async {
    EmailMessageDB? message =
        await _dbService.db.emailMessageDBs.filter().emailEqualTo(email).idEqualTo(id).findFirst();
    return message != null;
  }

  Future<EmailMessageDB> addMessage(EmailMessageDB newMessage) async {
    int newId = await _dbService.db.writeTxn(() async {
      int id = await _dbService.db.emailMessageDBs.put(newMessage);
      return id;
    });
    newMessage.isarId = newId;
    return newMessage;
  }

  Future<List<EmailMessageDB>> addAllMessages(List<EmailMessageDB> newMessages) async {
    List<int> newId = await _dbService.db.writeTxn(() async {
      List<int> id = await _dbService.db.emailMessageDBs.putAll(newMessages);
      return id;
    });
    for (int i = 0; i < newId.length; i++) {
      newMessages[i].isarId = newId[i];
    }
    return newMessages;
  }
}

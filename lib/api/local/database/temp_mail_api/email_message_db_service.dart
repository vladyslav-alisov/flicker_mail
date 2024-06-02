import 'package:flicker_mail/api/local/database/database_client.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/entities/email_message_entity.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/entities/message_details_entity.dart';
import 'package:isar/isar.dart';

class EmailMessageDBService {
  final DatabaseClient _dbService = DatabaseClient.instance;

  //TODO: add pagination
  Future<List<EmailMessageEntity>> getMessagesByEmail(String email) async {
    List<EmailMessageEntity> messages =
        await _dbService.db.emailMessageEntitys.filter().emailEqualTo(email).isDeletedEqualTo(false).findAll();
    return messages;
  }

  Future<EmailMessageEntity?> getMessage(String email, int id) async {
    EmailMessageEntity? message =
        await _dbService.db.emailMessageEntitys.filter().emailEqualTo(email).idEqualTo(id).findFirst();
    return message;
  }

  Future<MessageDetailsEntity?> getMessageDetails(int messageId, int messageDbId) async {
    MessageDetailsEntity? message = await _dbService.db.messageDetailsEntitys
        .filter()
        .messageDbIdEqualTo(messageDbId)
        .messageIdEqualTo(messageId)
        .findFirst();
    return message;
  }

  Future<bool> checkIfMessageExists(String email, int id) async {
    EmailMessageEntity? message =
        await _dbService.db.emailMessageEntitys.filter().emailEqualTo(email).idEqualTo(id).findFirst();
    return message != null;
  }

  Future<EmailMessageEntity> addMessage(EmailMessageEntity newMessage) async {
    int newId = await _dbService.db.writeTxn(() async {
      int id = await _dbService.db.emailMessageEntitys.put(newMessage);
      return id;
    });
    newMessage.isarId = newId;
    return newMessage;
  }

  Future<MessageDetailsEntity> addMessageDetails(MessageDetailsEntity newMessageDetails) async {
    int newId = await _dbService.db.writeTxn(() async {
      int id = await _dbService.db.messageDetailsEntitys.put(newMessageDetails);
      return id;
    });
    newMessageDetails.isarId = newId;
    return newMessageDetails;
  }

  Future<EmailMessageEntity> updateDidRead(int id, {bool didRead = true}) async {
    EmailMessageEntity message = await _dbService.db.writeTxn(() async {
      EmailMessageEntity? message = await _dbService.db.emailMessageEntitys.get(id);
      if (message == null) throw Exception("Email message does not exist");
      message.didRead = didRead;
      await _dbService.db.emailMessageEntitys.put(message);
      return message;
    });
    return message;
  }

  Future<EmailMessageEntity> deleteSafelyMessage(int id) async {
    EmailMessageEntity message = await _dbService.db.writeTxn(() async {
      EmailMessageEntity? message = await _dbService.db.emailMessageEntitys.get(id);
      if (message == null) throw Exception("Email message does not exist");
      message.isDeleted = true;
      await _dbService.db.emailMessageEntitys.put(message);
      return message;
    });
    return message;
  }
}

import 'package:flicker_mail/api/local/database/database_client.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/entities/email_entity.dart';
import 'package:isar/isar.dart';

class EmailDBService {
  final DatabaseClient _dbService = DatabaseClient.instance;

  Future<EmailEntity?> getActiveEmail() async {
    EmailEntity? activeEmail = await _dbService.db.emailEntitys.filter().isActiveEqualTo(true).findFirst();
    return activeEmail;
  }

  Future<EmailEntity> addEmail(EmailEntity mailbox) async {
    int newId = await _dbService.db.writeTxn(() async {
      int id = await _dbService.db.emailEntitys.put(mailbox);
      return id;
    });
    mailbox.isarId = newId;
    return mailbox;
  }

  Future<List<EmailEntity>> getInactiveEmails() async {
    List<EmailEntity> inactiveEmails =
        await _dbService.db.emailEntitys.filter().isActiveEqualTo(false).sortByGeneratedAtDesc().findAll();
    return inactiveEmails;
  }

  Future<EmailEntity> changeEmailIsActiveStatus(int id, bool status) async {
    EmailEntity mailboxDB = await _dbService.db.writeTxn(() async {
      EmailEntity? mailboxDB = await _dbService.db.emailEntitys.get(id);
      if (mailboxDB == null) throw Exception("Email does not exist");
      mailboxDB.isActive = status;
      await _dbService.db.emailEntitys.put(mailboxDB);
      return mailboxDB;
    });
    return mailboxDB;
  }

  Future<EmailEntity> changeEmailLabel(int id, String newLabel) async {
    EmailEntity mailboxDB = await _dbService.db.writeTxn(() async {
      EmailEntity? mailboxDB = await _dbService.db.emailEntitys.get(id);
      if (mailboxDB == null) throw Exception("Email does not exist");
      mailboxDB.label = newLabel;
      await _dbService.db.emailEntitys.put(mailboxDB);
      return mailboxDB;
    });
    return mailboxDB;
  }

  Future<bool> deleteEmail(int id) async {
    bool isDeleted = await _dbService.db.writeTxn(() async {
      bool isDeleted = await _dbService.db.emailEntitys.delete(id);
      return isDeleted;
    });
    return isDeleted;
  }

  Future<bool> checkIfEmailExists(String login, String domain) async {
    EmailEntity? email =
        await _dbService.db.emailEntitys.filter().domainEqualTo(domain).loginEqualTo(login).findFirst();
    return email != null;
  }
}

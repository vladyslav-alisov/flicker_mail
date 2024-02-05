import 'package:flicker_mail/api/local/database/temp_mail_api/entities/mailbox_db.dart';
import 'package:flicker_mail/api/local/database/database_client.dart';
import 'package:isar/isar.dart';

class TempMailDBService {
  final DatabaseClient _dbService = DatabaseClient.instance;

  Future<MailboxDB?> getActiveEmail() async {
    MailboxDB? activeEmail = await _dbService.db.mailboxDBs.filter().isActiveEqualTo(true).findFirst();
    return activeEmail;
  }

  Future<MailboxDB> addNewEmail(MailboxDB mailbox) async {
    int newId = await _dbService.db.writeTxn(() async {
      int id = await _dbService.db.mailboxDBs.put(mailbox);
      return id;
    });
    mailbox.isarId = newId;
    return mailbox;
  }

  Future<List<MailboxDB>> getInactiveEmails() async {
    List<MailboxDB> inactiveEmails =
        await _dbService.db.mailboxDBs.filter().isActiveEqualTo(false).sortByGeneratedAtDesc().findAll();
    return inactiveEmails;
  }

  Future<MailboxDB> changeEmailIsActiveStatus(int id, bool status) async {
    MailboxDB mailboxDB = await _dbService.db.writeTxn(() async {
      MailboxDB? mailboxDB = await _dbService.db.mailboxDBs.get(id);
      if (mailboxDB == null) throw Exception("Email does not exist");
      mailboxDB.isActive = status;
      await _dbService.db.mailboxDBs.put(mailboxDB);
      return mailboxDB;
    });
    return mailboxDB;
  }

  Future<bool> deleteEmail(int id) async {
    bool isDeleted = await _dbService.db.writeTxn(() async {
      bool isDeleted = await _dbService.db.mailboxDBs.delete(id);
      return isDeleted;
    });
    return isDeleted;
  }
}

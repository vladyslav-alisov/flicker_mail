import 'package:flicker_mail/api/local/database/temp_mail_api/entities/mailbox_db.dart';
import 'package:flicker_mail/api/local/database/database_client.dart';
import 'package:isar/isar.dart';

class TempMailDBService {
  final DatabaseClient _dbService = DatabaseClient.instance;

  Future<MailboxDB?> getLatestMailbox() async {
    MailboxDB? latestMailbox = await _dbService.db.mailboxDBs.where().sortByGeneratedAtDesc().findFirst();
    return latestMailbox;
  }

  Future<void> saveMailbox(MailboxDB mailbox) async {
    await _dbService.db.writeTxn(() async {
      await _dbService.db.mailboxDBs.put(mailbox);
    });
  }
}

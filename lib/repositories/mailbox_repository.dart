import 'package:flicker_mail/api/local/database/temp_mail_api/entities/mailbox_db.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/temp_mail_db_service.dart';
import 'package:flicker_mail/api/network/temp_email_api/entities/mail_details_ntw.dart';
import 'package:flicker_mail/api/network/temp_email_api/entities/mail_ntw.dart';
import 'package:flicker_mail/api/network/temp_email_api/entities/mailbox_ntw.dart';
import 'package:flicker_mail/api/network/temp_email_api/temp_mail_network_service.dart';
import 'package:flicker_mail/models/mail/mail.dart';
import 'package:flicker_mail/models/mail/mail_details.dart';
import 'package:flicker_mail/models/mail/mail_mapper.dart';
import 'package:flicker_mail/models/mail/mailbox.dart';

class TempMailRepository {
  TempMailRepository(this._tempMailNetworkService, this._tempMailDBService);

  final TempMailNetworkService _tempMailNetworkService;
  final TempMailDBService _tempMailDBService;
  final MailMapper _mailMapper = MailMapper();

  Future<void> checkHealth() async {
    await _tempMailNetworkService.checkHealth();
  }

  Future<List<String>> getDomainList() async {
    List<String> result = await _tempMailNetworkService.getDomainList();
    return result;
  }

  Future<Email> getMailbox() async {
    MailboxDB? mailboxDB = await _tempMailDBService.getLatestMailbox();
    late Email mailbox;
    if (mailboxDB != null) {
      mailbox = _mailMapper.mapMailboxDBToMailbox(mailboxDB);
    } else {
      mailbox = await generateNewMailbox();
    }
    return mailbox;
  }

  Future<Email> generateNewMailbox() async {
    MailboxNTW mailboxNTW = await _tempMailNetworkService.generateMailbox();
    MailboxDB mailboxDB = _mailMapper.mapMailboxNTWToMailboxDB(mailboxNTW);
    await _tempMailDBService.saveMailbox(mailboxDB);
    Email mailbox = _mailMapper.mapMailboxDBToMailbox(mailboxDB);
    return mailbox;
  }

  Future<Email> saveNewEmail(String login, String domain) async {
    MailboxNTW mailboxNTW = MailboxNTW(domain: domain, login: login, generatedAt: DateTime.now());
    MailboxDB mailboxDB = _mailMapper.mapMailboxNTWToMailboxDB(mailboxNTW);
    await _tempMailDBService.saveMailbox(mailboxDB);
    Email mailbox = _mailMapper.mapMailboxDBToMailbox(mailboxDB);
    return mailbox;
  }

  Future<List<Mail>> getMails(Email mailbox) async {
    List<MailNTW> result = await _tempMailNetworkService.getMails(
      mailbox.login,
      mailbox.domain,
    );
    List<Mail> mails = _mailMapper.mapMailNTWToMailList(result);
    return mails;
  }

  Future<MailDetails> getMailDetails(Email mailbox, int mailId) async {
    MailDetailsNTW result = await _tempMailNetworkService.getMailDetails(
      mailbox.login,
      mailbox.domain,
      mailId,
    );
    MailDetails mails = _mailMapper.mapMailDetailsNTWToMailDetails(result);
    return mails;
  }
}

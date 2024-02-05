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

  Future<Email> getActiveMailbox() async {
    MailboxDB? mailboxDB = await _tempMailDBService.getActiveEmail();
    late Email mailbox;
    if (mailboxDB != null) {
      mailbox = _mailMapper.mapMailboxDBToMailbox(mailboxDB);
    } else {
      mailbox = await generateNewMailbox();
    }
    return mailbox;
  }

  Future<(String login, String domain)> generateRandomMailbox() async {
    MailboxNTW mailboxNTW = await _tempMailNetworkService.generateMailbox();
    return (mailboxNTW.login, mailboxNTW.domain);
  }

  Future<Email> generateNewMailbox() async {
    MailboxNTW mailboxNTW = await _tempMailNetworkService.generateMailbox();
    MailboxDB newMailboxDB = _mailMapper.mapMailboxNTWToMailboxDB(mailboxNTW);
    MailboxDB mailboxDB = await _tempMailDBService.addNewEmail(newMailboxDB);
    Email mailbox = _mailMapper.mapMailboxDBToMailbox(mailboxDB);
    return mailbox;
  }

  Future<Email> saveNewEmail(String login, String domain) async {
    MailboxNTW mailboxNTW = MailboxNTW(domain: domain, login: login, generatedAt: DateTime.now());
    MailboxDB newMailboxDB = _mailMapper.mapMailboxNTWToMailboxDB(mailboxNTW);
    MailboxDB mailboxDB = await _tempMailDBService.addNewEmail(newMailboxDB);
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

  Future<List<Email>> getInactiveEmails() async {
    List<MailboxDB> inactiveEmailsDb = await _tempMailDBService.getInactiveEmails();
    List<Email> inactiveEmails = _mailMapper.mapMailboxDBToMailboxList(inactiveEmailsDb);
    return inactiveEmails;
  }

  Future<Email> changeEmailIsActiveStatus(int id, bool status) async {
    MailboxDB emailDB = await _tempMailDBService.changeEmailIsActiveStatus(id, status);
    Email activatedEmail = _mailMapper.mapMailboxDBToMailbox(emailDB);
    return activatedEmail;
  }

  Future<bool> deleteEmail(int id) async {
    bool isDeleted = await _tempMailDBService.deleteEmail(id);
    return isDeleted;
  }
}
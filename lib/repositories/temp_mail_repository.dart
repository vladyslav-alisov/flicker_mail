import 'package:flicker_mail/api/local/database/temp_mail_api/email_message_db_service.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/entities/email_message_db.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/entities/mailbox_db.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/email_db_service.dart';
import 'package:flicker_mail/api/network/sec_mail_api/entities/mail_details_dto.dart';
import 'package:flicker_mail/api/network/sec_mail_api/entities/email_message_dto.dart';
import 'package:flicker_mail/api/network/sec_mail_api/entities/email_dto.dart';
import 'package:flicker_mail/api/network/sec_mail_api/temp_mail_network_service.dart';
import 'package:flicker_mail/models/email_message/email_message.dart';
import 'package:flicker_mail/models/email_message/email_message_mapper.dart';
import 'package:flicker_mail/models/mail/mail_details.dart';
import 'package:flicker_mail/models/email/email_mapper.dart';
import 'package:flicker_mail/models/email/email.dart';
import 'package:uuid/uuid.dart';

class TempMailRepository {
  TempMailRepository(this._tempMailNetworkService, this._tempMailDBService, this._emailMessageDBService);

  final TempMailNetworkService _tempMailNetworkService;
  final EmailDBService _tempMailDBService;
  final EmailMessageDBService _emailMessageDBService;
  final MailMapper _mailMapper = MailMapper();
  final EmailMessageMapper _emailMessageMapper = EmailMessageMapper();

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
      mailbox = _mailMapper.mapDBEntityToEmail(mailboxDB);
    } else {
      mailbox = await generateNewMailbox();
    }
    return mailbox;
  }

  Future<(String login, String domain)> generateRandomMailbox() async {
    EmailDto mailboxNTW = await _tempMailNetworkService.generateMailbox();
    return (mailboxNTW.login, mailboxNTW.domain);
  }

  Future<Email> generateNewMailbox() async {
    EmailDto mailboxNTW = await _tempMailNetworkService.generateMailbox();
    MailboxDB newMailboxDB = _mailMapper.mapNTWToDB(mailboxNTW);
    MailboxDB mailboxDB = await _tempMailDBService.addEmail(newMailboxDB);
    Email mailbox = _mailMapper.mapDBEntityToEmail(mailboxDB);
    return mailbox;
  }

  Future<Email> saveNewEmail(String login, String domain, String label) async {
    MailboxDB newMailboxDB = MailboxDB(
      domain: domain,
      login: login,
      generatedAt: DateTime.now(),
      isActive: true,
      label: label,
    );

    MailboxDB savedMailboxDB = await _tempMailDBService.addEmail(newMailboxDB);
    Email mailbox = _mailMapper.mapDBEntityToEmail(savedMailboxDB);
    return mailbox;
  }

  Future<List<EmailMessage>> getMails(Email email) async {
    List<EmailMessageDto> result = await _tempMailNetworkService.getMails(
      email.login,
      email.domain,
    );

    print("result: ${result.length}");

    for (EmailMessageDto messageDto in result) {
      bool isSaved = await _emailMessageDBService.checkIfMessageExists(email.email, messageDto.id);

      if (!isSaved) {
        EmailMessageDB messageToSaveInDb = _emailMessageMapper.mapDtoToEntity(
          messageDto,
          email.email,
        );
        await _emailMessageDBService.addMessage(messageToSaveInDb);
      }
    }

    List<EmailMessageDB> emailMessageDbList = await _emailMessageDBService.getMessagesByEmail(email.email);

    if (emailMessageDbList.isEmpty) return [];

    List<EmailMessage> mails = _emailMessageMapper.mapEntityToModelList(emailMessageDbList);
    return mails;
  }

  Future<MailDetails> getMailDetails(Email mailbox, int mailId) async {
    MailDetailsDto result = await _tempMailNetworkService.getMailDetails(
      mailbox.login,
      mailbox.domain,
      mailId,
    );
    MailDetails mails = _mailMapper.mapMailDetailsNTWToMailDetails(result);
    return mails;
  }

  Future<List<Email>> getInactiveEmails() async {
    List<MailboxDB> inactiveEmailsDb = await _tempMailDBService.getInactiveEmails();
    List<Email> inactiveEmails = _mailMapper.mapDBEntityToEmailList(inactiveEmailsDb);
    return inactiveEmails;
  }

  Future<Email> changeEmailIsActiveStatus(int id, bool status) async {
    MailboxDB emailDB = await _tempMailDBService.changeEmailIsActiveStatus(id, status);
    Email activatedEmail = _mailMapper.mapDBEntityToEmail(emailDB);
    return activatedEmail;
  }

  Future<Email> changeEmailLabel(int id, String newLabel) async {
    MailboxDB emailDB = await _tempMailDBService.changeEmailLabel(id, newLabel);
    Email updatedEmail = _mailMapper.mapDBEntityToEmail(emailDB);
    return updatedEmail;
  }

  Future<bool> deleteEmail(int id) async {
    bool isDeleted = await _tempMailDBService.deleteEmail(id);
    return isDeleted;
  }

  Future<bool> checkIfEmailExists(String login, String domain) async {
    bool isExist = await _tempMailDBService.checkIfEmailExists(login, domain);
    return isExist;
  }
}

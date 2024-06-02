import 'package:flicker_mail/api/local/database/temp_mail_api/email_message_db_service.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/email_db_service.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/entities/email_message_entity.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/entities/email_entity.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/entities/message_details_entity.dart';
import 'package:flicker_mail/api/network/sec_mail_api/dto/mail_details_dto.dart';
import 'package:flicker_mail/api/network/sec_mail_api/dto/email_message_dto.dart';
import 'package:flicker_mail/api/network/sec_mail_api/dto/email_dto.dart';
import 'package:flicker_mail/api/network/sec_mail_api/temp_mail_network_service.dart';
import 'package:flicker_mail/models/email_message/email_message.dart';
import 'package:flicker_mail/models/email_message/email_message_mapper.dart';
import 'package:flicker_mail/models/message_details/message_details.dart';
import 'package:flicker_mail/models/email/email_mapper.dart';
import 'package:flicker_mail/models/email/email.dart';
import 'package:flicker_mail/models/message_details/message_details_mapper.dart';

class TempMailRepository {
  TempMailRepository(
    this._tempMailNetworkService,
    this._tempMailDBService,
    this._emailMessageDBService,
  );

  final TempMailNetworkService _tempMailNetworkService;
  final EmailDBService _tempMailDBService;
  final EmailMessageDBService _emailMessageDBService;
  final EmailMapper _emailMapper = EmailMapper();
  final EmailMessageMapper _emailMessageMapper = EmailMessageMapper();
  final MessageDetailsMapper _messageDetailsMapper = MessageDetailsMapper();

  Future<void> checkHealth() async {
    await _tempMailNetworkService.checkHealth();
  }

  Future<List<String>> getAvailableDomains() async {
    List<String> result = await _tempMailNetworkService.getDomainList();
    return result;
  }

  Future<Email> getActiveEmail() async {
    EmailEntity? mailboxDB = await _tempMailDBService.getActiveEmail();
    late Email mailbox;
    if (mailboxDB != null) {
      mailbox = _emailMapper.mapDBEntityToEmail(mailboxDB);
    } else {
      mailbox = await generateNewEmail();
    }
    return mailbox;
  }

  Future<(String login, String domain)> generateRandomEmail() async {
    EmailDto mailboxNTW = await _tempMailNetworkService.generateMailbox();
    return (mailboxNTW.login, mailboxNTW.domain);
  }

  Future<Email> generateNewEmail() async {
    EmailDto mailboxNTW = await _tempMailNetworkService.generateMailbox();
    EmailEntity newMailboxDB = _emailMapper.mapDtoToEntity(mailboxNTW);
    EmailEntity mailboxDB = await _tempMailDBService.addEmail(newMailboxDB);
    Email mailbox = _emailMapper.mapDBEntityToEmail(mailboxDB);
    return mailbox;
  }

  Future<Email> saveNewEmail(String login, String domain, String label) async {
    EmailEntity newMailboxDB = EmailEntity(
      domain: domain,
      login: login,
      generatedAt: DateTime.now(),
      isActive: true,
      label: label,
    );

    EmailEntity savedMailboxDB = await _tempMailDBService.addEmail(newMailboxDB);
    Email mailbox = _emailMapper.mapDBEntityToEmail(savedMailboxDB);
    return mailbox;
  }

  Future<List<EmailMessage>> getEmailMessages(Email email) async {
    List<EmailMessageDto> result = await _tempMailNetworkService.getMails(
      email.login,
      email.domain,
    );

    for (EmailMessageDto messageDto in result) {
      bool isSaved = await _emailMessageDBService.checkIfMessageExists(email.email, messageDto.id);

      if (!isSaved) {
        EmailMessageEntity messageToSaveInDb = _emailMessageMapper.mapDtoToEntity(
          messageDto,
          email.email,
        );

        EmailMessageEntity emailMessageEntity = await _emailMessageDBService.addMessage(messageToSaveInDb);

        MessageDetailsDto messageDetailsDto = await _tempMailNetworkService.getMailDetails(
          email.login,
          email.domain,
          emailMessageEntity.id,
        );

        MessageDetailsEntity messageDetailsEntity = _messageDetailsMapper.mapDtoToEntity(
          emailMessageEntity.id,
          emailMessageEntity.isarId,
          email.email,
          messageDetailsDto,
        );

        await _emailMessageDBService.addMessageDetails(
          messageDetailsEntity,
        );
      }
    }

    List<EmailMessageEntity> emailMessageDbList = await _emailMessageDBService.getMessagesByEmail(email.email);

    if (emailMessageDbList.isEmpty) return [];

    List<EmailMessage> mails = _emailMessageMapper.mapEntityToModelList(emailMessageDbList);
    return mails;
  }

  Future<MessageDetails> getMailDetails(Email email, int messageId, int messageDbId) async {
    MessageDetailsEntity? messageDetailsEntity = await _emailMessageDBService.getMessageDetails(
      messageId,
      messageDbId,
    );

    if (messageDetailsEntity != null) {
      MessageDetails messageDetails = _messageDetailsMapper.mapEntityToModel(messageDetailsEntity);
      return messageDetails;
    } else {
      MessageDetailsDto messageDetailsDto = await _tempMailNetworkService.getMailDetails(
        email.login,
        email.domain,
        messageId,
      );

      MessageDetailsEntity messageDetailsEntity = _messageDetailsMapper.mapDtoToEntity(
        messageId,
        messageDbId,
        email.email,
        messageDetailsDto,
      );

      MessageDetailsEntity savedMessageDetailsEntity = await _emailMessageDBService.addMessageDetails(
        messageDetailsEntity,
      );

      MessageDetails messageDetails = _messageDetailsMapper.mapEntityToModel(
        savedMessageDetailsEntity,
      );
      return messageDetails;
    }
  }

  Future<List<Email>> getInactiveEmails() async {
    List<EmailEntity> inactiveEmailsDb = await _tempMailDBService.getInactiveEmails();
    List<Email> inactiveEmails = _emailMapper.mapDBEntityToEmailList(inactiveEmailsDb);
    return inactiveEmails;
  }

  Future<Email> changeEmailIsActiveStatus(int id, bool status) async {
    EmailEntity emailDB = await _tempMailDBService.changeEmailIsActiveStatus(id, status);
    Email activatedEmail = _emailMapper.mapDBEntityToEmail(emailDB);
    return activatedEmail;
  }

  Future<Email> changeEmailLabel(int id, String newLabel) async {
    EmailEntity emailDB = await _tempMailDBService.changeEmailLabel(id, newLabel);
    Email updatedEmail = _emailMapper.mapDBEntityToEmail(emailDB);
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

  Future<EmailMessage> updateDidRead(int dbId, {didRead = true}) async {
    EmailMessageEntity emailMessageEntity = await _emailMessageDBService.updateDidRead(dbId);
    EmailMessage emailMessage = _emailMessageMapper.mapEntityToModel(emailMessageEntity);
    return emailMessage;
  }

  Future<EmailMessage> deleteSafelyMessage(int dbId) async {
    EmailMessageEntity emailMessageEntity = await _emailMessageDBService.deleteSafelyMessage(dbId);
    EmailMessage emailMessage = _emailMessageMapper.mapEntityToModel(emailMessageEntity);
    return emailMessage;
  }
}

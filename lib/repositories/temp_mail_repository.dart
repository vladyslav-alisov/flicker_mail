import 'dart:io';

import 'package:flicker_mail/api/local/database/temp_mail_api/email_db_service.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/email_message_db_service.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/entities/email_entity.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/entities/email_message_entity.dart';
import 'package:flicker_mail/api/network/sec_mail_api/dto/attachment_dto.dart';
import 'package:flicker_mail/api/network/sec_mail_api/dto/email_dto.dart';
import 'package:flicker_mail/api/network/sec_mail_api/dto/email_message_dto.dart';
import 'package:flicker_mail/api/network/sec_mail_api/dto/mail_details_dto.dart';
import 'package:flicker_mail/api/network/sec_mail_api/temp_mail_network_service.dart';
import 'package:flicker_mail/models/email/email.dart';
import 'package:flicker_mail/models/email/email_mapper.dart';
import 'package:flicker_mail/models/email_message/email_message.dart';
import 'package:flicker_mail/models/email_message/email_message_mapper.dart';
import 'package:flicker_mail/models/message_attachment/message_attachment_mapper.dart';
import 'package:path_provider/path_provider.dart';

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
  final MessageAttachmentMapper _messageAttachmentMapper = MessageAttachmentMapper();

  Future<void> checkHealth() async {
    await _tempMailNetworkService.checkHealth();
  }

  Future<void> cleanUp() async {
    await _emailMessageDBService.cleanSafelyDeletedMessages(DateTime.now().subtract(Duration(minutes: 80)));
  }

  Future<List<String>> getAvailableDomains() async {
    List<String> result = await _tempMailNetworkService.getDomainList();
    return result;
  }

  Future<Email> getActiveEmail() async {
    EmailEntity? mailboxDB = await _tempMailDBService.getActiveEmail();
    late Email mailbox;
    if (mailboxDB != null) {
      mailbox = _emailMapper.mapEntityToModel(mailboxDB);
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
    Email mailbox = _emailMapper.mapEntityToModel(mailboxDB);
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
    Email mailbox = _emailMapper.mapEntityToModel(savedMailboxDB);
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
        MessageDetailsDto messageDetailsDto = await _tempMailNetworkService.getMailDetails(
          email.login,
          email.domain,
          messageDto.id,
        );

        List<AttachmentEntity> attachmentEntityList = await saveAttachments(
          messageDetailsDto.attachments,
          email,
          messageDetailsDto.id,
        );

        EmailMessageEntity messageToSaveInDb = _emailMessageMapper.mapDtoToEntity(
          messageDetailsDto,
          attachmentEntityList,
          email.email,
        );

        await _emailMessageDBService.addMessage(messageToSaveInDb);
      }
    }

    List<EmailMessageEntity> emailMessageDbList = await _emailMessageDBService.getMessagesByEmail(email.email);

    if (emailMessageDbList.isEmpty) return [];

    List<EmailMessage> mails = _emailMessageMapper.mapEntityToModelList(emailMessageDbList);
    return mails;
  }

  Future<List<AttachmentEntity>> saveAttachments(
    List<AttachmentDto> messageAttachmentDtoList,
    Email email,
    int messageId,
  ) async {
    if (messageAttachmentDtoList.isEmpty) return [];

    List<AttachmentEntity> attachmentEntityList = [];

    Directory directory = await getApplicationCacheDirectory();

    for (AttachmentDto dto in messageAttachmentDtoList) {
      String filePath = await _tempMailNetworkService.getAttachment(
        email.login,
        email.domain,
        messageId,
        dto.filename,
        "${directory.path}/$messageId${dto.filename}",
      );

      AttachmentEntity attachmentEntity = _messageAttachmentMapper.mapDtoToEntity(dto, filePath);
      attachmentEntityList.add(attachmentEntity);
    }

    return attachmentEntityList;
  }

  Future<List<Email>> getInactiveEmails() async {
    List<EmailEntity> inactiveEmailsDb = await _tempMailDBService.getInactiveEmails();
    List<Email> inactiveEmails = _emailMapper.mapEntityToModelList(inactiveEmailsDb);
    return inactiveEmails;
  }

  Future<Email> changeEmailIsActiveStatus(int id, bool status) async {
    EmailEntity emailDB = await _tempMailDBService.changeEmailIsActiveStatus(id, status);
    Email activatedEmail = _emailMapper.mapEntityToModel(emailDB);
    return activatedEmail;
  }

  Future<Email> changeEmailLabel(int id, String newLabel) async {
    EmailEntity emailDB = await _tempMailDBService.changeEmailLabel(id, newLabel);
    Email updatedEmail = _emailMapper.mapEntityToModel(emailDB);
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

  Future<List<EmailMessage>> deleteSafelyAllMessages(String email) async {
    List<EmailMessageEntity> emailMessageEntities = await _emailMessageDBService.deleteSafelyAllMessages(email);
    List<EmailMessage> emailMessageList = _emailMessageMapper.mapEntityToModelList(emailMessageEntities);
    return emailMessageList;
  }

  Future<List<EmailMessage>> searchMessages(Email email, String input) async {
    List<EmailMessageEntity> results = await _emailMessageDBService.searchMessages(email.email, input);
    return _emailMessageMapper.mapEntityToModelList(results);
  }
}

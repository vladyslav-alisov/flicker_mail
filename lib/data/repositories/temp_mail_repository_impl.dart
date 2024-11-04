import 'dart:io';

import 'package:flicker_mail/core/error/exceptions.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_local_data_source/entities/email_entity.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_local_data_source/entities/email_message_entity.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_local_data_source/temp_mail_local_data_source.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_remote_data_source/dto/attachment_dto.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_remote_data_source/dto/email_dto.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_remote_data_source/dto/email_message_dto.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_remote_data_source/dto/mail_details_dto.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_remote_data_source/temp_mail_remote_data_source.dart';
import 'package:flicker_mail/data/models/email_message_model.dart';
import 'package:flicker_mail/data/models/email_model.dart';
import 'package:flicker_mail/domain/models/email.dart';
import 'package:flicker_mail/domain/models/email_message.dart';
import 'package:flicker_mail/domain/repositories/temp_mail_repository.dart';
import 'package:path_provider/path_provider.dart';

class TempMailRepositoryImpl implements TempMailRepository {
  TempMailRepositoryImpl({
    required TempMailRemoteDataSource tempMailRemoteDataSource,
    required TempMailLocalDataSource tempMailLocalDataSource,
  })  : _tempMailRemoteDataSource = tempMailRemoteDataSource,
        _tempMailLocalDataSource = tempMailLocalDataSource;

  final TempMailRemoteDataSource _tempMailRemoteDataSource;
  final TempMailLocalDataSource _tempMailLocalDataSource;

  @override
  Future<void> checkHealth() async {
    try {
      await _tempMailRemoteDataSource.checkHealth();
    } on ServerException catch (e) {
      throw e;
    }
  }

  @override
  Future<void> cleanUp() async {
    await _tempMailLocalDataSource.cleanSafelyDeletedMessages(DateTime.now().subtract(const Duration(minutes: 80)));
  }

  @override
  Future<List<String>> getAvailableDomains() async {
    List<String> result = await _tempMailRemoteDataSource.getDomainList();
    return result;
  }

  @override
  Future<Email> getActiveEmail() async {
    EmailEntity? mailboxDB = await _tempMailLocalDataSource.getActiveEmail();
    late Email mailbox;
    if (mailboxDB != null) {
      mailbox = EmailModel.fromEntity(mailboxDB);
    } else {
      mailbox = await generateNewEmail();
    }
    return mailbox;
  }

  @override
  Future<(String login, String domain)> generateRandomEmail() async {
    EmailDto mailboxNTW = await _tempMailRemoteDataSource.generateMailbox();
    return (mailboxNTW.login, mailboxNTW.domain);
  }

  @override
  Future<Email> generateNewEmail() async {
    EmailDto emailDto = await _tempMailRemoteDataSource.generateMailbox();
    EmailEntity emailEntity = EmailEntity.fromDto(emailDto);
    EmailEntity mailboxDB = await _tempMailLocalDataSource.addEmail(emailEntity);
    EmailModel mailbox = EmailModel.fromEntity(mailboxDB);
    return mailbox;
  }

  @override
  Future<Email> saveNewEmail(String login, String domain, String label) async {
    EmailEntity newMailboxDB = EmailEntity(
      domain: domain,
      login: login,
      generatedAt: DateTime.now(),
      isActive: true,
      label: label,
    );

    EmailEntity savedMailboxDB = await _tempMailLocalDataSource.addEmail(newMailboxDB);
    Email mailbox = EmailModel.fromEntity(savedMailboxDB);
    return mailbox;
  }

  @override
  Future<List<EmailMessage>> getEmailMessages(Email email) async {
    List<EmailMessageDto> result = await _tempMailRemoteDataSource.getMails(
      email.login,
      email.domain,
    );

    for (EmailMessageDto messageDto in result) {
      bool isSaved = await _tempMailLocalDataSource.checkIfMessageExists(email.email, messageDto.id);

      if (!isSaved) {
        MessageDetailsDto messageDetailsDto = await _tempMailRemoteDataSource.getMailDetails(
          email.login,
          email.domain,
          messageDto.id,
        );

        List<AttachmentEntity> attachmentEntityList = await saveAttachments(
          messageDetailsDto.attachments,
          email,
          messageDetailsDto.id,
        );

        EmailMessageEntity messageToSaveInDb = EmailMessageEntity.fromDto(
          messageDetailsDto,
          attachmentEntityList,
          email.email,
        );

        await _tempMailLocalDataSource.addMessage(messageToSaveInDb);
      }
    }

    List<EmailMessageEntity> emailMessageDbList = await _tempMailLocalDataSource.getMessagesByEmail(email.email);

    if (emailMessageDbList.isEmpty) return [];

    List<EmailMessage> mails = emailMessageDbList.map((e) => EmailMessageModel.fromEntity(e)).toList();
    return mails;
  }

  @override
  Future<List<AttachmentEntity>> saveAttachments(
    List<AttachmentDto> messageAttachmentDtoList,
    Email email,
    int messageId,
  ) async {
    if (messageAttachmentDtoList.isEmpty) return [];

    List<AttachmentEntity> attachmentEntityList = [];

    Directory directory = await getApplicationCacheDirectory();

    for (AttachmentDto dto in messageAttachmentDtoList) {
      String filePath = await _tempMailRemoteDataSource.getAttachment(
        email.login,
        email.domain,
        messageId,
        dto.filename,
        "${directory.path}/$messageId${dto.filename}",
      );

      AttachmentEntity attachmentEntity = AttachmentEntity.fromEntity(dto, filePath);
      attachmentEntityList.add(attachmentEntity);
    }

    return attachmentEntityList;
  }

  @override
  Future<List<Email>> getInactiveEmails() async {
    List<EmailEntity> inactiveEmailsDb = await _tempMailLocalDataSource.getInactiveEmails();
    List<Email> inactiveEmails = inactiveEmailsDb.map((e) => EmailModel.fromEntity(e)).toList();
    return inactiveEmails;
  }

  @override
  Future<Email> changeEmailIsActiveStatus(int id, bool status) async {
    EmailEntity emailDB = await _tempMailLocalDataSource.changeEmailIsActiveStatus(id, status);
    Email activatedEmail = EmailModel.fromEntity(emailDB);
    return activatedEmail;
  }

  @override
  Future<Email> changeEmailLabel(int id, String newLabel) async {
    EmailEntity emailDB = await _tempMailLocalDataSource.changeEmailLabel(id, newLabel);
    Email updatedEmail = EmailModel.fromEntity(emailDB);
    return updatedEmail;
  }

  @override
  Future<bool> deleteEmail(int id) async {
    bool isDeleted = await _tempMailLocalDataSource.deleteEmail(id);
    return isDeleted;
  }

  @override
  Future<bool> checkIfEmailExists(String login, String domain) async {
    bool isExist = await _tempMailLocalDataSource.checkIfEmailExists(login, domain);
    return isExist;
  }

  @override
  Future<EmailMessage> updateDidRead(int dbId, {didRead = true}) async {
    EmailMessageEntity emailMessageEntity = await _tempMailLocalDataSource.updateDidRead(dbId);
    EmailMessage emailMessage = EmailMessageModel.fromEntity(emailMessageEntity);
    return emailMessage;
  }

  @override
  Future<EmailMessage> deleteSafelyMessage(int dbId) async {
    EmailMessageEntity emailMessageEntity = await _tempMailLocalDataSource.deleteSafelyMessage(dbId);
    EmailMessage emailMessage = EmailMessageModel.fromEntity(emailMessageEntity);
    return emailMessage;
  }

  @override
  Future<List<EmailMessage>> deleteSafelyAllMessages(String email) async {
    List<EmailMessageEntity> emailMessageEntities = await _tempMailLocalDataSource.deleteSafelyAllMessages(email);
    List<EmailMessage> emailMessageList = emailMessageEntities.map((e) => EmailMessageModel.fromEntity(e)).toList();
    return emailMessageList;
  }

  @override
  Future<List<EmailMessage>> searchMessages(Email email, String input) async {
    List<EmailMessageEntity> emailMessageEntities = await _tempMailLocalDataSource.searchMessages(email.email, input);
    List<EmailMessage> emailMessageList = emailMessageEntities.map((e) => EmailMessageModel.fromEntity(e)).toList();
    return emailMessageList;
  }
}

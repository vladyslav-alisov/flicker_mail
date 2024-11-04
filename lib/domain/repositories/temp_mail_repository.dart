import 'package:flicker_mail/data/data_sources/temp_mail_local_data_source/entities/email_message_entity.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_remote_data_source/dto/attachment_dto.dart';
import 'package:flicker_mail/domain/models/email.dart';
import 'package:flicker_mail/domain/models/email_message.dart';

abstract interface class TempMailRepository {
  Future<void> checkHealth();

  Future<void> cleanUp();

  Future<List<String>> getAvailableDomains();

  Future<Email> getActiveEmail();

  Future<(String login, String domain)> generateRandomEmail();

  Future<Email> generateNewEmail();

  Future<Email> saveNewEmail(String login, String domain, String label);

  Future<List<EmailMessage>> getEmailMessages(Email email);

  Future<List<AttachmentEntity>> saveAttachments(
    List<AttachmentDto> messageAttachmentDtoList,
    Email email,
    int messageId,
  );

  Future<List<Email>> getInactiveEmails();

  Future<Email> changeEmailIsActiveStatus(int id, bool status);

  Future<Email> changeEmailLabel(int id, String newLabel);

  Future<bool> deleteEmail(int id);

  Future<bool> checkIfEmailExists(String login, String domain);

  Future<EmailMessage> updateDidRead(int dbId, {didRead = true});

  Future<EmailMessage> deleteSafelyMessage(int dbId);

  Future<List<EmailMessage>> deleteSafelyAllMessages(String email);

  Future<List<EmailMessage>> searchMessages(Email email, String input);
}

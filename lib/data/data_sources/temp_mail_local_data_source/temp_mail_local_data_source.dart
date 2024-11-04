import 'package:flicker_mail/core/error/exceptions.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_local_data_source/entities/email_entity.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_local_data_source/entities/email_message_entity.dart';
import 'package:isar/isar.dart';

abstract interface class TempMailLocalDataSource {
  Future<EmailEntity?> getActiveEmail();

  Future<EmailEntity> addEmail(EmailEntity mailbox);

  Future<List<EmailEntity>> getInactiveEmails();

  Future<EmailEntity> changeEmailIsActiveStatus(int id, bool status);

  Future<EmailEntity> changeEmailLabel(int id, String newLabel);

  Future<bool> deleteEmail(int id);

  Future<bool> checkIfEmailExists(String login, String domain);

  Future<List<EmailMessageEntity>> getMessagesByEmail(String email);

  Future<List<EmailMessageEntity>> searchMessages(String email, String input);

  Future<bool> checkIfMessageExists(String email, int id);

  Future<EmailMessageEntity> addMessage(EmailMessageEntity newMessage);

  Future<EmailMessageEntity> updateDidRead(int id, {bool didRead = true});

  Future<EmailMessageEntity> deleteSafelyMessage(int id);

  Future<List<EmailMessageEntity>> deleteSafelyAllMessages(String email);

  Future<void> cleanSafelyDeletedMessages(DateTime until);
}

class TempMailIsarImpl implements TempMailLocalDataSource {
  final Isar _isar;

  TempMailIsarImpl({
    required Isar isar,
  }) : _isar = isar;

  @override
  Future<EmailEntity?> getActiveEmail() async {
    try {
      EmailEntity? activeEmail = await _isar.emailEntitys.filter().isActiveEqualTo(true).findFirst();
      return activeEmail;
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<EmailEntity> addEmail(EmailEntity mailbox) async {
    try {
      int newId = await _isar.writeTxn(() async {
        int id = await _isar.emailEntitys.put(mailbox);
        return id;
      });
      mailbox.isarId = newId;
      return mailbox;
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<List<EmailEntity>> getInactiveEmails() async {
    try {
      List<EmailEntity> inactiveEmails =
          await _isar.emailEntitys.filter().isActiveEqualTo(false).sortByGeneratedAtDesc().findAll();
      return inactiveEmails;
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<EmailEntity> changeEmailIsActiveStatus(int id, bool status) async {
    try {
      EmailEntity mailboxDB = await _isar.writeTxn(() async {
        EmailEntity? mailboxDB = await _isar.emailEntitys.get(id);
        if (mailboxDB == null) throw Exception("Email does not exist");
        mailboxDB.isActive = status;
        await _isar.emailEntitys.put(mailboxDB);
        return mailboxDB;
      });
      return mailboxDB;
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<EmailEntity> changeEmailLabel(int id, String newLabel) async {
    try {
      EmailEntity mailboxDB = await _isar.writeTxn(() async {
        EmailEntity? mailboxDB = await _isar.emailEntitys.get(id);
        if (mailboxDB == null) throw Exception("Email does not exist");
        mailboxDB.label = newLabel;
        await _isar.emailEntitys.put(mailboxDB);
        return mailboxDB;
      });
      return mailboxDB;
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<bool> deleteEmail(int id) async {
    try {
      bool isDeleted = await _isar.writeTxn(() async {
        bool isDeleted = await _isar.emailEntitys.delete(id);
        return isDeleted;
      });
      return isDeleted;
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<bool> checkIfEmailExists(String login, String domain) async {
    try {
      EmailEntity? email = await _isar.emailEntitys.filter().domainEqualTo(domain).loginEqualTo(login).findFirst();
      return email != null;
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<List<EmailMessageEntity>> getMessagesByEmail(String email) async {
    try {
      List<EmailMessageEntity> messages =
          await _isar.emailMessageEntitys.filter().emailEqualTo(email).isDeletedEqualTo(false).findAll();
      return messages;
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<List<EmailMessageEntity>> searchMessages(String email, String input) async {
    try {
      List<EmailMessageEntity> messages = await _isar.emailMessageEntitys
          .filter()
          .emailEqualTo(email)
          .and()
          .isDeletedEqualTo(false)
          .and()
          .group((q) => q.bodyContains(input, caseSensitive: false).or().fromContains(input, caseSensitive: false))
          .findAll();
      return messages;
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<bool> checkIfMessageExists(String email, int id) async {
    try {
      EmailMessageEntity? message =
          await _isar.emailMessageEntitys.filter().emailEqualTo(email).idEqualTo(id).findFirst();
      return message != null;
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<EmailMessageEntity> addMessage(EmailMessageEntity newMessage) async {
    try {
      int newId = await _isar.writeTxn(() async {
        int id = await _isar.emailMessageEntitys.put(newMessage);
        return id;
      });
      newMessage.isarId = newId;
      return newMessage;
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<EmailMessageEntity> updateDidRead(int id, {bool didRead = true}) async {
    try {
      EmailMessageEntity message = await _isar.writeTxn(() async {
        EmailMessageEntity? message = await _isar.emailMessageEntitys.get(id);
        if (message == null) throw Exception("Email message does not exist");
        message.didRead = didRead;
        await _isar.emailMessageEntitys.put(message);
        return message;
      });
      return message;
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<EmailMessageEntity> deleteSafelyMessage(int id) async {
    try {
      EmailMessageEntity message = await _isar.writeTxn(() async {
        EmailMessageEntity? message = await _isar.emailMessageEntitys.get(id);
        if (message == null) throw Exception("Email message does not exist");
        message.isDeleted = true;
        await _isar.emailMessageEntitys.put(message);
        return message;
      });
      return message;
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<List<EmailMessageEntity>> deleteSafelyAllMessages(String email) async {
    try {
      List<EmailMessageEntity> messages = await _isar.emailMessageEntitys.filter().emailEqualTo(email).findAll();

      for (EmailMessageEntity message in messages) {
        message.isDeleted = true;
      }
      await _isar.writeTxn(() async {
        await _isar.emailMessageEntitys.putAll(messages);
      });
      return messages;
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<void> cleanSafelyDeletedMessages(DateTime until) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.emailMessageEntitys.filter().dateLessThan(until).isDeletedEqualTo(true).deleteAll();
      });
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }
}

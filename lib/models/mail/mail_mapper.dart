import 'package:flicker_mail/api/local/database/temp_mail_api/entities/mailbox_db.dart';
import 'package:flicker_mail/api/network/temp_email_api/entities/attachment_ntw.dart';
import 'package:flicker_mail/api/network/temp_email_api/entities/mail_details_ntw.dart';
import 'package:flicker_mail/api/network/temp_email_api/entities/mail_ntw.dart';
import 'package:flicker_mail/api/network/temp_email_api/entities/mailbox_ntw.dart';
import 'package:flicker_mail/models/mail/mail_attachment.dart';
import 'package:flicker_mail/models/mail/mail_details.dart';
import 'package:flicker_mail/models/mail/mailbox.dart';

import 'mail.dart';

class MailMapper {
  Email mapMailboxDBToMailbox(MailboxDB mailboxDB) {
    return Email(
      login: mailboxDB.login,
      domain: mailboxDB.domain,
      isarId: mailboxDB.mailboxIsarId,
      generatedAt: mailboxDB.generatedAt,
    );
  }

  MailboxDB mapMailboxNTWToMailboxDB(MailboxNTW mailboxNTW) {
    return MailboxDB(
      login: mailboxNTW.login,
      domain: mailboxNTW.domain,
      generatedAt: mailboxNTW.generatedAt,
    );
  }

  MailboxDB mapMailboxToMailboxDB(Email mailbox) {
    return MailboxDB(
      login: mailbox.login,
      domain: mailbox.domain,
      generatedAt: mailbox.generatedAt,
    );
  }

  /// Network

  Mail mapMailNTWToMail(MailNTW mailNetworkEntity) {
    return Mail(
      id: mailNetworkEntity.id,
      from: mailNetworkEntity.from,
      subject: mailNetworkEntity.subject,
      date: mailNetworkEntity.date,
    );
  }

  List<Mail> mapMailNTWToMailList(List<MailNTW> mailNetworkEntityList) {
    List<Mail> result = [];

    for (MailNTW mailNetworkEntity in mailNetworkEntityList) {
      Mail mail = mapMailNTWToMail(mailNetworkEntity);
      result.add(mail);
    }

    return result;
  }

  MailDetails mapMailDetailsNTWToMailDetails(
    MailDetailsNTW mailDetailsNTW,
  ) {
    return MailDetails(
      id: mailDetailsNTW.id,
      date: mailDetailsNTW.date,
      attachments: mapAttachmentNTWToMailAttachmentList(
        mailDetailsNTW.attachments,
      ),
      body: mailDetailsNTW.body,
      from: mailDetailsNTW.from,
      htmlBody: mailDetailsNTW.htmlBody,
      subject: mailDetailsNTW.subject,
      textBody: mailDetailsNTW.textBody,
    );
  }

  MailAttachment mapAttachmentNTWToMailAttachment(
    AttachmentNTW attachmentNTW,
  ) {
    return MailAttachment(
      filename: attachmentNTW.filename,
      contentType: attachmentNTW.contentType,
      size: attachmentNTW.size,
    );
  }

  List<MailAttachment> mapAttachmentNTWToMailAttachmentList(
    List<AttachmentNTW> attachmentNTWList,
  ) {
    List<MailAttachment> result = [];

    for (AttachmentNTW attachmentNTW in attachmentNTWList) {
      MailAttachment mailAttachment = mapAttachmentNTWToMailAttachment(attachmentNTW);
      result.add(mailAttachment);
    }

    return result;
  }
}

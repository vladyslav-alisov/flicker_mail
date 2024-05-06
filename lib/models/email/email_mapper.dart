import 'package:flicker_mail/api/local/database/temp_mail_api/entities/mailbox_db.dart';
import 'package:flicker_mail/api/network/sec_mail_api/entities/attachment_dto.dart';
import 'package:flicker_mail/api/network/sec_mail_api/entities/mail_details_dto.dart';
import 'package:flicker_mail/api/network/sec_mail_api/entities/email_message_dto.dart';
import 'package:flicker_mail/api/network/sec_mail_api/entities/email_dto.dart';
import 'package:flicker_mail/models/mail/mail_attachment.dart';
import 'package:flicker_mail/models/mail/mail_details.dart';
import 'package:flicker_mail/models/email/email.dart';

import '../email_message/email_message.dart';

class MailMapper {
  MailboxDB mapEmailToDBEntity(Email email) {
    return MailboxDB(
      login: email.login,
      domain: email.domain,
      generatedAt: email.generatedAt,
      isActive: email.isActive,
      label: email.label,
    );
  }

  Email mapDBEntityToEmail(MailboxDB emailDB) {
    return Email(
      login: emailDB.login,
      domain: emailDB.domain,
      isarId: emailDB.isarId,
      generatedAt: emailDB.generatedAt,
      isActive: emailDB.isActive,
      label: emailDB.label,
    );
  }

  List<Email> mapDBEntityToEmailList(List<MailboxDB> emailsDB) {
    List<Email> result = [];

    for (MailboxDB emailDB in emailsDB) {
      Email email = mapDBEntityToEmail(emailDB);
      result.add(email);
    }

    return result;
  }

  MailboxDB mapNTWToDB(EmailDto emailNTW, {bool? isActive}) {
    return MailboxDB(
      login: emailNTW.login,
      domain: emailNTW.domain,
      generatedAt: emailNTW.generatedAt,
      isActive: isActive ?? true,
    );
  }

  MailDetails mapMailDetailsNTWToMailDetails(
    MailDetailsDto mailDetailsNTW,
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
    AttachmentDto attachmentNTW,
  ) {
    return MailAttachment(
      filename: attachmentNTW.filename,
      contentType: attachmentNTW.contentType,
      size: attachmentNTW.size,
    );
  }

  List<MailAttachment> mapAttachmentNTWToMailAttachmentList(
    List<AttachmentDto> attachmentNTWList,
  ) {
    List<MailAttachment> result = [];

    for (AttachmentDto attachmentNTW in attachmentNTWList) {
      MailAttachment mailAttachment = mapAttachmentNTWToMailAttachment(attachmentNTW);
      result.add(mailAttachment);
    }

    return result;
  }
}

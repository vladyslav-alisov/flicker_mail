import 'package:flicker_mail/api/network/temp_email_api/entities/attachment_network_entity.dart';
import 'package:flicker_mail/api/network/temp_email_api/entities/mail_details_network_entity.dart';
import 'package:flicker_mail/api/network/temp_email_api/entities/mail_network_entity.dart';
import 'package:flicker_mail/models/mail/mail_attachment.dart';
import 'package:flicker_mail/models/mail/mail_details.dart';

import 'mail.dart';

class MailMapper {
  Mail mapMailNetworkEntityToMail(MailNetworkEntity mailNetworkEntity) {
    return Mail(
      id: mailNetworkEntity.id,
      from: mailNetworkEntity.from,
      subject: mailNetworkEntity.subject,
      date: mailNetworkEntity.date,
    );
  }

  List<Mail> mapMailNetworkEntityToMailList(List<MailNetworkEntity> mailNetworkEntityList) {
    List<Mail> result = [];

    for (MailNetworkEntity mailNetworkEntity in mailNetworkEntityList) {
      Mail mail = mapMailNetworkEntityToMail(mailNetworkEntity);
      result.add(mail);
    }

    return result;
  }

  MailDetails mapMailDetailsNetworkEntityToMailDetails(
    MailDetailsNetworkEntity mailDetailsNetworkEntity,
  ) {
    return MailDetails(
      id: mailDetailsNetworkEntity.id,
      date: mailDetailsNetworkEntity.date,
      attachments: mapAttachmentNetworkDetailsToMailAttachmentList(mailDetailsNetworkEntity.attachments),
      body: mailDetailsNetworkEntity.body,
      from: mailDetailsNetworkEntity.from,
      htmlBody: mailDetailsNetworkEntity.htmlBody,
      subject: mailDetailsNetworkEntity.subject,
      textBody: mailDetailsNetworkEntity.textBody,
    );
  }

  MailAttachment mapAttachmentNetworkDetailsToMailAttachment(
    AttachmentNetworkEntity attachmentNetworkEntity,
  ) {
    return MailAttachment(
      filename: attachmentNetworkEntity.filename,
      contentType: attachmentNetworkEntity.contentType,
      size: attachmentNetworkEntity.size,
    );
  }

  List<MailAttachment> mapAttachmentNetworkDetailsToMailAttachmentList(
    List<AttachmentNetworkEntity> attachmentNetworkEntityList,
  ) {
    List<MailAttachment> result = [];

    for (AttachmentNetworkEntity attachmentNetworkEntity in attachmentNetworkEntityList) {
      MailAttachment mailAttachment = mapAttachmentNetworkDetailsToMailAttachment(attachmentNetworkEntity);
      result.add(mailAttachment);
    }

    return result;
  }
}

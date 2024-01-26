import 'package:flicker_mail/api/network/temp_email_api/entities/mail_details_network_entity.dart';
import 'package:flicker_mail/api/network/temp_email_api/entities/mail_network_entity.dart';
import 'package:flicker_mail/api/network/temp_email_api/temp_mail_network_service.dart';
import 'package:flicker_mail/models/mail/mail.dart';
import 'package:flicker_mail/models/mail/mail_details.dart';
import 'package:flicker_mail/models/mail/mail_mapper.dart';
import 'package:flicker_mail/models/mail/mailbox.dart';

class MailRepository {
  MailRepository(this._tempMailNetworkService);

  final TempMailNetworkService _tempMailNetworkService;
  final MailMapper _mailMapper = MailMapper();

  Future<Mailbox> getMailbox() async {
    String email = await _tempMailNetworkService.generateMailbox();
    return Mailbox.fromString(email);
  }

  Future<List<Mail>> getMails(Mailbox mailbox) async {
    List<MailNetworkEntity> result = await _tempMailNetworkService.getMails(
      mailbox.login,
      mailbox.domain,
    );
    List<Mail> mails = _mailMapper.mapMailNetworkEntityToMailList(result);
    return mails;
  }

  Future<MailDetails> getMailDetails(Mailbox mailbox, int mailId) async {
    MailDetailsNetworkEntity result = await _tempMailNetworkService.getMailDetails(
      mailbox.login,
      mailbox.domain,
      mailId,
    );
    MailDetails mails = _mailMapper.mapMailDetailsNetworkEntityToMailDetails(result);
    return mails;
  }
}

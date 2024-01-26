import 'package:flicker_mail/models/mail/mail.dart';
import 'package:flicker_mail/models/mail/mail_details.dart';
import 'package:flicker_mail/models/mail/mailbox.dart';
import 'package:flicker_mail/repositories/mail_repository.dart';
import 'package:flutter/cupertino.dart';

class MailProvider with ChangeNotifier {
  final MailRepository _mailRepository;

  MailProvider(this._mailRepository);

  Future<Mailbox> getMailbox() async {
    var mailbox = await _mailRepository.getMailbox();
    return mailbox;
  }

  Future<List<Mail>> getMails(Mailbox mailbox) async {
    var mails = await _mailRepository.getMails(mailbox);
    return mails;
  }

  Future<MailDetails> getMailDetails(Mailbox mailbox, int mailId) async {
    var mailDetails = await _mailRepository.getMailDetails(mailbox, mailId);
    return mailDetails;
  }
}

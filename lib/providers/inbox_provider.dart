import 'package:flicker_mail/models/mail/mail.dart';
import 'package:flicker_mail/models/mail/mail_details.dart';
import 'package:flicker_mail/models/mail/mailbox.dart';
import 'package:flicker_mail/repositories/mailbox_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class InboxProvider extends ChangeNotifier implements ReassembleHandler {
  InboxProvider(this._mailRepository);

  final TempMailRepository _mailRepository;
  late Email _mailbox;

  final List<Mail> _mailList = [];

  bool isInboxLoading = false;

  List<Mail> get mailList => _mailList;

  void update(Email mailbox) => _mailbox = mailbox;

  Future<List<Mail>> initInbox() async {
    List<Mail> mails = await _mailRepository.getMails(_mailbox);
    _mailList.clear();
    _mailList.addAll(mails);
    return mails;
  }

  Future<List<Mail>> refreshInbox() async {
    List<Mail> mails = await _mailRepository.getMails(_mailbox);
    _mailList.clear();
    _mailList.addAll(mails);
    notifyListeners();
    return mails;
  }

  Future<MailDetails> getMailDetails(int mailId) async {
    var mailDetails = await _mailRepository.getMailDetails(_mailbox, mailId);
    return mailDetails;
  }

  @override
  void reassemble() {
    print('Did hot-reload');
  }
}

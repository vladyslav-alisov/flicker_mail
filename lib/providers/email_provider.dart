import 'package:dio/dio.dart';
import 'package:flicker_mail/models/mail/mail.dart';
import 'package:flicker_mail/models/mail/mail_details.dart';
import 'package:flicker_mail/models/mail/mailbox.dart';
import 'package:flicker_mail/models/prov_response.dart';
import 'package:flicker_mail/repositories/temp_mail_repository.dart';
import 'package:flutter/cupertino.dart';

class EmailProvider with ChangeNotifier {
  EmailProvider(this._mailRepository);
  final TempMailRepository _mailRepository;

  late Email _selectedEmail;
  final List<Email> _inactiveEmails = [];
  final List<Mail> _mailList = [];

  Email get activeEmail => _selectedEmail;
  List<Email> get inactiveEmails => _inactiveEmails;
  List<Mail> get mailList => _mailList;

  Future<ProvResponse> checkHealth() async {
    try {
      await _mailRepository.checkHealth();
      return ProvResponse();
    } on DioException catch (e) {
      return ProvResponse(errorMsg: e.message ?? "Something went wrong");
    } catch (e) {
      return ProvResponse(errorMsg: e.toString());
    }
  }

  Future<ProvResponse<Email>> initEmail() async {
    try {
      Email mailbox = await _mailRepository.getActiveMailbox();
      _selectedEmail = mailbox;
      List<Email> emails = await _mailRepository.getInactiveEmails();
      _inactiveEmails.addAll(emails);
      List<Mail> mails = await _mailRepository.getMails(mailbox);
      _mailList.clear();
      _mailList.addAll(mails);
      return ProvResponse(data: mailbox);
    } on DioException catch (e) {
      return ProvResponse(errorMsg: e.message);
    } catch (e) {
      return ProvResponse(errorMsg: e.toString());
    }
  }

  Future<List<String>> getDomainList() async {
    List<String> domains = await _mailRepository.getDomainList();
    return domains;
  }

  Future<ProvResponse> saveNewEmail(String login, String domain) async {
    try {
      Email email = await _mailRepository.saveNewEmail(login, domain);
      Email deactivatedEmail = await _mailRepository.changeEmailIsActiveStatus(activeEmail.isarId, false);
      _selectedEmail = email;
      _inactiveEmails.add(deactivatedEmail);
      refreshInbox();
      notifyListeners();
      return ProvResponse(data: email);
    } on DioException catch (e) {
      return ProvResponse(errorMsg: e.message);
    } catch (e) {
      rethrow;
    }
  }

  Future<ProvResponse<(String login, String domain)>> generateRandomEmail() async {
    try {
      var data = await _mailRepository.generateRandomMailbox();
      return ProvResponse(data: data);
    } on DioException catch (e) {
      return ProvResponse(errorMsg: e.message);
    }
  }

  Future activateEmail(int dbId) async {
    int index = _inactiveEmails.indexWhere((element) => element.isarId == dbId);
    Email activatedEmail = await _mailRepository.changeEmailIsActiveStatus(dbId, true);
    Email deactivatedEmail = await _mailRepository.changeEmailIsActiveStatus(activeEmail.isarId, false);
    _selectedEmail = activatedEmail;
    _inactiveEmails[index] = deactivatedEmail;
    refreshInbox();
    notifyListeners();
  }

  Future<bool> removeEmail(int dbId) async {
    int index = _inactiveEmails.indexWhere((element) => element.isarId == dbId);
    Email tempEmail = _inactiveEmails[index];
    _inactiveEmails.removeAt(index);
    notifyListeners();
    bool isDeleted = await _mailRepository.deleteEmail(dbId);
    if (!isDeleted) {
      _inactiveEmails.insert(index, tempEmail);
      notifyListeners();
    }
    return isDeleted;
  }

  Future<List<Mail>> refreshInbox() async {
    List<Mail> mails = await _mailRepository.getMails(_selectedEmail);
    _mailList.clear();
    _mailList.addAll(mails);
    notifyListeners();
    return mails;
  }

  Future<MailDetails> getMailDetails(int mailId) async {
    var mailDetails = await _mailRepository.getMailDetails(_selectedEmail, mailId);
    return mailDetails;
  }

  Future<bool> checkIfEmailExist(String login, String domain) async {
    bool isExist = await _mailRepository.checkIfEmailExists(login, domain);
    return isExist;
  }
}

import 'package:dio/dio.dart';
import 'package:flicker_mail/models/email_message/email_message.dart';
import 'package:flicker_mail/models/email/email.dart';
import 'package:flicker_mail/models/prov_response.dart';
import 'package:flicker_mail/providers/disposable_provider.dart';
import 'package:flicker_mail/repositories/temp_mail_repository.dart';

class EmailProvider extends DisposableProvider {
  EmailProvider(this._emailRepository);

  final TempMailRepository _emailRepository;

  late Email _selectedEmail;
  final List<Email> _inactiveEmails = [];
  final List<EmailMessage> _inboxMessages = [];
  final List<String> _availableDomains = [];
  bool isInboxRefreshing = false;

  Email get activeEmail => _selectedEmail;

  List<Email> get inactiveEmails => _inactiveEmails;

  List<String> get availableDomains => _availableDomains;

  List<EmailMessage> get sortedMessages {
    List<EmailMessage> messages = List.from(_inboxMessages);
    messages.sort((a, b) => b.date.compareTo(a.date));
    return messages;
  }

  List<Email> get sortedByDateInactiveEmails {
    List<Email> emailList = List.from(_inactiveEmails);
    emailList.sort((a, b) => b.generatedAt.compareTo(a.generatedAt));
    return emailList;
  }

  int get unreadInboxMessages => _inboxMessages.where((element) => !element.didRead).length;

  Future<ProvResponse> checkHealth() async {
    try {
      await _emailRepository.checkHealth();
      return ProvResponse();
    } on DioException catch (e) {
      return ProvResponse(errorMsg: e.message ?? "Something went wrong");
    } catch (e) {
      return ProvResponse(errorMsg: e.toString());
    }
  }

  Future<ProvResponse<Email>> initEmail() async {
    try {
      Email email = await _emailRepository.getActiveEmail();
      _selectedEmail = email;
      List<Email> emails = await _emailRepository.getInactiveEmails();
      _inactiveEmails.addAll(emails);
      List<EmailMessage> messages = await _emailRepository.getEmailMessages(email);
      _inboxMessages
        ..clear()
        ..addAll(messages);
      List<String> availableDomains = await _emailRepository.getAvailableDomains();
      _availableDomains.addAll(availableDomains);
      return ProvResponse(data: email);
    } on DioException catch (e) {
      return ProvResponse(errorMsg: e.message);
    } catch (e) {
      return ProvResponse(errorMsg: e.toString());
    }
  }

  Future<List<String>> getDomainList() async {
    List<String> domains = await _emailRepository.getAvailableDomains();
    return domains;
  }

  Future<ProvResponse> saveNewEmail(
    String login,
    String domain,
    String label,
  ) async {
    try {
      Email email = await _emailRepository.saveNewEmail(login, domain, label);
      Email deactivatedEmail = await _emailRepository.changeEmailIsActiveStatus(activeEmail.isarId, false);
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
      var data = await _emailRepository.generateRandomEmail();
      return ProvResponse(data: data);
    } on DioException catch (e) {
      return ProvResponse(errorMsg: e.message);
    }
  }

  Future activateEmail(int dbId) async {
    int index = _inactiveEmails.indexWhere((element) => element.isarId == dbId);
    if (index == -1) throw Exception("Email not found");
    Email activatedEmail = await _emailRepository.changeEmailIsActiveStatus(dbId, true);
    Email deactivatedEmail = await _emailRepository.changeEmailIsActiveStatus(activeEmail.isarId, false);
    _selectedEmail = activatedEmail;
    _inactiveEmails[index] = deactivatedEmail;
    refreshInbox();
    notifyListeners();
  }

  Future changeEmailLabel(int dbId, String newLabel) async {
    if (dbId == _selectedEmail.isarId) {
      Email updatedEmail = await _emailRepository.changeEmailLabel(_selectedEmail.isarId, newLabel);
      _selectedEmail = updatedEmail;
    } else {
      int index = _inactiveEmails.indexWhere((element) => element.isarId == dbId);
      if (index == -1) throw Exception("Email not found");
      Email updatedEmail = await _emailRepository.changeEmailLabel(dbId, newLabel);
      _inactiveEmails[index] = updatedEmail;
    }

    notifyListeners();
  }

  Future<bool> deleteEmail(int dbId) async {
    int index = _inactiveEmails.indexWhere((element) => element.isarId == dbId);
    Email tempEmail = _inactiveEmails[index];
    _inactiveEmails.removeAt(index);
    notifyListeners();
    bool isDeleted = await _emailRepository.deleteEmail(dbId);
    if (!isDeleted) {
      _inactiveEmails.insert(index, tempEmail);
      notifyListeners();
    }
    return isDeleted;
  }

  Future<void> refreshInbox() async {
    if (isInboxRefreshing) return;
    isInboxRefreshing = true;
    try {
      List<EmailMessage> mails = await _emailRepository.getEmailMessages(_selectedEmail);
      _inboxMessages.clear();
      _inboxMessages.addAll(mails);
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      isInboxRefreshing = false;
    }
  }

  Future<bool> checkIfEmailExist(String login, String domain) async {
    bool isExist = await _emailRepository.checkIfEmailExists(login, domain);
    return isExist;
  }

  Future<EmailMessage> updateDidRead(int dbId) async {
    EmailMessage emailMessage = await _emailRepository.updateDidRead(dbId);
    int index = _inboxMessages.indexWhere((element) => element.dbId == dbId);
    _inboxMessages[index] = emailMessage;
    notifyListeners();
    return emailMessage;
  }

  Future<bool> deleteSafelyMessage(int dbId) async {
    int index = _inboxMessages.indexWhere((element) => element.dbId == dbId);
    EmailMessage tempEmailMessage = _inboxMessages[index];
    _inboxMessages.removeAt(index);
    notifyListeners();
    try {
      await _emailRepository.deleteSafelyMessage(dbId);
      return true;
    } catch (e) {
      _inboxMessages.insert(index, tempEmailMessage);
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteSafelyAllMessages() async {
    try {
      await _emailRepository.deleteSafelyAllMessages(_selectedEmail.email);
      _inboxMessages.clear();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<EmailMessage>> searchMessages(String input) async {
    return await _emailRepository.searchMessages(_selectedEmail, input);
  }

  @override
  void disposeValues() {
    _inactiveEmails.clear();
    _inboxMessages.clear();
    _availableDomains.clear();
    isInboxRefreshing = false;
  }
}

import 'package:dio/dio.dart';
import 'package:flicker_mail/models/mail/mailbox.dart';
import 'package:flicker_mail/models/prov_response.dart';
import 'package:flicker_mail/repositories/mailbox_repository.dart';
import 'package:flutter/cupertino.dart';

class EmailProvider with ChangeNotifier {
  EmailProvider(this._mailRepository);
  final TempMailRepository _mailRepository;

  Email? _selectedEmail;

  bool get hasEmail => _selectedEmail != null;
  Email get activeEmail => hasEmail ? _selectedEmail! : throw Exception("Mailbox is null");

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
      Email mailbox = await _mailRepository.getMailbox();
      _selectedEmail = mailbox;
      return ProvResponse(data: mailbox);
    } on DioException catch (e) {
      return ProvResponse(errorMsg: e.message);
    } catch (e) {
      print(e.toString());
      return ProvResponse(errorMsg: e.toString());
    }
  }

  Future<List<String>> getDomainList() async {
    List<String> domains = await _mailRepository.getDomainList();
    return domains;
  }

  Future<ProvResponse> setNewEmail(String login, String domain) async {
    try {
      Email email = await _mailRepository.saveNewEmail(login, domain);
      _selectedEmail = email;
      notifyListeners();
      return ProvResponse(data: email);
    } on DioException catch (e) {
      return ProvResponse(errorMsg: e.message);
    } catch (e) {
      rethrow;
    }
  }

  Future<ProvResponse<Email>> generateNewEmail() async {
    try {
      Email mailbox = await _mailRepository.generateNewMailbox();
      return ProvResponse(data: mailbox);
    } on DioException catch (e) {
      return ProvResponse(errorMsg: e.message);
    }
  }
}

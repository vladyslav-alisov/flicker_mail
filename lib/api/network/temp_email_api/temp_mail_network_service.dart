import 'package:flicker_mail/api/network/temp_email_api/entities/mail_details_ntw.dart';
import 'package:flicker_mail/api/network/temp_email_api/entities/mail_ntw.dart';
import 'package:flicker_mail/api/network/temp_email_api/entities/mailbox_ntw.dart';
import 'package:flicker_mail/api/network/temp_email_api/temp_mail_client.dart';

import 'json_keys.dart';

enum TempMailAction { genRandomMailbox, getDomainList, getMessages, readMessage }

class TempMailNetworkService {
  final TempMailClient _tempMailClient = TempMailClient.instance;

  Future<void> checkHealth() async {
    await _tempMailClient.dio.get("/");
  }

  Future<List<String>> getDomainList() async {
    Map<String, dynamic> params = {
      JsonKeys.action: TempMailAction.getDomainList.name,
    };
    var response = await _tempMailClient.dio.get("/", queryParameters: params);
    List<String> result = [];
    for (var i in response.data) {
      result.add(i as String);
    }
    return result;
  }

  Future<MailboxNTW> generateMailbox({int? count}) async {
    Map<String, dynamic> params = {
      JsonKeys.action: TempMailAction.genRandomMailbox.name,
    };

    if (count != null) params[JsonKeys.count] = count;
    var response = await _tempMailClient.dio.get("/", queryParameters: params);
    return MailboxNTW.fromString(((response.data as List<dynamic>).first as String));
  }

  Future<List<MailNTW>> getMails(String login, String domain) async {
    var response = await _tempMailClient.dio.get("/", queryParameters: {
      JsonKeys.action: TempMailAction.getMessages.name,
      JsonKeys.login: login,
      JsonKeys.domain: domain,
    });

    List<MailNTW> result = [];

    for (var e in response.data) {
      MailNTW message = MailNTW.fromJson(e);
      result.add(message);
    }

    return result;
  }

  Future<MailDetailsNTW> getMailDetails(String login, String domain, int mailId) async {
    var response = await _tempMailClient.dio.get("/", queryParameters: {
      JsonKeys.action: TempMailAction.readMessage.name,
      JsonKeys.login: login,
      JsonKeys.domain: domain,
      JsonKeys.id: mailId,
    });

    MailDetailsNTW result = MailDetailsNTW.fromJson(response.data);

    return result;
  }
}

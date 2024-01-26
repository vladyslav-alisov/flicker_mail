import 'package:flicker_mail/api/network/temp_email_api/entities/mail_details_network_entity.dart';
import 'package:flicker_mail/api/network/temp_email_api/entities/mail_network_entity.dart';
import 'package:flicker_mail/api/network/temp_email_api/temp_mail_client.dart';

import 'json_keys.dart';

enum TempMailAction { genRandomMailbox, getMessages, readMessage }

class TempMailNetworkService {
  final TempMailClient _tempMailClient = TempMailClient.instance;

  Future<String> generateMailbox({int? count}) async {
    Map<String, dynamic> params = {
      JsonKeys.action: TempMailAction.genRandomMailbox.name,
    };

    if (count != null) params[JsonKeys.count] = count;
    var response = await _tempMailClient.dio.get("/", queryParameters: params);
    return (response.data as List<dynamic>).first as String;
  }

  Future<List<MailNetworkEntity>> getMails(String login, String domain) async {
    var response = await _tempMailClient.dio.get("/", queryParameters: {
      JsonKeys.action: TempMailAction.getMessages.name,
      JsonKeys.login: login,
      JsonKeys.domain: domain,
    });

    List<MailNetworkEntity> result = [];

    for (var e in response.data) {
      MailNetworkEntity message = MailNetworkEntity.fromJson(e);
      result.add(message);
    }

    return result;
  }

  Future<MailDetailsNetworkEntity> getMailDetails(String login, String domain, int mailId) async {
    var response = await _tempMailClient.dio.get("/", queryParameters: {
      JsonKeys.action: TempMailAction.readMessage.name,
      JsonKeys.login: login,
      JsonKeys.domain: domain,
      JsonKeys.id: mailId,
    });

    MailDetailsNetworkEntity result = MailDetailsNetworkEntity.fromJson(response.data);

    return result;
  }
}

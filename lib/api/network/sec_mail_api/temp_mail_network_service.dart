import 'package:flicker_mail/api/network/sec_mail_api/entities/mail_details_dto.dart';
import 'package:flicker_mail/api/network/sec_mail_api/entities/email_message_dto.dart';
import 'package:flicker_mail/api/network/sec_mail_api/entities/email_dto.dart';
import 'package:flicker_mail/api/network/sec_mail_api/temp_mail_client.dart';

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

  Future<EmailDto> generateMailbox({int? count}) async {
    Map<String, dynamic> params = {
      JsonKeys.action: TempMailAction.genRandomMailbox.name,
    };

    if (count != null) params[JsonKeys.count] = count;
    var response = await _tempMailClient.dio.get("/", queryParameters: params);
    return EmailDto.fromString(((response.data as List<dynamic>).first as String));
  }

  Future<List<EmailMessageDto>> getMails(String login, String domain) async {
    var response = await _tempMailClient.dio.get("/", queryParameters: {
      JsonKeys.action: TempMailAction.getMessages.name,
      JsonKeys.login: login,
      JsonKeys.domain: domain,
    });

    List<EmailMessageDto> result = [];

    for (var e in response.data) {
      EmailMessageDto message = EmailMessageDto.fromJson(e);
      result.add(message);
    }

    return result;
  }

  Future<MailDetailsDto> getMailDetails(String login, String domain, int mailId) async {
    var response = await _tempMailClient.dio.get("/", queryParameters: {
      JsonKeys.action: TempMailAction.readMessage.name,
      JsonKeys.login: login,
      JsonKeys.domain: domain,
      JsonKeys.id: mailId,
    });

    MailDetailsDto result = MailDetailsDto.fromJson(response.data);

    return result;
  }
}
import 'package:dio/dio.dart';
import 'package:flicker_mail/core/error/exceptions.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_remote_data_source/dto/email_dto.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_remote_data_source/dto/email_message_dto.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_remote_data_source/dto/mail_details_dto.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_remote_data_source/json_keys.dart';

abstract interface class TempMailRemoteDataSource {
  Future<void> checkHealth();

  Future<List<String>> getDomainList();

  Future<EmailDto> generateMailbox({int? count});

  Future<List<EmailMessageDto>> getMails(String login, String domain);

  Future<MessageDetailsDto> getMailDetails(String login, String domain, int messageId);

  Future<String> getAttachment(String login, String domain, int messageId, String fileName, String filePath);
}

enum TempMailAction { genRandomMailbox, getDomainList, getMessages, readMessage, download }

class TempMailDioImpl implements TempMailRemoteDataSource {
  final Dio _dio;

  TempMailDioImpl({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<void> checkHealth() async {
    try {
      await _dio.get("/");
    } on DioException catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<String>> getDomainList() async {
    try {
      Map<String, dynamic> params = {
        JsonKeys.action: TempMailAction.getDomainList.name,
      };
      var response = await _dio.get("/", queryParameters: params);
      List<String> result = [];
      for (var i in response.data) {
        result.add(i as String);
      }
      return result;
    } on DioException catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<EmailDto> generateMailbox({int? count}) async {
    try {
      Map<String, dynamic> params = {
        JsonKeys.action: TempMailAction.genRandomMailbox.name,
      };

      if (count != null) params[JsonKeys.count] = count;
      var response = await _dio.get("/", queryParameters: params);
      return EmailDto.fromString(((response.data as List<dynamic>).first as String));
    } on DioException catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<EmailMessageDto>> getMails(String login, String domain) async {
    try {
      var response = await _dio.get("/", queryParameters: {
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
    } on DioException catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<MessageDetailsDto> getMailDetails(String login, String domain, int messageId) async {
    try {
      var response = await _dio.get(
        "/",
        queryParameters: {
          JsonKeys.action: TempMailAction.readMessage.name,
          JsonKeys.login: login,
          JsonKeys.domain: domain,
          JsonKeys.id: messageId,
        },
      );

      MessageDetailsDto result = MessageDetailsDto.fromJson(response.data);
      return result;
    } on DioException catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> getAttachment(String login, String domain, int messageId, String fileName, String filePath) async {
    try {
      await _dio.download(
        "/",
        filePath,
        queryParameters: {
          JsonKeys.action: TempMailAction.download.name,
          JsonKeys.login: login,
          JsonKeys.domain: domain,
          JsonKeys.id: messageId,
          JsonKeys.file: fileName,
        },
      );
      return filePath;
    } on DioException catch (e) {
      throw ServerException(e.toString());
    }
  }
}

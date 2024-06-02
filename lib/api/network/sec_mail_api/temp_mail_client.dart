import 'package:dio/dio.dart';
import 'package:flicker_mail/utils/app_env.dart';

class TempMailClient {
  TempMailClient._();
  static final TempMailClient instance = TempMailClient._();

  static const Duration _connectTimeout = Duration(seconds: 25);
  static final AppEnv _appConfig = AppEnv.instance;

  Dio get dio => _dio;

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _connectTimeout,
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
      },
      baseUrl: _appConfig.tempEmailBaseUrl,
    ),
  );
}

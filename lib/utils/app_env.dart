import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  static AppEnv? _instance;

  static AppEnv get instance =>
      _instance != null ? _instance! : throw Exception("AppConfig must be initialized first!");

  AppEnv._({
    required this.tempEmailBaseUrl,
    required this.sentryDNS,
  });

  final String tempEmailBaseUrl;
  final String sentryDNS;

  static Future<AppEnv> init() async {
    await dotenv.load(fileName: ".env");

    _instance ??= AppEnv._(
      tempEmailBaseUrl: dotenv.env['TEMP_EMAIL_BASE_URL'] ?? "",
      sentryDNS: dotenv.env['SENTRY_DSN'] ?? "",
    );
    return _instance!;
  }
}

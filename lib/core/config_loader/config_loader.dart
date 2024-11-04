import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvVariable {
  tempEmailBaseUrl('TEMP_EMAIL_BASE_URL'),
  sentryDNS('SENTRY_DSN'),
  adUnitIdAndroid('AD_UNIT_ID_ANDROID'),
  adUnitIdIOS('AD_UNIT_ID_IOS'),
  feedbackEmail('FEEDBACK_EMAIL');

  const EnvVariable(this.key);

  final String key;
}

abstract class ConfigLoader {
  Future<void> load();

  String? get(String key);
}

class DotenvConfigLoaderImpl implements ConfigLoader {
  final String fileName;

  DotenvConfigLoaderImpl(this.fileName);

  @override
  Future<void> load() async {
    await dotenv.load(fileName: fileName);
  }

  @override
  String? get(String key) => dotenv.env[key];
}

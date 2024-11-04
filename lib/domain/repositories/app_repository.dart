import 'package:flicker_mail/domain/models/app_config.dart';
import 'package:flicker_mail/domain/models/app_info.dart';

abstract interface class AppRepository {
  Future<AppConfig> getAppConfig();

  Future<AppConfig> updateAppConfig(AppConfig appConfig);

  Future<AppInfo> getAppInfo();

  Future<void> clearCachedData();
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flicker_mail/api/local/database/app_config_api/app_config_db_service.dart';
import 'package:flicker_mail/api/local/database/app_info_api/app_info_db_service.dart';
import 'package:flicker_mail/api/local/database/database_client.dart';
import 'package:flicker_mail/api/local/storage/storage_client.dart';
import 'package:flicker_mail/models/app_config/app_config.dart';
import 'package:flicker_mail/models/app_info/app_info.dart';
import 'package:flicker_mail/repositories/app_repository.dart';
import 'package:flicker_mail/utils/app_env.dart';
import 'view/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await StorageClient.initLocalStorage();
  await DatabaseClient.initLocalDatabase();
  AppEnv.init(tempEmailBaseUrl: dotenv.env['TEMP_EMAIL_BASE_URL'] ?? "");
  final AppRepository appRepository = AppRepository(AppConfigDBService(), AppInfoDBService());

  AppConfig initAppConfig = await appRepository.getAppConfig();
  AppInfo appInfo = await appRepository.getAppInfo();

  runApp(MyApp(initConfig: initAppConfig, appRepository: appRepository, appInfo: appInfo));
}

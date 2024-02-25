import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flicker_mail/api/local/database/app_config_api/app_config_db_entity.dart';
import 'package:flicker_mail/api/local/database/app_config_api/app_config_db_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flicker_mail/api/local/database/app_info_api/app_info_db_entity.dart';
import 'package:flicker_mail/api/local/database/app_info_api/app_info_db_service.dart';
import 'package:flicker_mail/models/app_config/app_config.dart';
import 'package:flicker_mail/models/app_config/app_config_mapper.dart';
import 'package:flicker_mail/models/app_info/index.dart';

class AppRepository {
  AppRepository(this._appConfigDBService, this._appInfoDBService);

  final AppConfigDBService _appConfigDBService;
  final AppInfoDBService _appInfoDBService;

  Future<AppConfig> getAppConfig() async {
    AppConfigDBEntity? appConfigDBEntity = await _appConfigDBService.getAppConfig();
    if (appConfigDBEntity != null) {
      return AppConfigMapper.fromAppConfigDBEntityToAppConfig(appConfigDBEntity);
    } else {
      Locale initLocale = _getInitLocale();
      ThemeMode themeMode = ThemeMode.system;
      AppConfig newAppConfig = AppConfig(true, initLocale, themeMode);
      AppConfig updatedAppConfig = await updateAppConfig(newAppConfig);
      return updatedAppConfig;
    }
  }

  /// Checks system prefs, if not supported, returns default app's Locale
  Locale _getInitLocale() {
    final String systemLang = Platform.localeName;
    Locale systemLocale = Locale(systemLang.split("_").first);
    bool isSupported = AppLocalizations.delegate.isSupported(systemLocale);
    return isSupported ? systemLocale : AppLocalizations.supportedLocales.first;
  }

  Future<AppConfig> updateAppConfig(AppConfig appConfig) async {
    AppConfigDBEntity appConfigDBEntity = AppConfigMapper.fromAppConfigToAppConfigDBEntity(appConfig);
    await _appConfigDBService.deleteAllConfigEntity();
    await _appConfigDBService.saveAppConfig(appConfigDBEntity);
    return appConfig;
  }

  Future<AppInfo> getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    AppInfoDBEntity? appVersion = await _appInfoDBService.getAppInfo();
    if (appVersion != null && appVersion.version == packageInfo.version) {
      AppInfo saveAppInfo = AppInfoMapper.fromAppInfoDBEntityToAppInfo(appVersion);
      return saveAppInfo;
    } else {
      AppInfo updatedAppInfo = AppInfoMapper.fromPackageInfoToAppInfo(packageInfo, DateTime.now());
      AppInfoDBEntity updatedAppInfoDBEntity = AppInfoMapper.fromAppInfoToAppInfoDBEntity(updatedAppInfo);
      if (appVersion != null) await _appInfoDBService.deleteAllConfigEntity();
      await _appInfoDBService.saveAppInfo(updatedAppInfoDBEntity);
      return updatedAppInfo;
    }
  }
}

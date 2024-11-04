import 'dart:io';

import 'package:flicker_mail/data/data_sources/app_internals_local_data_source/app_internals_local_data_source.dart';
import 'package:flicker_mail/data/data_sources/app_internals_local_data_source/entities/app_config_db_entity.dart';
import 'package:flicker_mail/data/data_sources/app_internals_local_data_source/entities/app_info_db_entity.dart';
import 'package:flicker_mail/data/models/app_config_model.dart';
import 'package:flicker_mail/data/models/app_info_model.dart';
import 'package:flicker_mail/domain/models/app_config.dart';
import 'package:flicker_mail/domain/models/app_info.dart';
import 'package:flicker_mail/domain/repositories/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppRepositoryImpl implements AppRepository {
  AppRepositoryImpl({required AppInternalsLocalDataSource appInternalsLocalDataSource})
      : _appInternalsLocalDataSource = appInternalsLocalDataSource;

  final AppInternalsLocalDataSource _appInternalsLocalDataSource;

  @override
  Future<AppConfig> getAppConfig() async {
    AppConfigEntity? appConfigDBEntity = await _appInternalsLocalDataSource.getAppConfig();
    if (appConfigDBEntity != null) {
      return AppConfigModel.fromEntity(appConfigDBEntity);
    } else {
      Locale initLocale = _getInitLocale();
      ThemeMode themeMode = ThemeMode.system;
      AppConfig newAppConfig = AppConfig(isFirstLaunch: true, locale: initLocale, themeMode: themeMode);
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

  @override
  Future<AppConfig> updateAppConfig(AppConfig appConfig) async {
    AppConfigEntity appConfigDBEntity = AppConfigModel.fromAppConfig(appConfig).toEntity();
    await _appInternalsLocalDataSource.deleteAllConfigEntity();
    await _appInternalsLocalDataSource.saveAppConfig(appConfigDBEntity);
    return appConfig;
  }

  @override
  Future<AppInfo> getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    AppInfoEntity? appVersion = await _appInternalsLocalDataSource.getAppInfo();
    if (appVersion != null && appVersion.version == packageInfo.version) {
      AppInfo saveAppInfo = AppInfoModel.fromEntity(appVersion);
      return saveAppInfo;
    } else {
      AppInfo updatedAppInfo = AppInfoModel.fromPackageInfo(packageInfo);
      AppInfoEntity updatedAppInfoDBEntity = AppInfoModel.fromAppInfo(updatedAppInfo).toEntity();
      if (appVersion != null) await _appInternalsLocalDataSource.deleteAllInfoEntity();
      await _appInternalsLocalDataSource.saveAppInfo(updatedAppInfoDBEntity);
      return updatedAppInfo;
    }
  }

  @override
  Future<void> clearCachedData() async {
    await _appInternalsLocalDataSource.clearDatabase();
  }
}

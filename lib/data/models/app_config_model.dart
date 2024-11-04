import 'package:flicker_mail/data/data_sources/app_internals_local_data_source/entities/app_config_db_entity.dart';
import 'package:flicker_mail/domain/models/app_config.dart';
import 'package:flutter/material.dart';

class AppConfigModel extends AppConfig {
  AppConfigModel({
    required super.isFirstLaunch,
    required super.locale,
    required super.themeMode,
  });

  factory AppConfigModel.fromEntity(AppConfigEntity appConfigEntity) {
    Locale locale = Locale(appConfigEntity.languageCode, appConfigEntity.countryCode);
    return AppConfigModel(
      isFirstLaunch: appConfigEntity.isFirstLaunch,
      locale: locale,
      themeMode: appConfigEntity.themeMode,
    );
  }

  factory AppConfigModel.fromAppConfig(AppConfig appConfig) {
    return AppConfigModel(
      isFirstLaunch: appConfig.isFirstLaunch,
      locale: appConfig.locale,
      themeMode: appConfig.themeMode,
    );
  }

  AppConfigEntity toEntity() {
    return AppConfigEntity(
      locale.languageCode,
      locale.countryCode,
      isFirstLaunch,
      themeMode,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flicker_mail/api/local/database/app_config_api/app_config_db_entity.dart';
import 'package:flicker_mail/models/app_config/app_config.dart';

class AppConfigMapper {
  static AppConfigDBEntity mapModelToEntity(AppConfig model) {
    return AppConfigDBEntity(model.locale.languageCode, model.locale.countryCode, model.isFirstLaunch, model.themeMode);
  }

  static AppConfig mapEntityToModel(AppConfigDBEntity entity) {
    Locale locale = Locale(entity.languageCode, entity.countryCode);
    return AppConfig(entity.isFirstLaunch, locale, entity.themeMode);
  }
}

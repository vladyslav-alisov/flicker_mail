import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'app_config_db_entity.g.dart';

@collection
class AppConfigEntity {
  final Id localeId = Isar.autoIncrement;
  final String languageCode;
  final String? countryCode;
  final bool isFirstLaunch;
  @enumerated
  final ThemeMode themeMode;

  AppConfigEntity(
    this.languageCode,
    this.countryCode,
    this.isFirstLaunch,
    this.themeMode,
  );
}

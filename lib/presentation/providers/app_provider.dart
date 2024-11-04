import 'package:flicker_mail/domain/models/app_config.dart';
import 'package:flicker_mail/domain/models/app_info.dart';
import 'package:flicker_mail/domain/repositories/app_repository.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  AppProvider({
    required AppConfig appConfig,
    required AppInfo appInfo,
    required AppRepository appRepository,
  })  : _appRepository = appRepository,
        _appConfig = appConfig,
        _appInfo = appInfo;

  final AppRepository _appRepository;

  AppConfig _appConfig;

  final AppInfo _appInfo;

  Locale get appLocale => _appConfig.locale;

  bool get isFirstLaunch => _appConfig.isFirstLaunch;

  ThemeMode get themeMode => _appConfig.themeMode;

  AppInfo get appInfo => _appInfo;

  Future<void> saveLocaleConfig(Locale locale) async {
    AppConfig newAppConfig = _appConfig.copyWith(locale: locale);
    AppConfig updatedAppConfig = await _appRepository.updateAppConfig(newAppConfig);
    _appConfig = updatedAppConfig;
    notifyListeners();
  }

  Future<void> saveIsDarkThemeConfig(ThemeMode themeMode) async {
    AppConfig newAppConfig = _appConfig.copyWith(themeMode: themeMode);
    AppConfig updatedAppConfig = await _appRepository.updateAppConfig(newAppConfig);
    _appConfig = updatedAppConfig;
    notifyListeners();
  }

  Future<void> saveFirstLaunchConfig(bool isFirstLaunch) async {
    AppConfig newAppConfig = _appConfig.copyWith(isFirstLaunch: isFirstLaunch);
    AppConfig updatedAppConfig = await _appRepository.updateAppConfig(newAppConfig);
    _appConfig = updatedAppConfig;
  }
}

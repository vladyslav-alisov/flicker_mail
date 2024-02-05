import 'package:flutter/material.dart';
import 'package:flicker_mail/models/app_config/app_config.dart';
import 'package:flicker_mail/models/app_info/app_info.dart';
import 'package:flicker_mail/repositories/app_repository.dart';

class AppProvider with ChangeNotifier {
  AppProvider(this._appConfig, this._appInfo, this._appRepository);

  final AppRepository _appRepository;

  AppConfig _appConfig;

  Locale get appLocale => _appConfig.locale;
  bool get isFirstLaunch => _appConfig.isFirstLaunch;
  ThemeMode get themeMode => _appConfig.themeMode;

  final AppInfo _appInfo;

  AppInfo get appInfo => _appInfo;

  void setLocale(Locale locale) {
    AppConfig newAppConfig = AppConfig(_appConfig.isFirstLaunch, locale, _appConfig.themeMode);
    _appConfig = newAppConfig;
    notifyListeners();
  }

  Future<void> saveAppConfig({Locale? locale, bool? isFirstLaunch, ThemeMode? themeMode}) async {
    AppConfig newAppConfig = AppConfig(
      isFirstLaunch ?? _appConfig.isFirstLaunch,
      locale ?? _appConfig.locale,
      themeMode ?? _appConfig.themeMode,
    );
    AppConfig updatedAppConfig = await _appRepository.updateAppConfig(newAppConfig);
    _appConfig = updatedAppConfig;
    notifyListeners();
  }

  Future<void> saveLocaleConfig(Locale locale) async {
    AppConfig newAppConfig = AppConfig(_appConfig.isFirstLaunch, locale, _appConfig.themeMode);
    AppConfig updatedAppConfig = await _appRepository.updateAppConfig(newAppConfig);
    _appConfig = updatedAppConfig;
    notifyListeners();
  }

  Future<void> saveIsDarkThemeConfig(ThemeMode themeMode) async {
    AppConfig newAppConfig = AppConfig(_appConfig.isFirstLaunch, _appConfig.locale, themeMode);
    AppConfig updatedAppConfig = await _appRepository.updateAppConfig(newAppConfig);
    _appConfig = updatedAppConfig;
    notifyListeners();
  }

  Future<void> saveFirstLaunchConfig(bool isFirstLaunch) async {
    AppConfig newAppConfig = AppConfig(isFirstLaunch, _appConfig.locale, _appConfig.themeMode);
    AppConfig updatedAppConfig = await _appRepository.updateAppConfig(newAppConfig);
    _appConfig = updatedAppConfig;
  }
}

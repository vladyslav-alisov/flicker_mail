import 'package:flutter/material.dart';

class AppConfig {
  final bool isFirstLaunch;
  final Locale locale;
  final ThemeMode themeMode;

  AppConfig({
    required this.isFirstLaunch,
    required this.locale,
    required this.themeMode,
  });

  AppConfig copyWith({
    bool? isFirstLaunch,
    Locale? locale,
    ThemeMode? themeMode,
  }) {
    return AppConfig(
      isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension TranslateExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

const Map<String, String> codeToName = {
  "en": "English",
  "es": "Español",
  "ru": "Русский",
  "tr": "Türkçe",
};

extension FullName on Locale {
  String fullName() {
    return codeToName[languageCode] ?? "Unknown language";
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/providers/app_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<Locale> _supportedLocales = [];
  bool _isLoading = false;

  AppProvider get _appProvider => context.read<AppProvider>();

  @override
  void initState() {
    _supportedLocales.addAll(AppLocalizations.supportedLocales);
    super.initState();
  }

  _onThemeModePress(ThemeMode newValue) async {
    if (_isLoading) return;
    _isLoading = true;
    try {
      await _appProvider.saveIsDarkThemeConfig(newValue);
    } catch (e) {
      if (mounted) showDialog(context: context, builder: (context) => AlertDialog(content: Text(e.toString())));
    } finally {
      _isLoading = false;
    }
  }

  _onLanguageSelect(Locale newValue) async {
    if (_isLoading) return;
    _isLoading = true;
    try {
      await _appProvider.saveLocaleConfig(newValue);
    } catch (e) {
      if (mounted) showDialog(context: context, builder: (context) => AlertDialog(content: Text(e.toString())));
    } finally {
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<AppProvider>(
              builder: (BuildContext context, AppProvider value, Widget? child) => Column(
                children: [
                  ...List.generate(
                    ThemeMode.values.length,
                    (index) => ChoiceChip(
                      label: Text(ThemeMode.values[index].name),
                      onSelected: (value) => _onThemeModePress(ThemeMode.values[index]),
                      selected: ThemeMode.values[index] == value.themeMode,
                    ),
                  ),
                  ...List.generate(
                    _supportedLocales.length,
                    (index) => ChoiceChip(
                      label: Text(_supportedLocales[index].languageCode),
                      onSelected: (value) => _onLanguageSelect(_supportedLocales[index]),
                      selected: _supportedLocales[index].languageCode == value.appLocale.languageCode,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              context.l10n.hello("stranger"),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              "appName: ${_appProvider.appInfo.appName}\n"
              "packageName: ${_appProvider.appInfo.packageName}\n"
              "version: ${_appProvider.appInfo.version}\n"
              "buildNumber: ${_appProvider.appInfo.buildNumber}\n"
              "buildSignature: ${_appProvider.appInfo.buildSignature}\n"
              "lastUpdated: ${_appProvider.appInfo.lastUpdated}\n",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

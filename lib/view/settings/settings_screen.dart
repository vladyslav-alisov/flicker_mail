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
  Map<ThemeMode, String> get _themeModes => {
        ThemeMode.system: context.l10n.system,
        ThemeMode.dark: context.l10n.dark,
        ThemeMode.light: context.l10n.light,
      };

  late Locale _selectedLocale;
  late ThemeMode _selectedThemeMode;
  bool _isLoading = false;

  AppProvider get _appProvider => context.read<AppProvider>();

  @override
  void initState() {
    _selectedLocale = _appProvider.appLocale;
    _supportedLocales.addAll(AppLocalizations.supportedLocales);
    _selectedThemeMode = _appProvider.themeMode;

    super.initState();
  }

  _onThemeModePress(ThemeMode newValue) async {
    if (_isLoading) return;
    _isLoading = true;
    try {
      _selectedThemeMode = newValue;
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
      _selectedLocale = newValue;
      await _appProvider.saveLocaleConfig(newValue);
    } catch (e) {
      if (mounted) showDialog(context: context, builder: (context) => AlertDialog(content: Text(e.toString())));
    } finally {
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Text(
              context.l10n.settings,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            ExpansionTile(
              title: Text(context.l10n.language),
              subtitle: Text(_selectedLocale.fullName()),
              children: List.generate(
                _supportedLocales.length,
                (index) => CheckboxListTile(
                  title: Text(_supportedLocales[index].fullName()),
                  value: _supportedLocales[index].languageCode == _selectedLocale.languageCode,
                  onChanged: (val) => _onLanguageSelect(
                    _supportedLocales[index],
                  ),
                ),
              ),
            ),
            ExpansionTile(
              title: Text(context.l10n.theme),
              subtitle: Text(_themeModes[_selectedThemeMode] ?? ""),
              children: List.generate(
                _themeModes.length,
                (index) => CheckboxListTile(
                  title: Text(_themeModes.values.toList()[index]),
                  value: _themeModes.keys.toList()[index] == _selectedThemeMode,
                  onChanged: (val) => _onThemeModePress(
                    _themeModes.keys.toList()[index],
                  ),
                ),
              ),
            ),
          ],
        ),
        // body: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       Consumer<AppProvider>(
        //         builder: (BuildContext context, AppProvider value, Widget? child) => Column(
        //           children: [
        //             ...List.generate(
        //               ThemeMode.values.length,
        //               (index) => ChoiceChip(
        //                 label: Text(ThemeMode.values[index].name),
        //                 onSelected: (value) => _onThemeModePress(ThemeMode.values[index]),
        //                 selected: ThemeMode.values[index] == value.themeMode,
        //               ),
        //             ),
        //             ...List.generate(
        //               _supportedLocales.length,
        //               (index) => ChoiceChip(
        //                 label: Text(_supportedLocales[index].languageCode),
        //                 onSelected: (value) => _onLanguageSelect(_supportedLocales[index]),
        //                 selected: _supportedLocales[index].languageCode == value.appLocale.languageCode,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Text(
        //         context.l10n.hello("stranger"),
        //         style: Theme.of(context).textTheme.headlineMedium,
        //       ),
        //       Text(
        //         "appName: ${_appProvider.appInfo.appName}\n"
        //         "packageName: ${_appProvider.appInfo.packageName}\n"
        //         "version: ${_appProvider.appInfo.version}\n"
        //         "buildNumber: ${_appProvider.appInfo.buildNumber}\n"
        //         "buildSignature: ${_appProvider.appInfo.buildSignature}\n"
        //         "lastUpdated: ${_appProvider.appInfo.lastUpdated}\n",
        //         style: Theme.of(context).textTheme.bodySmall,
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

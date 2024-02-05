import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_app_review/in_app_review.dart';
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
  Map<ThemeMode, String> get _themeModeListToTitle => {
        ThemeMode.system: context.l10n.system,
        ThemeMode.dark: context.l10n.dark,
        ThemeMode.light: context.l10n.light,
      };

  List<ThemeMode> get _themeModeList => _themeModeListToTitle.keys.toList();

  late Locale _selectedLocale;
  late ThemeMode _selectedThemeMode;
  bool _isLoading = false;

  AppProvider get _appProvider => context.read<AppProvider>();

  final InAppReview inAppReview = InAppReview.instance;

  @override
  void initState() {
    _selectedLocale = _appProvider.appLocale;
    _selectedThemeMode = _appProvider.themeMode;
    _supportedLocales.addAll(AppLocalizations.supportedLocales);

    super.initState();
  }

  _onThemeModePress(ThemeMode newValue) async {
    if (_isLoading) return;
    _isLoading = true;
    try {
      setState(() => _selectedThemeMode = newValue);
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

  _onAboutPress() {
    showAboutDialog(
      context: context,
      applicationName: _appProvider.appInfo.appName,
      applicationVersion: _appProvider.appInfo.version,
      children: [
        const Text(
          "Your go-to mobile app for hassle-free, temporary email solutions! Protect your privacy and stay spam-free with our user-friendly app that generates instant, disposable email addresses. Perfect for signing up for services, avoiding unwanted solicitations, and safeguarding your primary inbox. Download MailGuard Free now and experience the convenience of temporary emails at your fingertips – no strings attached!",
        )
      ],
      applicationIcon: SizedBox(
        width: 50,
        height: 50,
        child: Image.asset("assets/images/logo_v1.png"),
      ),
    );
  }

  _onInAppReview() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.settings,
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
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
            subtitle: Text(_themeModeListToTitle[_selectedThemeMode] ?? ""),
            children: List.generate(
              _themeModeListToTitle.length,
              (index) => CheckboxListTile(
                title: Text(_themeModeListToTitle.values.toList()[index]),
                value: _themeModeList[index] == _selectedThemeMode,
                onChanged: (val) => _onThemeModePress(
                  _themeModeList[index],
                ),
              ),
            ),
          ),
          ListTile(
            onTap: _onInAppReview,
            title: Text("Rate us"),
          ),
          ListTile(
            onTap: _onAboutPress,
            title: Text("About"),
          ),
        ],
      ),
    );
  }
}

import 'package:flicker_mail/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
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
        Text(
          context.l10n.aboutText,
        )
      ],
      applicationIcon: SizedBox(
        width: 50,
        height: 50,
        child: Image.asset("assets/images/logo_v1.png"),
      ),
    );
  }

  _onInAppReviewPress() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  _onPrivacyPolicyPress() async {
    context.push(AppRoutes.privacyPolicyScreen.path);
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
            leading: const Icon(Icons.language_outlined),
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
            leading: const Icon(Icons.color_lens_outlined),
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
            leading: const Icon(Icons.info_outline),
            onTap: _onAboutPress,
            title: Text(
              context.l10n.about,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.rate_review_outlined),
            onTap: _onInAppReviewPress,
            title: Text(
              context.l10n.rateUs,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            onTap: _onPrivacyPolicyPress,
            title: Text(
              context.l10n.privacyPolicy,
            ),
          ),
        ],
      ),
    );
  }
}

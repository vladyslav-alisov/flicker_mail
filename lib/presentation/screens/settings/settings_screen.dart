import 'dart:io';

import 'package:flicker_mail/core/config_loader/config_loader.dart';
import 'package:flicker_mail/core/const_gen/assets.gen.dart';
import 'package:flicker_mail/core/l10n/translate_extension.dart';
import 'package:flicker_mail/core/router/app_routes.dart';
import 'package:flicker_mail/domain/models/app_info.dart';
import 'package:flicker_mail/domain/repositories/app_repository.dart';
import 'package:flicker_mail/init_dependencies.dart';
import 'package:flicker_mail/presentation/providers/app_provider.dart';
import 'package:flicker_mail/presentation/providers/disposable_provider.dart';
import 'package:flicker_mail/presentation/screens/widgets/error_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<Locale> _supportedLocales = [];

  static const String appStoreUrl = "https://apps.apple.com/tr/app/flickermail/id6476929326";
  static const String playMarketUrl = "https://play.google.com/store/apps/details?id=com.flickermail.app";

  Map<ThemeMode, String> get _themeModeListToTitle => {
        ThemeMode.system: context.l10n.system,
        ThemeMode.dark: context.l10n.dark,
        ThemeMode.light: context.l10n.light,
      };

  List<ThemeMode> get _themeModeList => _themeModeListToTitle.keys.toList();

  late Locale _selectedLocale;
  late ThemeMode _selectedThemeMode;
  bool _isLoading = false;
  bool _isFeedbackLoading = false;
  bool _isShareLoading = false;

  AppProvider get _appProvider => context.read<AppProvider>();

  @override
  void initState() {
    super.initState();
    _selectedLocale = _appProvider.appLocale;
    _selectedThemeMode = _appProvider.themeMode;
    _supportedLocales.addAll(AppLocalizations.supportedLocales);
  }

  void _onThemeModePress(ThemeMode newValue) async {
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

  void _onLanguageSelect(Locale newValue) async {
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

  void _onAboutPress() {
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
        width: 70,
        height: 70,
        child: Image.asset(Assets.images.logoTb.path),
      ),
    );
  }

  void _onFeedbackPress() async {
    if (_isFeedbackLoading) return;
    setState(() => _isFeedbackLoading = true);
    try {
      AppInfo appInfo = context.read<AppProvider>().appInfo;
      String feedbackEmail = serviceLocator.get<ConfigLoader>().get(EnvVariable.feedbackEmail.key) ?? "";
      String subject = "Feedback ${appInfo.appName} v${appInfo.version}";
      Uri mailTo = Uri.parse("mailto:$feedbackEmail?subject=$subject");
      await launchUrl(mailTo);
    } catch (e) {
      if (!mounted) return;
      AlertDialog(
        title: Text(context.l10n.error),
        content: Text(e.toString()),
      );
    } finally {
      setState(() => _isFeedbackLoading = false);
    }
  }

  void _onPrivacyPolicyPress() async {
    context.push(AppRoutes.privacyPolicyScreen.path);
  }

  void _onShareAppPress() async {
    if (_isShareLoading) return;
    setState(() => _isShareLoading = true);
    try {
      String store = Platform.isIOS ? appStoreUrl : playMarketUrl;
      await Share.share(store);
    } catch (e) {
      if (!mounted) return;
      AlertDialog(
        title: Text(context.l10n.error),
        content: Text(e.toString()),
      );
    } finally {
      setState(() => _isShareLoading = false);
    }
  }

  void _clearData() async {
    bool confirmed = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(context.l10n.confirmDeletion),
              content: Text(
                context.l10n.areYouSureYouWantToDeleteAllEmailAndMessages,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(context.l10n.cancel),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text(
                    context.l10n.delete,
                    style: const TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;

    if (confirmed) {
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      try {
        await serviceLocator.get<AppRepository>().clearCachedData();
        if (!mounted) return;
        ProviderUtils.disposeAllDisposableProviders(context);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_outlined,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    context.l10n.allDataHasBeenSuccessfullyDeleted,
                  ),
                ],
              ),
            ),
          );
        }
      } catch (e) {
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(
            content: context.l10n.unknownError,
          ),
        );
      } finally {
        if (mounted) context.go(AppRoutes.splashScreen.path);
      }
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
            leading: const Icon(Icons.feedback_outlined),
            onTap: _onFeedbackPress,
            title: Text(
              context.l10n.feedback,
            ),
            trailing: _isFeedbackLoading ? const CupertinoActivityIndicator() : null,
          ),
          ListTile(
            leading: const Icon(Icons.share_outlined),
            onTap: _onShareAppPress,
            title: Text(
              context.l10n.shareApp,
            ),
            trailing: _isShareLoading ? const CupertinoActivityIndicator() : null,
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            onTap: _onPrivacyPolicyPress,
            title: Text(
              context.l10n.privacyPolicy,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.delete_outline,
              color: Theme.of(context).colorScheme.error,
            ),
            onTap: _clearData,
            title: Text(
              context.l10n.clearAllData,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

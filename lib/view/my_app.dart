import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/temp_mail_db_service.dart';
import 'package:flicker_mail/api/network/temp_email_api/temp_mail_network_service.dart';
import 'package:flicker_mail/models/mail/mailbox.dart';
import 'package:flicker_mail/providers/inbox_provider.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/repositories/mailbox_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flicker_mail/models/app_config/app_config.dart';
import 'package:flicker_mail/models/app_info/app_info.dart';
import 'package:flicker_mail/providers/app_provider.dart';
import 'package:flicker_mail/repositories/app_repository.dart';
import 'package:flicker_mail/router/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.initConfig,
    required this.appInfo,
    required this.appRepository,
  });

  final AppConfig initConfig;
  final AppInfo appInfo;
  final AppRepository appRepository;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TempMailNetworkService _mailService;
  late TempMailDBService _dbMailService;
  late TempMailRepository _mailRepo;

  @override
  void initState() {
    _mailService = TempMailNetworkService();
    _dbMailService = TempMailDBService();
    _mailRepo = TempMailRepository(_mailService, _dbMailService);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (_) => AppProvider(
            widget.initConfig,
            widget.appInfo,
            widget.appRepository,
          ),
        ),
        ChangeNotifierProvider<EmailProvider>(
          create: (_) => EmailProvider(_mailRepo),
        ),
        ChangeNotifierProxyProvider<EmailProvider, InboxProvider>(
          create: (_) => InboxProvider(_mailRepo),
          update: (context, value, previous) {
            return InboxProvider(_mailRepo)..update(value.activeEmail);
          },
        )
      ],
      child: Consumer<AppProvider>(
        builder: (context, appConfigProvider, child) => MaterialApp.router(
          routerConfig: AppRouter.initRouter(),
          locale: appConfigProvider.appLocale,
          theme: FlexThemeData.light(scheme: FlexScheme.bahamaBlue),
          darkTheme: FlexThemeData.dark(scheme: FlexScheme.bigStone),
          themeMode: appConfigProvider.themeMode,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('es'), // Spanish
          ],
        ),
      ),
    );
  }
}

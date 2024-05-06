import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/email_db_service.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/email_message_db_service.dart';
import 'package:flicker_mail/api/network/sec_mail_api/temp_mail_network_service.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/repositories/temp_mail_repository.dart';
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
  /// Network
  late TempMailNetworkService _mailService;

  /// DB
  late EmailDBService _emailDbService;
  late EmailMessageDBService _emailMessageDbService;

  /// Repos
  late TempMailRepository _mailRepo;

  @override
  void initState() {
    _mailService = TempMailNetworkService();
    _emailDbService = EmailDBService();
    _emailMessageDbService = EmailMessageDBService();
    _mailRepo = TempMailRepository(_mailService, _emailDbService, _emailMessageDbService);
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
      ],
      child: Consumer<AppProvider>(
        builder: (context, appConfigProvider, child) {
          return MaterialApp.router(
            routerConfig: AppRouter.initRouter(),
            locale: appConfigProvider.appLocale,
            theme: FlexThemeData.light(scheme: FlexScheme.blumineBlue, useMaterial3: true),
            darkTheme: FlexThemeData.dark(scheme: FlexScheme.verdunHemlock, useMaterial3: true),
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
              Locale('ru'),
              Locale('tr'),
            ],
          );
        },
      ),
    );
  }
}

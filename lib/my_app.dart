import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flicker_mail/core/const_gen/fonts.gen.dart';
import 'package:flicker_mail/core/router/app_router.dart';
import 'package:flicker_mail/init_dependencies.dart';
import 'package:flicker_mail/presentation/providers/adv_provider.dart';
import 'package:flicker_mail/presentation/providers/app_provider.dart';
import 'package:flicker_mail/presentation/providers/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (_) => serviceLocator.get<AppProvider>(),
        ),
        ChangeNotifierProvider<EmailProvider>(
          create: (_) => serviceLocator.get<EmailProvider>(),
        ),
        ChangeNotifierProvider<AdvProvider>(
          create: (_) => serviceLocator.get<AdvProvider>(),
        ),
      ],
      child: Consumer<AppProvider>(
        builder: (context, appConfigProvider, child) {
          return MaterialApp.router(
            routerConfig: AppRouter.initRouter(),
            debugShowCheckedModeBanner: false,
            locale: appConfigProvider.appLocale,
            theme:
                FlexThemeData.light(scheme: FlexScheme.blumineBlue, useMaterial3: true, fontFamily: FontFamily.inter),
            darkTheme:
                FlexThemeData.dark(scheme: FlexScheme.verdunHemlock, useMaterial3: true, fontFamily: FontFamily.inter),
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
            builder: (context, child) {
              return MediaQuery.withNoTextScaling(
                child: Container(child: child),
              );
            },
          );
        },
      ),
    );
  }
}

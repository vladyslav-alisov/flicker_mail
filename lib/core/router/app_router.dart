import 'package:flicker_mail/core/router/app_routes.dart';
import 'package:flicker_mail/presentation/screens/email/email_archive_screen.dart';
import 'package:flicker_mail/presentation/screens/email/new_email_screen.dart';
import 'package:flicker_mail/presentation/screens/inbox/email_message_details_screen.dart';
import 'package:flicker_mail/presentation/screens/navigation_screen.dart';
import 'package:flicker_mail/presentation/screens/privacy/privacy_policy_screen.dart';
import 'package:flicker_mail/presentation/screens/splash/launch_error_screen.dart';
import 'package:flicker_mail/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static GoRouter? _goRouter;

  static GoRouter get router => _goRouter == null ? throw Exception("Init router first") : _goRouter!;

  static GlobalKey get navigatorKey => _rootNavigatorKey;

  static GoRouter initRouter() {
    _goRouter ??= GoRouter(
      initialLocation: AppRoutes.splashScreen.path,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: AppRoutes.splashScreen.name,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: AppRoutes.errorScreen.name,
          builder: (context, state) => LaunchErrorScreen(errorMessage: state.extra as String),
        ),
        GoRoute(
          path: AppRoutes.homeScreen.path,
          builder: (context, state) => const NavigationScreen(),
          routes: [
            GoRoute(
              path: AppRoutes.emailMessageDetailsScreen.name,
              builder: (context, state) => EmailMessageDetailsScreen(
                args: state.extra as MailScreenArgs,
              ),
            ),
            GoRoute(
              path: AppRoutes.privacyPolicyScreen.name,
              builder: (context, state) => PrivacyPolicy(),
            ),
            GoRoute(
              path: AppRoutes.newEmailScreen.name,
              builder: (context, state) => const NewEmailScreen(),
            ),
            GoRoute(
              path: AppRoutes.emailArchiveScreen.name,
              builder: (context, state) => const EmailArchiveScreen(),
            ),
          ],
        ),
      ],
    );
    return _goRouter!;
  }
}

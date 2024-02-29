import 'package:flicker_mail/router/app_routes.dart';
import 'package:flicker_mail/view/email/new_email_screen.dart';
import 'package:flicker_mail/view/inbox/mail_screen.dart';
import 'package:flicker_mail/view/navigation_screen.dart';
import 'package:flicker_mail/view/privacy/privacy_policy_screen.dart';
import 'package:flicker_mail/view/splash/launch_error_screen.dart';
import 'package:flicker_mail/view/splash/splash_screen.dart';
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
              path: AppRoutes.mailScreen.name,
              builder: (context, state) => MailScreen(
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
          ],
        ),
      ],
    );
    return _goRouter!;
  }
}

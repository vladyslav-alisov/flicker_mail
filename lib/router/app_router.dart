import 'package:flicker_mail/router/routes.dart';
import 'package:flicker_mail/view/mail_screen.dart';
import 'package:flicker_mail/view/mailbox_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static GoRouter? _goRouter;

  static GoRouter get router => _goRouter == null ? throw Exception("Init router first") : _goRouter!;
  static GlobalKey get navigatorKey => _rootNavigatorKey;

  static GoRouter initRouter() {
    _goRouter ??= GoRouter(
      initialLocation: Routes.mailboxScreen.path,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: Routes.mailboxScreen.path,
          builder: (context, state) => const MailboxScreen(),
          routes: [
            GoRoute(
              path: Routes.mailScreen.name,
              builder: (context, state) => MailScreen(
                args: state.extra as MailScreenArgs,
              ),
            ),
          ],
        ),
      ],
    );
    return _goRouter!;
  }
}

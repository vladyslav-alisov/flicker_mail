import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LaunchErrorScreen extends StatelessWidget {
  const LaunchErrorScreen({Key? key, required this.errorMessage}) : super(key: key);

  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(errorMessage),
            TextButton(
              child: Text(context.l10n.retry),
              onPressed: () => context.go(
                AppRoutes.splashScreen.path,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

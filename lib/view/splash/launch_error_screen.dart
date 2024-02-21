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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Oops! Something Went Wrong",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            child: Text(context.l10n.retry),
            onPressed: () => context.go(
              AppRoutes.splashScreen.path,
            ),
          ),
        ],
      ),
    );
  }
}

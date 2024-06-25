import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class DisposableProvider with ChangeNotifier {
  void disposeValues();
}

class ProviderUtils {
  static List<DisposableProvider> getDisposableProviders(BuildContext context) {
    return [
      context.read<EmailProvider>(),
    ];
  }

  static void disposeAllDisposableProviders(BuildContext context) {
    getDisposableProviders(context).forEach((disposableProvider) {
      disposableProvider.disposeValues();
    });
  }
}

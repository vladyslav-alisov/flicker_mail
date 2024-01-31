import 'package:flicker_mail/providers/inbox_provider.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  EmailProvider get _emailProvider => context.read<EmailProvider>();
  InboxProvider get _inboxProvider => context.read<InboxProvider>();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    var response = await _emailProvider.checkHealth();
    if (response.errorMsg != null) {
      if (!mounted) return;
      context.go(AppRoutes.errorScreen.path, extra: response.errorMsg);
    } else {
      await _emailProvider.initEmail();
      await _inboxProvider.initInbox();
      if (!mounted) return;
      context.go(AppRoutes.home.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Loading..."),
      ),
    );
  }
}

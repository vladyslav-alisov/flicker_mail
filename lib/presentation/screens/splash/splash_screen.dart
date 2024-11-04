import 'package:flicker_mail/core/const_gen/assets.gen.dart';
import 'package:flicker_mail/core/router/app_routes.dart';
import 'package:flicker_mail/presentation/providers/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  EmailProvider get _emailProvider => context.read<EmailProvider>();

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
      var initMailResponse = await _emailProvider.initEmail();
      if (!mounted) return;
      if (initMailResponse.errorMsg != null) {
        context.go(AppRoutes.errorScreen.path, extra: initMailResponse.errorMsg);
      } else {
        context.go(AppRoutes.homeScreen.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LottieBuilder.asset(Assets.animations.loadingAnimation.path),
      ),
    );
  }
}

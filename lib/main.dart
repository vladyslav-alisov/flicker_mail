import 'package:flicker_mail/core/config_loader/config_loader.dart';
import 'package:flicker_mail/init_dependencies.dart';
import 'package:flicker_mail/my_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(
      testDeviceIds: [
        "dd01560772086945b0551c65cb77263a",
      ],
    ),
  );

  await SentryFlutter.init(
    (options) {
      options.dsn = serviceLocator.get<ConfigLoader>().get(EnvVariable.sentryDNS.key);
      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
      options.environment = kDebugMode ? "develop" : "production";
    },
    appRunner: () => runApp(const MyApp()),
  );
}

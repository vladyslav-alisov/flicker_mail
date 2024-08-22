import 'package:flicker_mail/utils/app_env.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdvProvider extends ChangeNotifier {
  BannerAd? _bannerAd;

  BannerAd? get bannerAd => _bannerAd;

  void loadAd() {
    final bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AppEnv.instance.adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: _handleOnAdLoaded,
        onAdFailedToLoad: _handleOnAdFailed,
      ),
    );

    // Start loading.
    bannerAd.load();
  }

  void _handleOnAdLoaded(Ad ad) {
    _bannerAd = ad as BannerAd;
    notifyListeners();
  }

  void _handleOnAdFailed(Ad ad, LoadAdError error) {
    debugPrint('BannerAd failed to load: $error');
    ad.dispose();
  }
}

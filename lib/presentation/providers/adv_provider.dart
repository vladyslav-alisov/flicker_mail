import 'dart:io';

import 'package:flicker_mail/core/config_loader/config_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdvProvider extends ChangeNotifier {
  BannerAd? _bannerAd;

  AdvProvider({
    required ConfigLoader configLoader,
  }) : _configLoader = configLoader;

  final ConfigLoader _configLoader;

  BannerAd? get bannerAd => _bannerAd;

  void loadAd() {
    final bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Platform.isAndroid
          ? (_configLoader.get(EnvVariable.adUnitIdAndroid.key) ?? "")
          : (_configLoader.get(EnvVariable.adUnitIdIOS.key) ?? ""),
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: _handleOnAdLoaded,
        onAdFailedToLoad: _handleOnAdFailed,
      ),
    );

    bannerAd.load();
  }

  void _handleOnAdLoaded(Ad ad) {
    _bannerAd = ad as BannerAd;
    notifyListeners();
  }

  void _handleOnAdFailed(Ad ad, LoadAdError error) {
    ad.dispose();
  }
}

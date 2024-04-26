import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../google_app_ids.dart';

class GoogleInterstitialAdvertise {
  static final GoogleInterstitialAdvertise instance =
      GoogleInterstitialAdvertise._internal();

  factory GoogleInterstitialAdvertise() {
    return instance;
  }

  GoogleInterstitialAdvertise._internal();

  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdLoaded = false;
  var counter = 0.obs;

  Future<void> load() async {
    try {
      _isInterstitialAdLoaded = false;
      await InterstitialAd.load(
        adUnitId: GoogleAppIds.instance.interId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
            _interstitialAd!.setImmersiveMode(true);
            _isInterstitialAdLoaded = true;
          },
          onAdFailedToLoad: (LoadAdError error) {
            _interstitialAd = null;
            _isInterstitialAdLoaded = false;
          },
        ),
      );
    } catch (error) {
      _interstitialAd?.dispose();
    }
  }

  void showAndNavigate({required void Function() callBack}) {
    if (GoogleAppIds.instance.showInterstitial.isTrue &&
        GoogleAppIds.instance.showAd.isTrue) {
      if (_isInterstitialAdLoaded &&
          _interstitialAd != null &&
          counter.value >= GoogleAppIds.instance.interCounter.value) {
        counter(0);
        _interstitialAd!.show().then((value) {
          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              callBack();
              ad.dispose();
              _interstitialAd = null;
              load();
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) async {
              log('$ad onAdFailedToShowFullScreenContent: $error');
              _interstitialAd = null;
              ad.dispose();
              load();
            },
          );
        });
      } else {
        counter.value++;
        callBack();
      }
    } else {
      callBack();
    }
  }
}

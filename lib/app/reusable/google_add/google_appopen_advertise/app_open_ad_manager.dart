import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../google_add_config_controller.dart';

/// Utility class that manages loading and showing app open ads.
class AppOpenAdManager {
  /// Maximum duration allowed between loading and showing the ad.
  final Duration maxCacheDuration = const Duration(hours: 4);

  /// Keep track of load time so we don't show an expired ad.
  DateTime? _appOpenLoadTime;

  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  String adUnitId = 'ca-app-pub-3940256099942544/9257395921';

  /// Load an [AppOpenAd].
  void loadAd() {
    adUnitId = Get.find<GoogleAddConfigController>().config.value.appOpenId ??
        "ca-app-pub-3940256099942544/9257395921";
    try {
      AppOpenAd.load(
        adUnitId: adUnitId,
        orientation: AppOpenAd.orientationPortrait,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            print('$ad loaded');
            _appOpenLoadTime = DateTime.now();
            _appOpenAd = ad;
          },
          onAdFailedToLoad: (error) {
            print('AppOpenAd failed to load: $error');
          },
        ),
      );
    } catch (error) {
      loadAd();
    }
  }

  /// Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  /// Shows the ad, if one exists and is not already being shown.
  ///
  /// If the previously cached ad has expired, this just loads and caches a
  /// new ad.
  void showAdIfAvailable() {
    if (!isAdAvailable) {
      print('Tried to show ad before available.');
      loadAd();
      return;
    }
    if (_isShowingAd) {
      print('Tried to show ad while already showing an ad.');
      return;
    }
    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      print('Maximum cache duration exceeded. Loading another ad.');
      _appOpenAd!.dispose();
      _appOpenAd = null;
      loadAd();
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        print('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        print('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    _appOpenAd!.show();
  }
}

class AppOpenOnStart {
  /// Maximum duration allowed between loading and showing the ad.
  final Duration maxCacheDuration = const Duration(hours: 4);

  /// Keep track of load time so we don't show an expired ad.
  DateTime? _appOpenLoadTime;

  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  late Timer _timer;
  String adUnitId = 'ca-app-pub-3940256099942544/9257395921';

  /// Load an [AppOpenAd].
  Future<void> loadAd() async {
    _timer = Timer.periodic(const Duration(seconds: 15), (Timer t) async {
      // await reDirect();
    });
    adUnitId = Get.find<GoogleAddConfigController>().config.value.appOpenId ??
        "ca-app-pub-3940256099942544/9257395921";
    try {
      AppOpenAd.load(
        adUnitId: adUnitId,
        orientation: AppOpenAd.orientationPortrait,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            _timer.cancel();
            print('$ad loaded');
            _appOpenLoadTime = DateTime.now();
            _appOpenAd = ad;
            showAdIfAvailable();
          },
          onAdFailedToLoad: (error) async {
            // await reDirect();

            print('AppOpenAd failed to load: $error');
          },
        ),
      );
    } on PlatformException catch (e) {
      _timer.cancel();
      // await reDirect();
    } catch (error) {
      _timer.cancel();
      // await reDirect();
    }
  }

  /// Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  /// Shows the ad, if one exists and is not already being shown.
  ///
  /// If the previously cached ad has expired, this just loads and caches a
  /// new ad.
  void showAdIfAvailable() {
    if (!isAdAvailable) {
      print('Tried to show ad before available.');
      loadAd();
      return;
    }
    if (_isShowingAd) {
      print('Tried to show ad while already showing an ad.');
      return;
    }
    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      print('Maximum cache duration exceeded. Loading another ad.');
      _appOpenAd!.dispose();
      _appOpenAd = null;
      loadAd();
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        print('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) async {
        print('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        // await reDirect();
      },
    );
    _appOpenAd!.show();
  }
}

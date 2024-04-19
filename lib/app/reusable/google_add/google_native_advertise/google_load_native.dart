import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../google_add_config_controller.dart';

//==============================================================================
//   ** Large Native ***
//==============================================================================

class LoadLargeNative {
  static final LoadLargeNative instance = LoadLargeNative._internal();

  factory LoadLargeNative() {
    return instance;
  }

  LoadLargeNative._internal();

  List<NativeAd> nativeObjectLarge = [];
  NativeAd? nativeAd;
  var nativeAdIsLoaded = false.obs;
  var failedNative = false.obs;
  var c = Get.find<GoogleAddConfigController>().config.value;
  String adUnitId = 'ca-app-pub-3940256099942544/2247696110';

  Future<void> loadAd() async {
    adUnitId = c.nativeId ?? "ca-app-pub-3940256099942544/2247696110";

    if (nativeObjectLarge.length >= 2) {
      return;
    }
    nativeAd = NativeAd(
      factoryId: "listTileMedium",
      adUnitId: "ca-app-pub-3940256099942544/2247696110",
      listener: NativeAdListener(
        onAdLoaded: (ad) async {
          debugPrint('$NativeAd loaded.');
          nativeAdIsLoaded(true);
          nativeObjectLarge.add(nativeAd!);
          if (nativeObjectLarge.length < 2) {
            loadAd();
          }
        },
        onAdImpression: (add) {
          print(add);
        },
        onAdFailedToLoad: (ad, error) {
          failedNative(true);
          print(error);
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
    await nativeAd?.load();
  }
}

//==============================================================================
//   ** Small Native ***
//==============================================================================

class LoadSmallNative {
  static final LoadSmallNative instance = LoadSmallNative._internal();

  factory LoadSmallNative() {
    return instance;
  }

  LoadSmallNative._internal();

  List<NativeAd> nativeObjectSmall = [];
  NativeAd? nativeAd;
  var nativeAdIsLoaded = false.obs;
  var failedNative = false.obs;
  var c = Get.find<GoogleAddConfigController>().config.value;
  String adUnitId = 'ca-app-pub-3940256099942544/2247696110';

  Future<void> loadAd() async {
    adUnitId = c.nativeId ?? "ca-app-pub-3940256099942544/2247696110";

    if (nativeObjectSmall.length >= 2) {
      return;
    }
    nativeAd = NativeAd(
      factoryId: "listTile",
      adUnitId: "ca-app-pub-3940256099942544/2247696110",
      listener: NativeAdListener(
        onAdLoaded: (ad) async {
          debugPrint('Small loaded.');
          nativeAdIsLoaded(true);
          nativeObjectSmall.add(nativeAd!);
          if (nativeObjectSmall.length < 2) {
            loadAd();
          }
        },
        onAdImpression: (add) {
          print(add);
        },
        onAdFailedToLoad: (ad, error) {
          failedNative(true);
          print(error);
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
    await nativeAd?.load();
  }
}

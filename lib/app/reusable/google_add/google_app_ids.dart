import 'dart:io';

import 'package:get/get.dart';

import '../../core/constant.dart';
import '../../model/config_model.dart';
import 'google_add_config_controller.dart';

class GoogleAppIds {
  static final GoogleAppIds instance = GoogleAppIds._internal();

  factory GoogleAppIds() {
    return instance;
  }
  GoogleAppIds._internal();

  String appOpenId = Constants.appOpenAdUnitId;
  String bannerId = Constants.bannerUnitId;
  String nativeId = Constants.nativeAdUnitId;
  String rewardedId = Constants.rewardedUnitId;
  String interId = Constants.interstitialUnitId;
  var isQureka = true.obs;
  var showOpenApp = true.obs;
  var showAd = true.obs;
  var showNative = true.obs;
  var showRewarded = true.obs;
  var showInterstitial = true.obs;
  var showBanner = true.obs;
  var isPro = true.obs;
  var interCounter = 0.obs;

  setPlateFormIds(ConfigData appIds) {
    var appIds = Get.find<GoogleAddConfigController>().config.value;
    if (Platform.isAndroid) {
      appOpenId = appIds.appOpenId ?? Constants.appOpenAdUnitId;
      bannerId = appIds.bannerId ?? Constants.bannerUnitId;
      interId = appIds.interstitialId ?? Constants.interstitialUnitId;
      nativeId = appIds.nativeId ?? Constants.nativeAdUnitId;
      rewardedId = appIds.rewardedId ?? Constants.rewardedUnitId;
      showBanner.value = appIds.showBanner ?? false;
      showInterstitial.value = appIds.showInterstitial ?? false;
      showNative.value = appIds.showNative ?? false;
      showRewarded.value = appIds.showRewarded ?? false;
      showOpenApp.value = appIds.showOpenApp ?? false;
      showAd.value = appIds.showAd ?? false;
      isQureka.value = appIds.isQureka ?? false;
      isPro.value = appIds.isPro ?? false;
      interCounter.value = appIds.interstitialCounter;
    } else if (Platform.isIOS) {
      appOpenId = appIds.appOpenId ?? Constants.iosAppOpenId;
      bannerId = appIds.iosBannerId ?? Constants.iosBannerId;
      interId = appIds.interstitialId ?? Constants.iosInterId;
      rewardedId = appIds.iosRewardedId ?? Constants.iosRewardedId;
      nativeId = appIds.iosNativeId ?? Constants.iosNativeId;
      showBanner.value = appIds.iosShowBanner ?? false;
      showInterstitial.value = appIds.iosShowInterstitial ?? false;
      showNative.value = appIds.iosShowNative ?? false;
      showRewarded.value = appIds.iosShowRewarded ?? false;
      showOpenApp.value = appIds.iosShowOpenApp ?? false;
      showAd.value = appIds.iosShowAd ?? false;
      isQureka.value = appIds.isQureka ?? false;
      isPro.value = appIds.iosIsPro ?? false;
      interCounter.value = appIds.iosInterstitialCounter;
    }
  }
}

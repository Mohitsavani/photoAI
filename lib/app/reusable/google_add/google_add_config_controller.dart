import 'dart:convert';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../model/config_model.dart';
import '../../uttils/analytic_service/analytics_service.dart';
import '../../uttils/globle_uttils.dart';
import '../../uttils/local_store/prefrances.dart';
import 'google_advertise_repo/advertise_repo.dart';
import 'google_app_ids.dart';
import 'google_appopen_advertise/app_open_ad_manager.dart';

class GoogleAddConfigController extends GetxController {
  Rx<ConfigData> config = Rx<ConfigData>(ConfigData());
  Rx<ConfigData> get configData => config;
  var navigated = false.obs;
  bool? firstLunch;

  @override
  void onInit() {
    super.onInit();
    AnalyticsService.instance.sendAnalyticsEvent(eventName: 'Posteriya App');
    fetchDataFromFirebase();
  }

  var object = {
    "alertTopic": "poster",
    "appOpenId":
        "/21857590943,22958333258/apoorva_gupta_poster.maker.festiva.app.festiva_poster/open",
    "bannerId": "-",
    "interstitialCounter": 3,
    "nativeCounter": 0,
    "interstitialId":
        "/21857590943,22958333258/apoorva_gupta_poster.maker.festiva.app.festiva_poster/interstitial",
    "ios_appOpenId": "ca-app-pub-3940256099942544/5575463023",
    "ios_bannerId": "ca-app-pub-3940256099942544/2934735716",
    "ios_interstitialCounter": 1,
    "ios_interstitialId": "ca-app-pub-3940256099942544/4411468910",
    "ios_isPro": false,
    "ios_nativeId": "ca-app-pub-3940256099942544/3986624511",
    "ios_rewardedId": "ca-app-pub-3940256099942544/1712485313",
    "ios_showAd": true,
    "ios_showBanner": true,
    "ios_showInterstitial": true,
    "ios_showNative": true,
    "ios_showOpenApp": true,
    "ios_showRewarded": true,
    "isComingSoon": false,
    "isQureka": true,
    "nativeId":
        "/21857590943,22958333258/apoorva_gupta_poster.maker.festiva.app.festiva_poster/native",
    "rewardedId":
        "/21857590943,22958333258/apoorva_gupta_poster.maker.festiva.app.festiva_poster/rewarded",
    "showAd": false,
    "showBanner": true,
    "showInterstitial": true,
    "showNative": true,
    "showOpenApp": true,
    "showRewarded": true,
    "isPro": true
  };

  Future<void> fetchDataFromFirebase() async {
    if (await ConnectivityWrapper.instance.isConnected) {
      try {
        DatabaseReference ref =
            FirebaseDatabase.instance.ref().child("app_config");
        DataSnapshot snapshot = await ref.get();
        Object? data = snapshot.value;

        if (data != null) {
          PreferenceHelper.instance.setData(Pref.appData, json.encode(data));
          await getLocalData().then((value) async {
            await loadAds();
          });
        } else {
          await getLocalData().then((value) async {
            await loadAds();
          });
        }
      } catch (e) {
        await getLocalData().then((value) async {
          await redirect();
        });
      }
    } else {
      await getLocalData().then((value) async {
        await redirect();
      });
    }
  }

  loadAds() async {
    if (config.value.showAd == true) {
      await GoogleAdd.getInstance().loadLargeNative();
      await GoogleAdd.getInstance().loadSmallNative();
      await GoogleAdd.getInstance().googleOpenAppAdd();
      await GoogleAdd.getInstance().loadGoogleInterstitialAdd();
      await GoogleAdd.getInstance().googleOpenAppAddWithOutLoad();
      await AppOpenOnStart().loadAd();
    } else {
      await redirect();
    }
  }

  Future<void> getLocalData() async {
    String? appdata;
    appdata = await PreferenceHelper.instance.getData(Pref.appData);
    if (appdata == null) {
      config.value = configDataFromJson(json.encode(object));
    } else {
      config.value = configDataFromJson(appdata);
      // config.value = configDataFromJson(json.encode(localData));
    }
    GoogleAppIds.instance.setPlateFormIds(config.value);
  }
}

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../uttils/globle_uttils.dart';
import '../google_app_ids.dart';
import 'app_open_ad_manager.dart';

class GoogleOpenAppAdvertise {
  static final GoogleOpenAppAdvertise instance =
      GoogleOpenAppAdvertise._internal();

  factory GoogleOpenAppAdvertise() {
    return instance;
  }

  GoogleOpenAppAdvertise._internal();

  late AppOpenAdManager appOpenAdManager;
  late AppLifecycleReactor _appLifecycleReactor;

  Future<void> getOpenAppAdvertise() async {
    appOpenAdManager = AppOpenAdManager()..loadAd();
    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();
  }

  Future<void> getOpenAppAdvertiseWithOutLoad() async {
    appOpenAdManager = AppOpenAdManager();
    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();
  }
}

class AppLifecycleReactor {
  final AppOpenAdManager appOpenAdManager;

  AppLifecycleReactor({required this.appOpenAdManager});

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    appPrint('New AppState state: $appState');
    if (GoogleAppIds.instance.showOpenApp.isTrue &&
        GoogleAppIds.instance.showAd.isTrue) {
      if (GoogleAppIds.instance.isQureka.isFalse) {
        if (appState == AppState.foreground) {
          appOpenAdManager.showAdIfAvailable();
        }
      }
    }
  }
}

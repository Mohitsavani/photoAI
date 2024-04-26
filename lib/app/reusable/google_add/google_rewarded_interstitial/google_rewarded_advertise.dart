import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../uttils/globle_uttils.dart';
import '../google_app_ids.dart';

class GoogleRewardsAdvertise {
  static final GoogleRewardsAdvertise instance =
      GoogleRewardsAdvertise._internal();

  factory GoogleRewardsAdvertise() {
    return instance;
  }

  GoogleRewardsAdvertise._internal();

  RewardedAd? rewardedAd;
  var isRewardAdLoaded = false.obs;

  void setWaterMark() {
    // Get.put(EditPosterController())
    //     .frameSettings[Get.put(EditPosterController()).currantFrame.value]
    //     .value
    //     .removeWaterMark(true);
  }

  void loadRewardedAd({required void Function() callback}) {
    Timer? adLoadTimer;

    adLoadTimer = Timer(const Duration(seconds: 12), () {
      adLoadTimer?.cancel();
      rewardedAd?.dispose();
      rewardedAd = null;
      isRewardAdLoaded(false);
      callback();
    });
    try {
      isRewardAdLoaded(true);
      RewardedAd.load(
        adUnitId: GoogleAppIds.instance.rewardedId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            adLoadTimer?.cancel();
            isRewardAdLoaded(false);
            rewardedAd = ad;
            appPrint('Reward Loaded');
            showAndNavigate(callback: callback);
          },
          onAdFailedToLoad: (err) {
            adLoadTimer?.cancel();
            rewardedAd?.dispose();
            isRewardAdLoaded(false);
            callback();
          },
        ),
      );
    } catch (error) {
      adLoadTimer.cancel();
      rewardedAd?.dispose();
      callback();
    }
  }

  Future<void> showAndNavigate({required void Function() callback}) async {
    try {
      if (GoogleAppIds.instance.showRewarded.isTrue &&
          GoogleAppIds.instance.showAd.isTrue) {
        if (isRewardAdLoaded.isFalse && rewardedAd != null) {
          rewardedAd!.show(
              onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
            callback();
          }).then((value) {
            rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {},
              onAdFailedToShowFullScreenContent:
                  (RewardedAd ad, AdError error) {
                log('$ad onAdFailedToShowFullScreenContent: $error');
                rewardedAd = null;
                ad.dispose();
                callback();
              },
            );
          });
        } else {
          callback();
        }
      } else {
        callback();
      }
    } catch (e) {
      callback();
    }
  }
}

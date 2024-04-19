import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../core/constant.dart';
import '../../../uttils/globle_uttils.dart';
import '../../global_widget.dart';
import '../google_app_ids.dart';

class GoogleBannerAdvertise extends StatefulWidget {
  const GoogleBannerAdvertise({
    super.key,
  });
  @override
  _GoogleBannerAdvertiseState createState() => _GoogleBannerAdvertiseState();
}

class _GoogleBannerAdvertiseState extends State<GoogleBannerAdvertise> {
  BannerAd? _bannerAd;
  bool _adLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_bannerAd != null &&
        _bannerAd!.adUnitId != GoogleAppIds.instance.bannerId) {
      _bannerAd!.dispose();
    }
    //loadAd();
  }

  Future<void> loadAd() async {
    Constants.bannerUnitId;
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      appPrint('Unable to get height of anchored banner.');
      return;
    }

    _bannerAd = BannerAd(
      adUnitId: GoogleAppIds.instance.bannerId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          appPrint('$ad loaded: ${ad.responseInfo}');
          setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            _bannerAd = ad as BannerAd;
            _adLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          appPrint('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _bannerAd?.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (GoogleAppIds.instance.showBanner.isTrue &&
          GoogleAppIds.instance.showAd.isTrue) {
        if (_adLoaded) {
          // Use if statement for readability
          return SizedBox(
            height: MediaQuery.of(context).size.height / 12,
            width: MediaQuery.of(context).size.width,
            child: AdWidget(ad: _bannerAd!),
          );
        } else {
          return const Empty();
        }
      } else {
        return const Empty();
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../core/colors.dart';
import '../../global_widget.dart';
import '../google_add_config_controller.dart';
import 'google_load_native.dart';

var nativeCounter = 0.obs;

class ShowNative extends StatelessWidget {
  final bool isSmall;
  const ShowNative({super.key, this.isSmall = false});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<GoogleAddConfigController>();
    var config = controller.config.value;

    if (config.nativeCounter != null) {
      if (nativeCounter.value >= config.nativeCounter!.toInt()) {
        nativeCounter(0);
        if (config.showNative == true && config.showAd == true) {
          return isSmall
              ? const GoogleNativeSmall()
              : const GoogleNativeLarge();
        } else {
          return const SizedBox.shrink();
        }
      } else {
        nativeCounter.value++;
        return const SizedBox.shrink();
      }
    } else {
      // Handle the case where config or config.nativeCounter is null
      return const SizedBox.shrink();
    }
  }
}

//==============================================================================
//   ** Large Native ***
//==============================================================================

class GoogleNativeLarge extends StatefulWidget {
  const GoogleNativeLarge({
    super.key,
  });

  @override
  State<GoogleNativeLarge> createState() => _GoogleNativeLargeState();
}

class _GoogleNativeLargeState extends State<GoogleNativeLarge> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.appColor, width: 0.2)),
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w),
        child: LoadLargeNative.instance.nativeObjectLarge.isNotEmpty
            ? adView()
            : const SizedBox.shrink());
  }

  Widget adView() {
    return Obx(() {
      if (LoadLargeNative.instance.failedNative.isFalse) {
        return SizedBox(
          height: 290,
          child: Obx(() {
            if (LoadLargeNative.instance.nativeAdIsLoaded.isTrue) {
              var native =
                  LoadLargeNative.instance.nativeObjectLarge.removeAt(0);
              LoadLargeNative.instance.loadAd();
              return AdWidget(ad: native);
            } else {
              return const Center(child: LoadingDots());
            }
          }),
        );
      } else {
        return const Center(child: Text("Failed to load Ad"));
      }
    });
  }
}

//==============================================================================
//   ** Small Native ***
//==============================================================================

class GoogleNativeSmall extends StatefulWidget {
  const GoogleNativeSmall({super.key});

  @override
  State<GoogleNativeSmall> createState() => _GoogleNativeSmallState();
}

class _GoogleNativeSmallState extends State<GoogleNativeSmall> {
  var c = Get.find<GoogleAddConfigController>().config.value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.appColor, width: 0.2),
          ),
          padding: EdgeInsets.zero,
          margin: EdgeInsets.only(top: 1.h, left: 1.w, right: 1.w),
          child: LoadSmallNative.instance.nativeObjectSmall.isNotEmpty
              ? adView()
              : const SizedBox.shrink()),
    );
  }

  Widget adView() {
    return Obx(() {
      if (LoadSmallNative.instance.failedNative.isFalse) {
        return SizedBox(
          height: 160,
          child: Obx(() {
            if (LoadSmallNative.instance.nativeAdIsLoaded.isTrue) {
              var native =
                  LoadSmallNative.instance.nativeObjectSmall.removeAt(0);
              LoadSmallNative.instance.loadAd();
              return AdWidget(ad: native);
            } else {
              return const Center(child: LoadingDots());
            }
          }),
        );
      } else {
        return const Center(child: Text("Failed to load Ad"));
      }
    });
  }
}

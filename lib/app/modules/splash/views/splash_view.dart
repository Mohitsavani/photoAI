import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets.dart';
import '../../../core/colors.dart';
import '../../../reusable/images/default_image.dart';
import '../../../uttils/fade_widget.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            const Positioned.fill(
              child: FadeWidget(
                  child: DefaultImage(AppImages.appBg, fit: BoxFit.cover)),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                child: LinearProgressIndicator(
                  minHeight: 5,
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: AppColors.grey.withOpacity(0.2),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.appColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

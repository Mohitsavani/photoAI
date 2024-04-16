import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/core/colors.dart';
import 'package:posteriya/app/core/typography.dart';
import 'package:posteriya/app/reusable/app_button/app_button.dart';
import 'package:posteriya/app/reusable/images/default_image.dart';

import '../../core/assets.dart';
import '../../core/local_string.dart';
import '../../modules/purchase/views/purchase_view.dart';
import '../global_widget.dart';

class AppDialogs {
//==============================================================================
// ** Purchase Dialog **
//==============================================================================
  static proDialog(BuildContext context,
      {String? content, Function()? actionTap, String? title}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: AppColors.trans,
        child: Container(
            height: 340.h,
            width: 300.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            // Background color of the dialog box
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Container(
                        width: 50.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: AppColors.appColor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            DefaultImage(
                              AppIcons.gems,
                              height: 15.h,
                              width: 15.w,
                              color: AppColors.appColor,
                            ),
                            const AppText("0")
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 7),
                        child: DefaultImage(
                          AppIcons.close,
                          height: 24.h,
                          width: 24.h,
                          color: AppColors.appColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: Column(
                  children: [
                    DefaultImage(
                      AppIcons.gems,
                      height: 80.h,
                      width: 80.w,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppText(
                        title.toString(),
                        style: ubuntu.get18.bold.space03,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: AppText(
                        LocalString.notEnoughCount,
                        style: ubuntu.grey.get14.space03,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: AppButton(
                        radius: 50,
                        width: Get.width * 0.75,
                        height: Get.height * 0.06,
                        LocalString.buyCount,
                        style: ubuntu.space03.white,
                        onPressed: () {
                          Get.off(PurchaseView());
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppButton(
                        radius: 50,
                        width: Get.width * 0.75,
                        height: Get.height * 0.06,
                        LocalString.watchTheVideo,
                        style: ubuntu.space03.white,
                        onPressed: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: AppText(
                        LocalString.watchVideoGetCount,
                        style: ubuntu.grey.get11.space03,
                      ),
                    ),
                  ],
                ))
              ],
            )),
      ),
    );
  }

//==============================================================================
// ** Count Rules Dialog **
//==============================================================================

  static ruleDialog(BuildContext context,
      {String? content, Function()? actionTap, String? title}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: AppColors.trans, // Transparent background
        child: Container(
            height: 320.h,
            width: 320.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            // Background color of the dialog box
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 7),
                      child: DefaultImage(
                        AppIcons.close,
                        height: 24.h,
                        width: 24.h,
                        color: AppColors.appColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    DefaultImage(
                      AppIcons.gems,
                      height: 80.h,
                      width: 80.w,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppText(
                        LocalString.countRule,
                        style: ubuntu.get18.bold.space03,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: AppText('1.', style: ubuntu.grey.get14),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: AppText(
                              maxLines: 2,
                              LocalString.rule1,
                              style: ubuntu.grey.get14.space03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 9),
                            child: AppText('2.', style: ubuntu.grey.get14),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: AppText(
                                maxLines: 2,
                                LocalString.rule2,
                                style: ubuntu.grey.get14.space03,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: AppButton(
                        radius: 50,
                        width: Get.width * 0.75,
                        height: Get.height * 0.06,
                        LocalString.confirm,
                        style: ubuntu.space03.white,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  ],
                ))
              ],
            )),
      ),
    );
  }
}

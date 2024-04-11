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
  static proDialog(BuildContext context,
      {String? content, Function()? actionTap, String? title}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: AppColors.trans, // Transparent background
        child: Container(
            height: 350.h,
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
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: DefaultImage(
                        AppIcons.gems,
                        height: 20,
                        width: 20,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.close))
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
                      padding: const EdgeInsets.all(8.0),
                      child: AppText(
                        "Not enough diamonds to use this feature",
                        style: ubuntu.grey.get13.space03,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: AppButton(
                        width: Get.width * 0.65,
                        height: Get.height * 0.06,
                        LocalString.buyCount,
                        onPressed: () {
                          Get.off(const PurchaseView());
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppButton(
                        width: Get.width * 0.65,
                        height: Get.height * 0.06,
                        LocalString.watchTheVideo,
                        onPressed: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        "Watch incentive video to get daimonds for free",
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
}

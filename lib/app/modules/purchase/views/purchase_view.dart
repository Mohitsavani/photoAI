import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/core/assets.dart';
import 'package:posteriya/app/core/colors.dart';
import 'package:posteriya/app/core/typography.dart';
import 'package:posteriya/app/reusable/app_button/app_button.dart';
import 'package:posteriya/app/reusable/generated_scaffold.dart';
import 'package:posteriya/app/reusable/global_widget.dart';

import '../../../core/constant.dart';
import '../../../core/local_string.dart';
import '../../../reusable/images/default_image.dart';
import '../controllers/purchase_controller.dart';

class PurchaseView extends GetView<PurchaseController> {
  const PurchaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PurchaseController());

    return appScaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NetWorkImage(
              'https://images.unsplash.com/photo-1571816119607-57e48af1caa9?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              fit: BoxFit.cover,
              height: 340,
              width: Get.width,
            ),
          ),
          Positioned(
              top: 25,
              left: 10,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const DefaultImage(
                  AppIcons.backIcon,
                  color: AppColors.appColor,
                  height: 40,
                  width: 40,
                ),
              )),
          Positioned.fill(
            top: 280,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: AppText(
                      "Photo AI",
                      style: ubuntu.appColor.w500.get20,
                    ),
                  ),
                  _featureView("1. ", " Gems unlock all features."),
                  _featureView("2. ", " Experience more cool effects."),
                  _featureView("3. ", " No ads."),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: SizedBox(
                      height: 180,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            purchaseList.length, // set the number of features
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 13),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                DefaultImage(
                                  purchaseList[index]['icon'] ?? "",
                                  height: 45.h,
                                  width: 45.w,
                                  color: AppColors.appColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: AppText(
                                    purchaseList[index]['name'],
                                    style: ubuntu.appColor.get15,
                                  ),
                                ),
                                AppButton(
                                  purchaseList[index]['Price'] ?? "",
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.privacy();
                          },
                          child: AppText(LocalString.privacy,
                              style: ubuntu.appColor.get15),
                        ),
                        AppText(" / "),
                        GestureDetector(
                          onTap: () {
                            controller.term();
                          },
                          child: AppText(LocalString.termsAndConditions,
                              style: ubuntu.appColor.get15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureView(String leading, String trailing) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 90.w, top: 5),
            child: RichText(
              text: TextSpan(
                text: leading,
                style: ubuntu.w300.appColor.get14,
                children: <TextSpan>[
                  TextSpan(
                    text: trailing,
                    style: ubuntu.w300.appColor.get14,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
      statusColor: AppColors.trans,
      topSafe: false,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NetWorkImage(
              'https://images.unsplash.com/photo-1571816119607-57e48af1caa9?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              fit: BoxFit.cover,
              height: 300.h,
              width: Get.width,
            ),
          ),
          Positioned(
            top: 25.h,
            left: 10.w,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: DefaultImage(
                AppIcons.backIcon,
                color: AppColors.appColor,
                height: 40.h,
                width: 40.w,
              ),
            ),
          ),
          Positioned.fill(
            top: 275.h,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: AppText(
                      LocalString.title,
                      style: ubuntu.appColor.w500.get20,
                    ),
                  ),
                  _featureView(
                    "1. ",
                    LocalString.purchasePoint1,
                  ),
                  _featureView("2. ", LocalString.purchasePoint2),
                  _featureView("3. ", LocalString.purchasePoint3),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: SizedBox(
                      height: 160.h,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: purchaseList.length,
                        itemBuilder: (context, index) {
                          return Obx(() {
                            final isSelected =
                                index == controller.selectedIndex.value;
                            final borderColor = isSelected
                                ? AppColors.appColor
                                : AppColors.grey;

                            return GestureDetector(
                              onTap: () {
                                controller.selectIndex(index);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 20,
                                  left: 11,
                                  right:
                                      index == purchaseList.length - 1 ? 13 : 0,
                                ),
                                child: SizedBox(
                                  width: 105.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: borderColor,
                                          width: isSelected ? 2.w : 1.w),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: DefaultImage(
                                            purchaseList[index]['icon'] ?? "",
                                            height: 45.h,
                                            width: 45.w,
                                            color: AppColors.appColor,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: AppText(
                                            purchaseList[index]['name'],
                                            style: isSelected
                                                ? ubuntu.appColor.get13.bold
                                                : ubuntu.appColor.get13,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: AppButton(
                                            purchaseList[index]['Price'] ?? "",
                                            onPressed: () {},
                                            style: ubuntu.get14.white,
                                            radius: 10,
                                            width: 100.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.privacy();
                                  },
                                  child: AppText(
                                    LocalString.privacy,
                                    style: ubuntu.get11.grey,
                                  ),
                                ),
                                AppText("+", style: ubuntu.get11.grey),
                                GestureDetector(
                                  onTap: () {
                                    controller.term();
                                  },
                                  child: AppText(
                                    LocalString.termsAndConditions,
                                    style: ubuntu.get11.grey,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: AppText(
                                LocalString.restorePurchase,
                                style: ubuntu.get11.grey,
                              ),
                            ),
                          ],
                        )
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
            padding: EdgeInsets.only(left: 90.w, top: 5.h),
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

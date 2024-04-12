import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/core/assets.dart';

import '../../../core/colors.dart';
import '../../../core/typography.dart';
import '../../../reusable/drawer/views/drawer_view.dart';
import '../../../reusable/generated_scaffold.dart';
import '../../../reusable/global_widget.dart';
import '../../../reusable/images/default_image.dart';
import '../../purchase/views/purchase_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.onWillPop(context),
      child: appScaffold(
        appBar: AppBar(
          title: Obx(
            () => Text(
              controller.titles[controller.currentIndex.value],
              style: ubuntu.thin.appColor,
            ),
          ),
          backgroundColor: AppColors.trans,
          centerTitle: true,
          actions: [
            Obx(() => controller.titles[controller.currentIndex.value] ==
                    'AIEffect'
                ? Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: DefaultImage(AppIcons.question,
                                height: 20,
                                width: 20,
                                color: AppColors.appColor),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(const PurchaseView());
                          },
                          child: Container(
                            width: 60,
                            height: 25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: AppColors.appColor)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                DefaultImage(
                                  AppIcons.gems,
                                  height: 15,
                                  width: 15,
                                  color: AppColors.appColor,
                                ),
                                AppText("0 +")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))
                : controller.titles[controller.currentIndex.value] == 'Home'
                    ? Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          width: 60,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: AppColors.appColor)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              DefaultImage(
                                AppIcons.gems,
                                height: 15,
                                width: 15,
                                color: AppColors.appColor,
                              ),
                              AppText("VIP")
                            ],
                          ),
                        ),
                      )
                    : const Empty())
          ],
        ),
        bottomNavigationBar: IntrinsicHeight(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.xffB6B6B4, width: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                controller.dashBordItemList.length,
                (index) => Obx(
                  () => InkWell(
                    onTap: () {
                      controller.changePage(index);
                      controller.currentIndex.value = index;
                    },
                    splashColor: AppColors.trans,
                    highlightColor: AppColors.trans,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: 5.w,
                            left: 5.w,
                            top: 2.h,
                            bottom: 2.h,
                          ),
                          width: 40.w,
                          height: 2.h,
                          decoration: BoxDecoration(
                            color: index == controller.currentIndex.value
                                ? AppColors.appColor
                                : AppColors.trans,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          child: Column(
                            children: [
                              DefaultImage(
                                controller.dashBordItemList[index].icon,
                                color: index == controller.currentIndex.value
                                    ? AppColors.appColor
                                    : AppColors.xffB6B6B4,
                                width: 20.h,
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.h),
                                child: AppText(
                                  controller.dashBordItemList[index].title,
                                  style: index == controller.currentIndex.value
                                      ? ubuntu.bold.appColor.get8
                                      : ubuntu.xffB6B6B4.get8,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        drawer: appDrawer(),
        body: Column(
          children: [
            _bodyWidget(),
          ],
        ),
      ),
    );
  }

  Widget _bodyWidget() => Expanded(
        child: PageView.builder(
          pageSnapping: false,
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          itemCount: controller.screenWidgets().length,
          itemBuilder: (context, index) {
            return controller.screenWidgets()[index];
          },
        ),
      );
}

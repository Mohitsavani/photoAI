import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/reusable/drawer/views/drawer_view.dart';

import '../../../core/colors.dart';
import '../../../core/typography.dart';
import '../../../reusable/bottomBar/posteriya_nav_bar.dart';
import '../../../reusable/generated_scaffold.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return appScaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              controller.titles[controller.currentPageIndex.value],
              style: ubuntu.thin.appBg,
            )),
        backgroundColor: AppColors.trans,
        centerTitle: true,
      ),
      drawer: appDrawer(),
      body: Column(
        children: [
          _bodyWidget(),
          _bottomBar(),
        ],
      ),
    );
  }

  Widget _bodyWidget() => Expanded(
        child: PageView.builder(
          pageSnapping: false,
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          itemCount: controller.screenWidgets.length,
          itemBuilder: (context, index) {
            return controller.screenWidgets[index];
          },
        ),
      );

  Widget _bottomBar() {
    return PosteriyaNavBar(
      icons: [
        PosteriyaNavBarIcon(assetPath: "assets/icons/AI_image.png"),
        PosteriyaNavBarIcon(assetPath: "assets/icons/home.png"),
        PosteriyaNavBarIcon(assetPath: "assets/icons/vault.png"),
      ],
      onChange: (index) {
        controller.currentPageIndex(index);
        controller.changePage(index);
      },
      style: const PosteriyaNavBarStyle(
          iconBackgroundColor: AppColors.appColor,
          iconSelectedForegroundColor: AppColors.white,
          iconUnselectedForegroundColor: AppColors.xffD7EDE2),
    );
  }
}

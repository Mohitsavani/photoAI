import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/colors.dart';
import '../../../core/typography.dart';
import '../../../modules/profile/controllers/profile_controller.dart';
import '../../global_widget.dart';
import '../../images/default_images.dart';

Drawer appDrawer() {
  return Drawer(
    width: 250.w,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    ),
    backgroundColor: AppColors.trans,
    child: const DrawerView(),
  );
}

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProfileController(),
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [
                AppColors.color1,
                AppColors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: Column(
                    children: List.generate(
                      controller.drawerItem.length,
                      (index) => InkWell(
                        onTap: () {
                          if (index == 0) {
                            controller.privacy();
                          } else if (index == 1) {
                            controller.term();
                          } else if (index == 2) {
                            controller.rate();
                          } else if (index == 3) {
                            controller.share();
                          } else if (index == 4) {
                            controller.help();
                          }
                        },
                        splashColor: AppColors.trans,
                        highlightColor: AppColors.trans,
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.appBG.withOpacity(0.3),
                          ),
                          margin: EdgeInsets.only(right: 5.w, bottom: 1.5.h),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 1.w),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  child: DefaultImage(
                                    controller.drawerItem[index].icon,
                                    width: 20.h,
                                    height: 20.h,
                                  ),
                                ),
                                AppText(
                                  controller.drawerItem[index].title,
                                  style: ubuntu.get14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/colors.dart';
import '../../../core/typography.dart';
import '../../../uttils/globle_uttils.dart';
import '../../global_widget.dart';
import '../../images/default_image.dart';
import '../controllers/drawer_controller.dart';

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
      init: AppDrawerController(),
      builder: (controller) {
        return Container(
          color: AppColors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Column(
                    children: List.generate(
                      controller.drawerItem.length,
                      (index) => InkWell(
                        onTap: () {
                          if (index == 0) {
                            showInter(callBack: () {
                              controller.privacy();
                            });
                          } else if (index == 1) {
                            showInter(callBack: () {
                              controller.term();
                            });
                          } else if (index == 2) {
                            showInter(callBack: () {
                              controller.rate();
                            });
                          } else if (index == 3) {
                            showInter(callBack: () {
                              controller.share();
                            });
                          } else if (index == 4) {
                            showInter(callBack: () {
                              controller.help();
                            });
                          }
                        },
                        splashColor: AppColors.trans,
                        highlightColor: AppColors.trans,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1.w),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: DefaultImage(
                                        controller.drawerItem[index].icon,
                                        width: 18.h,
                                        height: 18.h,
                                        color: AppColors.appColor,
                                      ),
                                    ),
                                    AppText(
                                      controller.drawerItem[index].title,
                                      style: ubuntu.get12.appColor.w500.w500,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 20.h,

                                // endIndent: 5.w,
                                color: AppColors.xfff9f5fc,
                              )
                            ],
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

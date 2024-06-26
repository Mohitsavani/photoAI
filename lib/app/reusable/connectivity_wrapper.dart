import 'dart:ui';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/core/typography.dart';

import '../core/assets.dart';
import '../core/colors.dart';
import '../core/local_string.dart';
import 'app_button/app_button.dart';
import 'global_widget.dart';
import 'images/default_image.dart';

class ConnectionWrapper extends StatefulWidget {
  const ConnectionWrapper({
    super.key,
  });
  @override
  State<ConnectionWrapper> createState() => _ConnectionWrapperState();
}

class _ConnectionWrapperState extends State<ConnectionWrapper> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.trans,
          body: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.h, vertical: 150.h),
                padding: EdgeInsets.zero,
                child: Stack(
                  children: [
                    Container(
                      height: 60.h,
                      decoration: const BoxDecoration(
                          color: AppColors.appColor,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10))),
                    ),
                    SizedBox(
                      width: Get.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 30.h),
                            child: Container(
                              height: 60.h,
                              width: 60.h,
                              padding: EdgeInsets.all(2.h),
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: AppColors.appColor)),
                                child: Padding(
                                  padding: EdgeInsets.all(7.h),
                                  child: DefaultImage(
                                    AppIcons.wifi,
                                    color: AppColors.appColor,
                                    height: 20,
                                    width: 23.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: AppText(
                              LocalString.noInternet,
                              style: ubuntu.get20.black.space09.w700,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.h, horizontal: 2.w),
                            child: AppText(LocalString.checkConnection,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: ubuntu.get9.w400.space09),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: AppText(LocalString.pleaseTurnOn,
                                style: ubuntu.get12.black.w500),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 5.w),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: AppButton(LocalString.wifi,
                                        height: 35.h,
                                        width: 100.h, onPressed: () {
                                      AppSettings.openAppSettings(
                                          type: AppSettingsType.wifi);
                                    }),
                                  ),
                                  Expanded(
                                      child: AppButton(LocalString.mobileData,
                                          height: 35.h,
                                          width: 100.h, onPressed: () {
                                    AppSettings.openAppSettings(
                                        type: AppSettingsType.dataRoaming);
                                  })),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget button(String title, {required void Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(1.2.h),
        decoration: BoxDecoration(
            color: AppColors.appColor, borderRadius: BorderRadius.circular(50)),
        child: Padding(
          padding: EdgeInsets.all(1.5.h),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: ubuntu.get10.white.space01.w400,
              ),
            ],
          )),
        ),
      ),
    );
  }
}

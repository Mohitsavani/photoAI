import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/core/typography.dart';

import '../../core/colors.dart';
import '../global_widget.dart';

//==============================================================================
// ** Elevated Button **
//==============================================================================
class AppButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final double? height;
  final double? width;
  final double? radius;
  final bool? loader;
  final Color? backGroundColor;

  const AppButton(
    this.title, {
    super.key,
    required this.onPressed,
    this.height,
    this.radius,
    this.width,
    this.loader = false,
    this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
      child: GestureDetector(
        onTap: loader == true ? () {} : onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Container(
            height: height ?? 5.5.h,
            width: width ?? Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius ?? 15),
              color: backGroundColor ?? AppColors.appColor,
            ),
            child: Center(
                child: AppText(
              title,
              style: ubuntu.bold.get11.white,
            )),
          ),
        ),
      ),
    );
  }
}

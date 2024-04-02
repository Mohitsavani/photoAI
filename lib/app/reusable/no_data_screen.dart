import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/core/typography.dart';

import '../core/assets.dart';
import '../core/colors.dart';
import '../core/local_string.dart';
import 'generated_scaffold.dart';
import 'global_widget.dart';
import 'images/default_images.dart';

class NoData extends StatelessWidget {
  final String? logo;
  final String? title;
  final String? subTitle;
  final String? buttonText;
  final Function()? buttonTap;
  final bool? isButton;

  const NoData(
      {super.key,
      this.logo,
      this.title,
      this.subTitle,
      this.buttonText,
      this.buttonTap,
      this.isButton = false});

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      body: Container(
        width: Get.width,
        color: AppColors.appBG,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Opacity(
              opacity: 0.5,
              child: DefaultImage(
                logo ?? AppIcons.noBox,
                width: 100.h,
                height: 100.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
              child: AppText(
                title ?? LocalString.noBeautificationPictures,
                style: ubuntu.get20.grey.bold.space09,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

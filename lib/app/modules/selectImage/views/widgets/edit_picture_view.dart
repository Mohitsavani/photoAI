import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/modules/selectImage/views/widgets/result_view.dart';
import 'package:posteriya/app/reusable/generated_scaffold.dart';

import '../../../../core/assets.dart';
import '../../../../core/colors.dart';
import '../../../../core/local_string.dart';
import '../../../../core/typography.dart';
import '../../../../reusable/app_button/app_button.dart';
import '../../../../reusable/global_widget.dart';
import '../../../../reusable/images/default_image.dart';

class EditPictureView extends StatefulWidget {
  final File image;
  const EditPictureView({Key? key, required this.image}) : super(key: key);

  @override
  State<EditPictureView> createState() => _EditPictureViewState();
}

class _EditPictureViewState extends State<EditPictureView> {
  @override
  Widget build(BuildContext context) {
    return appScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.trans,
        title: AppText(
          LocalString.editPicture,
          style: ubuntu.appColor,
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: DefaultImage(
              AppIcons.backIcon,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DefaultImage(
                widget.image.path,
                width: 320.w,
                height: 400.h,
                fit: BoxFit.contain,
                borderRadius: BorderRadius.circular(20),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: AppButton(
                  LocalString.done,
                  width: Get.width * 0.45,
                  height: Get.height * 0.06,
                  onPressed: () {
                    Get.to(ResultView(image: File(widget.image.path)));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

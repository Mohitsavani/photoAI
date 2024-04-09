import 'dart:io';

import 'package:before_after/before_after.dart';
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
  var value = 0.5;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BeforeAfter(
                  value: value,
                  before: DefaultImage(
                    widget.image.path,
                    width: 300.w,
                    height: 370.h,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  after: DefaultImage(
                    widget.image.path,
                    width: 300.w,
                    height: 370.h,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  thumbColor: AppColors.appColor,
                  trackColor: AppColors.appColor,
                  trackWidth: 2,
                  onValueChanged: (value) {
                    setState(() => this.value = value);
                  },
                ),
              ),
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
    );
  }
}

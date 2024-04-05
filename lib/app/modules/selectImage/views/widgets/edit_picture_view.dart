import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/core/local_string.dart';
import 'package:posteriya/app/reusable/generated_scaffold.dart';

import '../../../../core/colors.dart';
import '../../../../core/typography.dart';
import '../../../../reusable/app_button/app_button.dart';
import '../../../../reusable/global_widget.dart';

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
          style: ubuntu.white,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.file(
                File(widget.image!.path),
                width: 320.w,
                height: 380.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.all(10.h),
                child: AppButton(
                  LocalString.done,
                  height: 40,
                  width: 200,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
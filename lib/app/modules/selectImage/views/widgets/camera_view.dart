import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/core/assets.dart';
import 'package:posteriya/app/core/colors.dart';
import 'package:posteriya/app/core/typography.dart';
import 'package:posteriya/app/modules/selectImage/controllers/select_image_controller.dart';
import 'package:posteriya/app/reusable/app_button/app_button.dart';
import 'package:posteriya/app/reusable/generated_scaffold.dart';

import '../../../../core/local_string.dart';
import '../../../../reusable/global_widget.dart';
import '../../../../reusable/images/default_image.dart';
import 'edit_picture_view.dart';

class CameraView extends StatelessWidget {
  final File? image;
  final SelectImageController controller = Get.put(SelectImageController());

  CameraView({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.trans,
        title: AppText(
          LocalString.imagePreview,
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                controller.cropImage(image);
              },
              child: DefaultImage(
                AppIcons.cropIcon,
                color: AppColors.appColor,
                height: 22.h,
                width: 24.w,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(() {
                return controller.croppedImage.value != null
                    ? DefaultImage(
                        controller.croppedImage.value!.path,
                        width: 300.w,
                        height: 350.h,
                        borderRadius: BorderRadius.circular(15),
                      )
                    : (image != null
                        ? DefaultImage(
                            image!.path,
                            width: 300.w,
                            height: 350.h,
                            borderRadius: BorderRadius.circular(15),
                          )
                        : AppText(LocalString.noImageSelected));
              }),
              AppButton(
                width: Get.width * 0.45,
                height: Get.height * 0.06,
                LocalString.start,
                onPressed: () {
                  Get.to(EditPictureView(
                    image: File(controller.croppedImage.value != null
                        ? controller.croppedImage.value!.path
                        : image!.path),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:posteriya/app/core/assets.dart';
import 'package:posteriya/app/core/colors.dart';
import 'package:posteriya/app/core/typography.dart';

import '../../../reusable/generated_scaffold.dart';

class ImageCropScreen extends StatelessWidget {
  final File image;

  const ImageCropScreen({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.trans,
        title: Text("Image Preview", style: ubuntu.white),
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  _cropImage();
                },
                child: Image.asset(AppIcons.cropIcon,
                    color: AppColors.white, height: 20.h)),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<ImageCropperController>(
              init: ImageCropperController(),
              builder: (controller) {
                return Image.file(
                  controller.croppedImage.value ?? File(image.path),
                  width: 450,
                  height: 450,
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality for the start button here
              },
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _cropImage() async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    if (croppedFile != null) {
      Get.find<ImageCropperController>().croppedImage.value =
          File(croppedFile.path);
    }
  }
}

class ImageCropperController extends GetxController {
  Rx<File?> croppedImage = Rx<File?>(null);
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageCroperScreen extends StatelessWidget {
  final File image;
  const ImageCroperScreen({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Preview"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigate back to previous screen
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.crop),
            onPressed: () {
              _cropImage();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<ImageCroperController>(
              init: ImageCroperController(), // Initialize GetX controller
              builder: (controller) {
                return Image.file(
                  controller.croppedImage.value ??
                      File(image.path), // Display the cropped image
                  width: 450.w,
                  height: 450.h,
                );
              },
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                // Add functionality for the start button here
              },
              child: Text('Start'),
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
      Get.find<ImageCroperController>().croppedImage.value =
          File(croppedFile.path); // Update cropped image value
    }
  }
}

class ImageCroperController extends GetxController {
  Rx<File?> croppedImage =
      Rx<File?>(null); // Reactive variable to hold cropped image file
}

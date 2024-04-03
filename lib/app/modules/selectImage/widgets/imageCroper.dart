import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageCropScreen extends StatelessWidget {
  final File image;

  const ImageCropScreen({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Preview"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.crop),
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

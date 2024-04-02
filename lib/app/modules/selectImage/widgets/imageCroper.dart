import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageCroperScreen extends StatelessWidget {
  final File image;
  const ImageCroperScreen({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              // _cropImage();
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
                  width: 200,
                  height: 200,
                );
              },
            ),
            SizedBox(height: 20),
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

  // Future<void> _cropImage() async {
  //   File? croppedFile = await ImageCropper.cropImage(
  //     sourcePath: 'assets/your_image.jpg', // Replace with your image path
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio16x9
  //     ],
  //     androidUiSettings: AndroidUiSettings(
  //         toolbarTitle: 'Crop Image',
  //         toolbarColor: Colors.deepOrange,
  //         toolbarWidgetColor: Colors.white,
  //         initAspectRatio: CropAspectRatioPreset.original,
  //         lockAspectRatio: false),
  //     iosUiSettings: IOSUiSettings(
  //       minimumAspectRatio: 1.0,
  //     ),
  //   );
  //   if (croppedFile != null) {
  //     Get.find<ImageCroperController>().croppedImage.value =
  //         croppedFile; // Update cropped image value
  //   }
  // }
}

class ImageCroperController extends GetxController {
  Rx<File?> croppedImage =
      Rx<File?>(null); // Reactive variable to hold cropped image file
}

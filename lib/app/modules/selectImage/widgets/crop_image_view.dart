import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class CropImageScreen extends StatelessWidget {
  final File image;

  const CropImageScreen({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Image'),
        centerTitle: true,
      ),
      body: Center(
        child: Image.file(image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final croppedImage = await ImageCropper().cropImage(
            sourcePath: image.path,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
          );
          if (croppedImage != null) {
            // Navigate back to the previous screen and pass the cropped image
            Get.back(result: croppedImage);
          }
        },
        child: const Icon(Icons.crop),
      ),
    );
  }
}

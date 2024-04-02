import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:posteriya/app/reusable/generated_scaffold.dart';

import '../controllers/select_image_controller.dart';

class SelectImageView extends StatelessWidget {
  const SelectImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      appBar: AppBar(
        title: const Text('Select Image'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigate back to the previous screen
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              _getImage(ImageSource.camera); // Open camera to capture image
            },
          ),
        ],
      ),
      body: GetBuilder<SelectImageController>(
        init: SelectImageController(),
        builder: (controller) {
          // Combine camera images and gallery images
          List<String> allImages = [
            ...controller.imagePaths,
            ...controller.galleryImages,
          ];

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Adjust as needed
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: allImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.file(File(allImages[index]));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      Get.find<SelectImageController>().addImagePath(pickedFile.path);
    }
  }
}

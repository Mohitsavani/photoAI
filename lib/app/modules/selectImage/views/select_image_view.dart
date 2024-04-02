import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/crop_image_view.dart';
import '../widgets/example_view.dart';
import '../widgets/gallary_view.dart';
import '../widgets/suggested_view.dart';

class SelectImageView extends StatelessWidget {
  const SelectImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Image'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () async {
                final XFile? image =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (image != null) {
                  Get.to(CropImageScreen(image: File(image.path)));
                }
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Suggested'),
              Tab(text: 'Gallery'),
              Tab(text: 'Example'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SuggestView(),
            GalleryView(),
            ExampleView(),
          ],
        ),
      ),
    );
  }
}

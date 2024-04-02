import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              Get.back(); // Navigate back to the previous screen
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () {
                // _getImage(ImageSource.camera); // Open camera to capture image
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

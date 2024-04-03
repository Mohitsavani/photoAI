import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/colors.dart';
import '../../../core/typography.dart';
import '../../../reusable/generated_scaffold.dart';
import '../widgets/example_view.dart';
import '../widgets/gallary_view.dart';
import '../widgets/imageCroper.dart';
import '../widgets/suggested_view.dart';

class SelectImageView extends StatelessWidget {
  const SelectImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.trans,
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
              onPressed: () async {
                final XFile? image =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (image != null) {
                  await _saveImage(image.path);
                  Get.to(ImageCropScreen(image: File(image.path)));
                }
              }),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: SizedBox(
          height: Get.height,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          surfaceVariant: Colors.transparent,
                        ),
                  ),
                  child: TabBar(
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      // Use the default focused overlay color
                      return states.contains(MaterialState.focused)
                          ? null
                          : Colors.transparent;
                    }),
                    unselectedLabelColor: AppColors.grey,
                    unselectedLabelStyle: ubuntu.get13.w700,
                    labelStyle: ubuntu.get13.w700,
                    labelColor: AppColors.color1,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: AppColors.trans,
                    indicatorPadding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.2.h),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                      border: Border.all(
                        color: AppColors.grey.withOpacity(0.2),
                      ),
                    ),
                    onTap: (index) {},
                    tabs: const [
                      Tab(text: 'Suggested'),
                      Tab(text: 'Gallery'),
                      Tab(text: 'Example'),
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    SuggestView(),
                    GalleryView(),
                    ExampleView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveImage(String imagePath) async {
    try {
      const String destFolder = '/storage/emulated/0/DCIM/Camera';
      final Directory destDir = Directory(destFolder);
      if (!destDir.existsSync()) {
        destDir.createSync(recursive: true);
      }
      final String fileName = imagePath.split('/').last;
      final File copiedImage =
          await File(imagePath).copy('$destFolder/$fileName');
      print('Image saved successfully at: ${copiedImage.path}');
    } catch (e) {
      print('Error saving image: $e');
    }
  }
}

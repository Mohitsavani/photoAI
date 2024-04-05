import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:posteriya/app/core/assets.dart';

import '../../../core/colors.dart';
import '../../../core/typography.dart';
import '../../../reusable/generated_scaffold.dart';
import '../controllers/select_image_controller.dart';
import '../widgets/camera_view.dart';
import '../widgets/example_view.dart';
import '../widgets/gallary_view.dart';
import '../widgets/suggested_view.dart';

class SelectImageView extends GetView<SelectImageController> {
  const SelectImageView({Key? key}) : super(key: key);

  // Function to crop the selected image

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.trans,
        title: Text(
          'Select Image',
          style: ubuntu.white,
        ),
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
                onTap: () async {
                  final XFile? image =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (image != null) {
                    await controller.saveImage(image.path);
                    Get.to(CameraView(image: File(image.path)));
                  }
                },
                child: Image.asset(
                  AppIcons.camera,
                  color: AppColors.white,
                  height: 20.h,
                )),
          )
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
                    unselectedLabelColor: AppColors.black,
                    unselectedLabelStyle: ubuntu.get13.w700,
                    labelStyle: ubuntu.get13.w700,
                    labelColor: AppColors.black,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: AppColors.trans,
                    indicatorPadding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.2.h),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.appColor,
                          AppColors.white,
                        ],
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
                  physics: NeverScrollableScrollPhysics(),
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
}

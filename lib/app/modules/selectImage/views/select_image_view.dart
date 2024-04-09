import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:posteriya/app/core/assets.dart';
import 'package:posteriya/app/modules/selectImage/views/widgets/camera_view.dart';
import 'package:posteriya/app/modules/selectImage/views/widgets/example_view.dart';
import 'package:posteriya/app/modules/selectImage/views/widgets/gallary_view.dart';
import 'package:posteriya/app/modules/selectImage/views/widgets/suggested_view.dart';

import '../../../core/colors.dart';
import '../../../core/local_string.dart';
import '../../../core/typography.dart';
import '../../../reusable/generated_scaffold.dart';
import '../../../reusable/global_widget.dart';
import '../../../reusable/images/default_image.dart';
import '../controllers/select_image_controller.dart';

class SelectImageView extends GetView<SelectImageController> {
  const SelectImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectImageController>(
      init: SelectImageController(),
      builder: (controller) => appScaffold(
        appBar: AppBar(
          backgroundColor: AppColors.trans,
          title: AppText(
            LocalString.selectImage,
            style: ubuntu.appColor,
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: DefaultImage(
                AppIcons.backIcon,
              ),
            ),
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
                child: DefaultImage(
                  AppIcons.camera,
                  color: AppColors.appColor,
                  height: 19.h,
                  width: 23.w,
                ),
              ),
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
                        return states.contains(MaterialState.focused)
                            ? null
                            : Colors.transparent;
                      }),
                      unselectedLabelColor: AppColors.black,
                      unselectedLabelStyle: ubuntu.get13.w700,
                      labelStyle: ubuntu.get13.w700,
                      labelColor: AppColors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: AppColors.trans,
                      indicatorPadding: EdgeInsets.symmetric(
                          horizontal: 3.w, vertical: 0.2.h),
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.appColor),
                      onTap: (index) {},
                      tabs: [
                        Tab(text: LocalString.suggested),
                        Tab(text: LocalString.gallery),
                        Tab(text: LocalString.example),
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
      ),
    );
  }
}

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
import '../controllers/select_image_controller.dart';

class SelectImageView extends StatelessWidget {
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
            style: ubuntu.white,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.white,
            ),
            onPressed: () {
              Get.back(); // Navigate back to the previous screen
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
                    Get.find<SelectImageController>().saveImage(image.path);
                    Get.to(CameraView(image: File(image.path)));
                  }
                },
                child: Image.asset(
                  AppIcons.camera,
                  color: AppColors.white,
                  height: 20.h,
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
                      labelColor: AppColors.black,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: AppColors.trans,
                      indicatorPadding: EdgeInsets.symmetric(
                          horizontal: 3.w, vertical: 0.2.h),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.color1,
                            AppColors.white,
                          ],
                        ),
                      ),
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/core/colors.dart';
import 'package:posteriya/app/core/local_string.dart';

import '../../../core/assets.dart';
import '../../../reusable/global_widget.dart';
import '../../../reusable/images/default_image.dart';
import '../controllers/ai_effect_tab_controller.dart';

class AiEffectTabView extends GetView<AiEffectTabController> {
  const AiEffectTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AiEffectTabController());

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.5.h, vertical: 1.h),
      child: Obx(() {
        if (controller.downloadList.isNotEmpty) {
          return SingleChildScrollView(
            child: Column(
              children: [
                if (controller.isLoaded.isTrue) ...[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 10 / 16,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                      ),
                      itemCount: controller.downloadList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => controller.showImageDialog(
                            context,
                            controller.downloadList[index].image!,
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  File(controller.downloadList[index].image!),
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.low,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 5),
                                  decoration: BoxDecoration(
                                      color:
                                          AppColors.appColor.withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50.0))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            controller
                                                .showDeleteConfirmationDialog(
                                                    controller
                                                        .downloadList[index]
                                                        .image!);
                                          },
                                          child: DefaultImage(
                                            AppIcons.delete,
                                            color: AppColors.white,
                                            height: 18.h,
                                            width: 22.w,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.shareOn(controller
                                                .downloadList[index].image!);
                                          },
                                          child: DefaultImage(
                                            AppIcons.share,
                                            color: AppColors.white,
                                            height: 19.h,
                                            width: 21.w,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ] else ...[
                  Padding(
                    padding:
                        EdgeInsets.only(top: 1.h, right: 0.5.h, left: 0.5.h),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1 / 1,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return const SimmerLoader(
                          radius: 15,
                        );
                      },
                    ),
                  ),
                ]
              ],
            ),
          );
        } else {
          return Center(child: AppText(LocalString.noDataFound));
        }
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/core/assets.dart';
import 'package:posteriya/app/core/colors.dart';

import '../../../core/constant.dart';
import '../../../core/local_string.dart';
import '../../../core/typography.dart';
import '../../../reusable/generated_scaffold.dart';
import '../../../reusable/global_widget.dart';
import '../../../reusable/google_add/google_advertise_repo/advertise_repo.dart';
import '../../../reusable/images/default_image.dart';
import '../../../uttils/globle_uttils.dart';
import '../../selectImage/views/select_image_view.dart';
import '../controllers/ai_effect_controller.dart';

class AiEffectView extends GetView<AiEffectController> {
  final int currentIndex;
  const AiEffectView({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            GoogleAdd.getInstance().showNative(isSmall: true),
            Padding(
              padding: EdgeInsets.only(bottom: 25.h),
              child: ListView.builder(
                shrinkWrap: true, // Add this line
                physics: const NeverScrollableScrollPhysics(), // Add this line
                itemCount: aiEffectDataList.length,
                itemBuilder: (context, index) {
                  return _buildListItem(context, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //==============================================================================
  // ** Helper Widgets **
  //==============================================================================

  Widget _buildListItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        showInter(callBack: () {
          Get.to(() => SelectImageView(
                currentIndex: currentIndex,
                effectName: aiEffectDataList[index]['name'],
              ));
        });
      },
      child: SizedBox(
        height: Get.height * 0.26,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: NetWorkImage(
                  aiEffectDataList[index]['Image'] ?? "",
                  fit: BoxFit.cover, // Adjust image fit
                ),
              ),
              Positioned(
                bottom: 5,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      aiEffectDataEditList[index]['name'],
                      style: ubuntu.get15.black.bold,
                    ),
                    AppText(
                      LocalString.subtitle,
                      style: ubuntu.black.get12.w500,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 12,
                right: 8,
                child: DefaultImage(
                  AppIcons.forWordIcon,
                  color: AppColors.white,
                  height: 15.h,
                  width: 19.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

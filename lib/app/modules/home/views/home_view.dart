import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/modules/selectImage/views/select_image_view.dart';

import '../../../core/assets.dart';
import '../../../core/colors.dart';
import '../../../core/constant.dart';
import '../../../core/local_string.dart';
import '../../../core/typography.dart';
import '../../../reusable/generated_scaffold.dart';
import '../../../reusable/global_widget.dart';
import '../../../reusable/images/default_image.dart';

class HomeView extends StatelessWidget {
  final int currentIndex;
  const HomeView({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 25.h),
        child: ListView.builder(
          itemCount: freeDataList.length,
          itemBuilder: (context, index) {
            return _buildListItem(context, index);
          },
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
        Get.to(() => SelectImageView(
              currentIndex: currentIndex,
              effectName: freeDataList[index]['name'],
            ));
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
                  freeDataList[index]['Image'] ?? "",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      freeDataList[index]['name'],
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
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

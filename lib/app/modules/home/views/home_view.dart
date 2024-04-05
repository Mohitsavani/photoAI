import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/modules/selectImage/views/select_image_view.dart';

import '../../../core/assets.dart';
import '../../../core/colors.dart';
import '../../../core/local_string.dart';
import '../../../core/typography.dart';
import '../../../reusable/generated_scaffold.dart';
import '../../../reusable/global_widget.dart';
import '../../../reusable/images/default_image.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 25.h),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return _buildListItem(context);
          },
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const SelectImageView());
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
                child: const NetWorkImage(
                  'https://images.unsplash.com/photo-1712041503216-c466cee9c845?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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
                      LocalString.title,
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
                    height: 20.h,
                    width: 22.w,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

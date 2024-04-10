import 'dart:io';

import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/modules/selectImage/views/widgets/result_view.dart';
import 'package:posteriya/app/reusable/generated_scaffold.dart';

import '../../../../core/assets.dart';
import '../../../../core/colors.dart';
import '../../../../core/constant.dart';
import '../../../../core/local_string.dart';
import '../../../../core/typography.dart';
import '../../../../reusable/app_button/app_button.dart';
import '../../../../reusable/global_widget.dart';
import '../../../../reusable/images/default_image.dart';

class EditPictureView extends StatefulWidget {
  final int currentIndex;
  final File image;
  const EditPictureView(
      {Key? key, required this.image, required this.currentIndex})
      : super(key: key);

  @override
  State<EditPictureView> createState() => _EditPictureViewState();
}

class _EditPictureViewState extends State<EditPictureView> {
  var value = 0.5;
  @override
  Widget build(BuildContext context) {
    return appScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.trans,
        title: AppText(
          LocalString.editPicture,
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BeforeAfter(
                  value: value,
                  before: DefaultImage(
                    widget.image.path,
                    width: 300.w,
                    height: 370.h,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  after: DefaultImage(
                    widget.image.path,
                    width: 300.w,
                    height: 370.h,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  trackColor: AppColors.white,
                  trackWidth: 2,
                  thumbDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(50)),
                  onValueChanged: (value) {
                    setState(() => this.value = value);
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: SizedBox(
                height: 75.h, // Adjust height as per your requirement
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.currentIndex == 0
                      ? aiEffectDataList.length
                      : freeDataList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Handle tap on the list tile
                        print('Tapped on ${freeDataList[index]['name']}');
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: AppColors.appColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: DefaultImage(
                                  widget.currentIndex == 0
                                      ? aiEffectDataList[index]['icon']
                                      : freeDataList[index]['icon'],
                                  color: AppColors.white,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                              SizedBox(
                                width: 67.w,
                                child: Text(
                                  widget.currentIndex == 0
                                      ? aiEffectDataList[index]['name']
                                      : freeDataList[index]['name']
                                          .toString(), // Adding the text here
                                  textAlign: TextAlign.center,
                                  style: ubuntu.white.get11.bold.space04,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: AppButton(
                LocalString.done,
                width: Get.width * 0.45,
                height: Get.height * 0.06,
                onPressed: () {
                  Get.to(ResultView(image: File(widget.image.path)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

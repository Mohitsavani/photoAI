import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart'; // Import image_cropper package
import 'package:posteriya/app/core/assets.dart';
import 'package:posteriya/app/core/colors.dart';
import 'package:posteriya/app/core/typography.dart';
import 'package:posteriya/app/reusable/generated_scaffold.dart';

import '../../../reusable/app_button/app_button.dart';

class CameraView extends StatefulWidget {
  final File? image;

  const CameraView({Key? key, this.image}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CroppedFile? _croppedImage; // Adjusted type to CroppedFile?

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.trans,
        title: Text(
          "Image Preview",
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
                onTap: () {
                  _cropImage();
                },
                child: Image.asset(AppIcons.cropIcon,
                    color: AppColors.white, height: 20.h)),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _croppedImage != null
                  ? Image.file(
                      File(_croppedImage!
                          .path), // Display the cropped image if available
                      width: 300.w,
                      height: 350.h,
                    )
                  : (widget.image != null
                      ? Image.file(
                          widget.image!,
                          width: 300.w,
                          height: 350.h,
                        )
                      : const Text('No image selected')),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.all(10.h),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.color2),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.h),
                    child: const Text(
                      'Start',
                      style: TextStyle(color: AppColors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to crop the image
  Future<void> _cropImage() async {
    if (widget.image == null) return;

    CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: widget.image!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );

    if (cropped != null) {
      setState(() {
        _croppedImage = cropped; // Set the cropped image to the state
      });
    }
  }
}

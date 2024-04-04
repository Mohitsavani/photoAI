import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart'; // Import image_cropper package
import 'package:posteriya/app/core/assets.dart';
import 'package:posteriya/app/core/colors.dart';
import 'package:posteriya/app/reusable/generated_scaffold.dart';

import '../../../reusable/app_button/app_button.dart';

class CameraView extends StatefulWidget {
  final File? image;

  const CameraView({Key? key, this.image}) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CroppedFile? _croppedImage; // Adjusted type to CroppedFile?

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.trans,
        title: Text("Image Preview"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                _cropImage(); // Call the image cropping function when icon button is pressed
              },
              icon: Image.asset(
                AppIcons.cropIcon,
                height: 20.h,
              )),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _croppedImage != null
                ? Image.file(
                    File(_croppedImage!
                        .path), // Display the cropped image if available
                    width: 450.w,
                    height: 450.h,
                  )
                : (widget.image != null
                    ? Image.file(
                        widget.image!,
                        width: 450.w,
                        height: 450.h,
                      )
                    : Text('No image selected')),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.all(10.h),
              child: AppButton(
                'Start',
                onPressed: () {},
              ),
            ),
          ],
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

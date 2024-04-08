import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cr_file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:posteriya/app/core/local_string.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/assets.dart';
import '../../../../core/colors.dart';
import '../../../../core/typography.dart';
import '../../../../reusable/generated_scaffold.dart';
import '../../../../reusable/global_widget.dart';
import '../../../../reusable/images/default_image.dart';
import '../../../../routes/app_pages.dart';

class ResultView extends StatefulWidget {
  final File? image;
  const ResultView({super.key, this.image});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  Widget build(BuildContext context) {
    return appScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.trans,
        title: AppText(
          LocalString.result,
          style: ubuntu.white,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.appColor,
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
                  Get.offAllNamed(Routes.DASHBOARD);
                },
                child: DefaultImage(
                  AppIcons.home,
                  color: AppColors.appColor,
                  height: 22.h,
                  width: 26.w,
                )),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: Get.height * 0.08,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.appColor.withOpacity(0.3)),
          color: AppColors.appColor,
          // borderRadius: BorderRadius.circular(40), // Add this line
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                downloadImage(widget.image!.path, context);
              },
              child: DefaultImage(
                AppIcons.download,
                color: AppColors.white,
                height: 25.h,
                width: 28.w,
              ),
            ),
            GestureDetector(
              onTap: () {
                shareOn(widget.image!.path);
              },
              child: DefaultImage(
                AppIcons.share,
                color: AppColors.white,
                height: 25.h,
                width: 27.w,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultImage(
              widget.image!.path,
              width: 320.w,
              height: 380.h,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  void shareOn(String imgPath) async {
    if (imgPath.isNotEmpty) {
      final file = File(imgPath);
      if (await file.exists()) {
        final directory = await getTemporaryDirectory();
        final imageFileName = imgPath.split('/').last;
        final newImagePath = '${directory.path}/$imageFileName';
        await file.copy(newImagePath);

        const chatMsg = "Photo AI";
        Share.shareFiles([newImagePath], text: chatMsg);
      } else {
        showToast("Image file not found");
      }
    } else {
      showToast("Image path is null or empty");
    }
  }

  Future<void> downloadImage(String imagePath, BuildContext context) async {
    final granted = await CRFileSaver.requestWriteExternalStoragePermission();
    if (granted) {
      log('requestWriteExternalStoragePermission: $granted');
      try {
        final originalImageFile = File(imagePath);
        Uint8List bytes = await originalImageFile.readAsBytes();
        final galleryPath = await getGalleryPath();
        final imageFileName = imagePath.split('/').last;
        final newImagePath = '$galleryPath/$imageFileName';
        await File(newImagePath).writeAsBytes(bytes);
        showToast("Image Downloaded Successfully");
      } catch (e) {
        showToast("Failed to download image");
      }
    } else {
      showToast("Permission denied to access storage");
    }
  }

  Future<String> getGalleryPath() async {
    if (Platform.isAndroid) {
      final directory = Directory('/storage/emulated/0/Pictures/PhotoAI');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      return directory.path;
    } else if (Platform.isIOS) {
      throw Exception("iOS gallery path not implemented");
    } else {
      throw Exception("Unsupported platform");
    }
  }
}

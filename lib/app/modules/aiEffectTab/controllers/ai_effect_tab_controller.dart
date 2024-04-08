import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:posteriya/app/core/local_string.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/colors.dart';
import '../../../reusable/global_widget.dart';

class DownloadData {
  final String? image;
  final String? videoPath;
  final Uint8List? thumbnail;
  DownloadData({this.image, this.videoPath, this.thumbnail});
}

class AiEffectTabController extends GetxController {
  final Directory directory = Directory('/storage/emulated/0/Pictures/PhotoAI');
  RxList<DownloadData> downloadList = <DownloadData>[].obs;
  var isLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    getStatusData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getStatusData() async {
    if (directory.existsSync()) {
      isLoaded(false);
      List<FileSystemEntity> files = directory.listSync();
      files.sort((a, b) => b.path.compareTo(a.path));
      downloadList.clear();
      for (var file in files) {
        if (file.path.endsWith('.jpg')) {
          downloadList.add(DownloadData(image: file.path));
        }
      }
      isLoaded(true);
    }
  }

  void shareOn(String imgPath) async {
    if (imgPath.isNotEmpty) {
      final file = File(imgPath);
      if (await file.exists()) {
        final directory = await getTemporaryDirectory();
        final imageFileName = imgPath.split('/').last;
        final newImagePath = '${directory.path}/$imageFileName';
        await file.copy(newImagePath);

        const chatMsg = "Posteriya AI Generator";
        Share.shareFiles([newImagePath], text: chatMsg);
      } else {
        showToast("Image file not found");
      }
    } else {
      showToast("Image path is null or empty");
    }
  }

  void showDeleteConfirmationDialog(String filePath) {
    final file = File(filePath);

    // Check if the file exists before proceeding
    if (!file.existsSync()) {
      showToast("File does not exist");
      return;
    }

    Get.dialog(
      AlertDialog(
        title: AppText(LocalString.confirmDelete),
        content: AppText(LocalString.deleteMsg),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: AppText(LocalString.no),
          ),
          TextButton(
            onPressed: () {
              // Check again if the file exists before attempting to delete it
              if (file.existsSync()) {
                try {
                  file.deleteSync();
                  showToast("File deleted successfully");
                  getStatusData();
                  Get.back();
                  Get.back();
                } catch (e) {
                  showToast("Failed to delete file");
                }
              } else {
                showToast("File does not exist");
              }
            },
            child: AppText(LocalString.yes),
          ),
        ],
      ),
    );
  }

  void showImageDialog(BuildContext context, String imagePath) {
    final Size size = MediaQuery.of(context).size;
    final double dialogWidth = size.width * 0.8;
    final double dialogHeight = size.height * 0.6;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: const BoxDecoration(color: AppColors.appColor),
            width: dialogWidth,
            height: dialogHeight,
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

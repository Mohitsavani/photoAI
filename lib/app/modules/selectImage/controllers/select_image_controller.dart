import 'dart:io';

import 'package:get/get.dart';

import '../../../uttils/globle_uttils.dart';

class SelectImageController extends GetxController {
  RxList<String> imagePaths = <String>[].obs;
  RxString selectedImagePath = ''.obs;
  RxList<String> galleryImages = <String>[].obs;

  void addImagePath(String path) {
    imagePaths.add(path);
    selectedImagePath.value = path;
  }

  void addGalleryImage(String path) {
    galleryImages.add(path);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> saveImage(String imagePath) async {
    try {
      const String destFolder = '/storage/emulated/0/DCIM/Camera';
      final Directory destDir = Directory(destFolder);
      if (!destDir.existsSync()) {
        destDir.createSync(recursive: true);
      }
      final String fileName = imagePath.split('/').last;
      final File copiedImage =
          await File(imagePath).copy('$destFolder/$fileName');
      appPrint('Image saved successfully at: ${copiedImage.path}');
    } catch (e) {
      appPrint('Error saving image: $e');
    }
  }
}

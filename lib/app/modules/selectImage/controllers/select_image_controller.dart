import 'dart:io';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class SelectImageController extends GetxController {
  RxList<String> imagePaths = <String>[].obs;
  RxString selectedImagePath = ''.obs;
  RxList<String> galleryImages = <String>[].obs;
  Rx<CroppedFile?> croppedImage = Rx<CroppedFile?>(null);

  void addImagePath(String path) {
    imagePaths.add(path);
    selectedImagePath.value = path;
  }

  void addGalleryImage(String path) {
    galleryImages.add(path);
  }

  saveImage(String imagePath) async {
    try {
      const String destFolder = '/storage/emulated/0/DCIM/Camera';
      final Directory destDir = Directory(destFolder);
      if (!destDir.existsSync()) {
        destDir.createSync(recursive: true);
      }
      final String fileName = imagePath.split('/').last;
      final File copiedImage =
          await File(imagePath).copy('$destFolder/$fileName');
      print('Image saved successfully at: ${copiedImage.path}');
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  Future<void> cropImage(File? image) async {
    if (image == null) return;

    CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );

    if (cropped != null) {
      croppedImage.value = cropped;
    }
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
}

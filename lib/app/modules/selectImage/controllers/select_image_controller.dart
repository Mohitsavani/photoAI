import 'package:get/get.dart';

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
}

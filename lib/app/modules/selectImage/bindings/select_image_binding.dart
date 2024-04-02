import 'package:get/get.dart';

import '../controllers/select_image_controller.dart';

class SelectImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectImageController>(
      () => SelectImageController(),
    );
  }
}

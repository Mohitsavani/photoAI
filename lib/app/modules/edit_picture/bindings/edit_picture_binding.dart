import 'package:get/get.dart';

import '../controllers/edit_picture_controller.dart';

class EditPictureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPictureController>(
      () => EditPictureController(),
    );
  }
}

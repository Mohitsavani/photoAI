import 'package:get/get.dart';

import '../controllers/freetab_controller.dart';

class FreetabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FreetabController>(
      () => FreetabController(),
    );
  }
}

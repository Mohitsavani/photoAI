import 'package:get/get.dart';

import '../../reusable/google_add/google_add_config_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GoogleAddConfigController(), permanent: true);
  }
}

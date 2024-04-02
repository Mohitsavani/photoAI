import 'package:get/get.dart';

import '../controllers/vault_controller.dart';

class VaultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VaultController>(
      () => VaultController(),
    );
  }
}

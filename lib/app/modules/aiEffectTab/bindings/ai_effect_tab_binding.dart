import 'package:get/get.dart';

import '../controllers/ai_effect_tab_controller.dart';

class AiEffectTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AiEffectTabController>(
      () => AiEffectTabController(),
    );
  }
}

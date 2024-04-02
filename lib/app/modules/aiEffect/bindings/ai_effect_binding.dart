import 'package:get/get.dart';

import '../controllers/ai_effect_controller.dart';

class AiEffectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AiEffectController>(
      () => AiEffectController(),
    );
  }
}

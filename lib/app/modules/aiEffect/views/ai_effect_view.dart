import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../reusable/generated_scaffold.dart';
import '../controllers/ai_effect_controller.dart';

class AiEffectView extends GetView<AiEffectController> {
  const AiEffectView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return appScaffold();
  }
}

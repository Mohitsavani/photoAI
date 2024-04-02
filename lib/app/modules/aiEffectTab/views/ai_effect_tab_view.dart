import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/reusable/no_data_screen.dart';

import '../controllers/ai_effect_tab_controller.dart';

class AiEffectTabView extends GetView<AiEffectTabController> {
  const AiEffectTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NoData();
  }
}

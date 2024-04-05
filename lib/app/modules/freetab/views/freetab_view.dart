import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/reusable/no_data_screen.dart';

import '../controllers/freetab_controller.dart';

class FreeTabView extends GetView<FreetabController> {
  const FreeTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const NoData();
  }
}

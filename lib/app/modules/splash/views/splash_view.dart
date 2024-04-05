import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/reusable/generated_scaffold.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return appScaffold();
  }
}

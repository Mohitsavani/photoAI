import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/colors.dart';
import '../../../uttils/fade_widget.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                AppColors.color1,
                AppColors.white,
              ])),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const FadeWidget(
              child: SizedBox(),
              // child: Image.asset(
              //   AppIcons.home,
              //   height: height / 1.95,
              //   width: width,
              //   fit: BoxFit.fill,
              // ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.02),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05, vertical: height * 0.02),
                    child: LinearProgressIndicator(
                      minHeight: 5,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: AppColors.color1,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(AppColors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }
}

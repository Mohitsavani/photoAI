import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/reusable/generated_scaffold.dart';

import '../../../core/assets.dart';
import '../../../reusable/images/default_image.dart';
import '../controllers/purchase_controller.dart';

class PurchaseView extends GetView<PurchaseController> {
  const PurchaseView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return appScaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: DefaultImage(
              AppIcons.backIcon,
            ),
          ),
        ),
        flexibleSpace: Stack(
          children: [
            // Image in the app bar
            Positioned.fill(
              top: 0,
              child: Image.network(
                'https://images.unsplash.com/photo-1712315481738-a77f7f78f2cb?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Replace with your image path
                fit: BoxFit.cover,
                height: 100.h,
              ),
            ),
            // Optional: You can add other widgets over the image if needed
          ],
        ),
      ),
    );
  }
}

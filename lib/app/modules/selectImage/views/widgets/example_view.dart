import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/reusable/generated_scaffold.dart';

import '../../../../core/constant.dart';
import '../../../../reusable/google_add/google_advertise_repo/advertise_repo.dart';
import '../../../../reusable/images/default_image.dart';
import 'camera_view.dart';

class ExampleView extends StatefulWidget {
  final int currentIndex;
  final String effectName;
  const ExampleView(
      {super.key, required this.currentIndex, required this.effectName});

  @override
  State<ExampleView> createState() => _ExampleViewState();
}

class _ExampleViewState extends State<ExampleView> {
  @override
  Widget build(BuildContext context) {
    return appScaffold(
      body: Column(
        children: [
          GoogleAdd.getInstance().showNative(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: exampleData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 6.5.h,
                crossAxisSpacing: 6.5.h,
                childAspectRatio: 9 / 12,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(CameraView(
                        image: exampleData[index]['Image'],
                        currentIndex: 0,
                        effectName: ''));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: NetWorkImage(
                      exampleData[index]['Image'] ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

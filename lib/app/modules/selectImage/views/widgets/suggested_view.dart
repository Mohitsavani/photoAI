import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:posteriya/app/core/local_string.dart';

import '../../../../reusable/global_widget.dart';
import '../../../../reusable/images/default_image.dart';
import 'camera_view.dart';

class SuggestView extends StatefulWidget {
  const SuggestView({super.key});

  @override
  State<SuggestView> createState() => _SuggestViewState();
}

class _SuggestViewState extends State<SuggestView> {
  final Directory photoDirectory = Directory('/storage/emulated/0/DCIM/Camera');
  RxList<String> imageList = <String>[].obs;
  var isLoaded = false.obs;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  Future<int> requestPermission() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt >= 30) {
      final requestStatusManaged =
          await Permission.manageExternalStorage.request();
      if (requestStatusManaged.isGranted) {
        await getStatusData();
        return 1;
      } else {
        return 0;
      }
    } else {
      final requestStatusStorage = await Permission.storage.request();
      if (requestStatusStorage.isGranted) {
        await getStatusData();
        return 1;
      } else {
        return 0;
      }
    }
  }

  Future<void> getStatusData() async {
    if (Directory(photoDirectory.path).existsSync()) {
      isLoaded(false);
      imageList.value = photoDirectory
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith('.jpg'))
          .toList(growable: false)
        ..sort((a, b) => b.compareTo(a)); // Sort in descending order
      isLoaded(true);
    }
  }

  bool isSuggest() {
    if (!Directory(photoDirectory.path).existsSync()) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isSuggest()) {
      return Obx(() {
        if (isLoaded.isTrue) {
          if (imageList.isNotEmpty) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.h, vertical: 10.h),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 9 / 12,
                            crossAxisSpacing: 6.5.h,
                            mainAxisSpacing: 6.5.h),
                        itemCount: imageList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String imgPath = imageList[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(CameraView(image: File(imgPath)));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: DefaultImage(
                                imgPath.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      )),
                ],
              ),
            );
          } else {
            return Center(child: AppText(LocalString.noDataFound));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      });
    } else {
      return Center(child: AppText(LocalString.noDataFound));
    }
  }
}

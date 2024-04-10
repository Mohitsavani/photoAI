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
  final int currentIndex;
  final String effectName;
  const SuggestView(
      {super.key, required this.currentIndex, required this.effectName});

  @override
  State<SuggestView> createState() => _SuggestViewState();
}

class _SuggestViewState extends State<SuggestView> {
  final Directory photoDirectory = Directory('/storage/emulated/0/DCIM/Camera');
  final Directory photoDirectoryCamera =
      Directory('/storage/emulated/0/Pictures/');
  RxList<String> imageList = <String>[].obs;
  var isLoaded = false.obs;

  @override
  void initState() {
    super.initState();
    requestPermission().then((value) {
      getStatusData();
    });
  }

  Future<int> requestPermission() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt >= 34) {
      final requestStatusManaged =
          await Permission.manageExternalStorage.request();
      if (requestStatusManaged.isGranted) {
        return 1;
      } else {
        return 0;
      }
    } else {
      final requestStatusStorage = await Permission.storage.request();
      if (requestStatusStorage.isGranted) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  Future<void> getStatusData() async {
    final List<String> allImagePaths = [];

    if (photoDirectory.existsSync()) {
      allImagePaths.addAll(photoDirectory
          .listSync()
          .where((item) => item.path.toLowerCase().endsWith('.jpg'))
          .map((item) => item.path));
    }

    if (photoDirectoryCamera.existsSync()) {
      allImagePaths.addAll(photoDirectoryCamera
          .listSync()
          .where((item) => item.path.toLowerCase().endsWith('.jpg'))
          .map((item) => item.path));
    }

    if (allImagePaths.isNotEmpty) {
      isLoaded(false);
      imageList.assignAll(allImagePaths);
      isLoaded(true);
    }
  }

  bool isSuggest() {
    if (!Directory(photoDirectory.path).existsSync() ||
        !Directory(photoDirectoryCamera.path).existsSync()) {
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
                              Get.to(CameraView(
                                  image: File(imgPath),
                                  currentIndex: widget.currentIndex,
                                  effectName: widget.effectName));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: DefaultImage(
                                imgPath.toString(),
                                fit: BoxFit.contain,
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

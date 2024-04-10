import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../reusable/global_widget.dart';
import 'camera_view.dart';

class GalleryView extends StatefulWidget {
  final int currentIndex;
  final String effectName;
  const GalleryView(
      {super.key, required this.currentIndex, required this.effectName});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  final ImagePicker _picker = ImagePicker();
  List<File> imageFiles = [];

  @override
  void initState() {
    _getImageFromGallery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Empty();
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFiles.add(File(pickedFile.path));
      });
      Get.to(CameraView(
        image: File(pickedFile.path),
        currentIndex: widget.currentIndex,
        effectName: widget.effectName,
      ));
    }
  }
}

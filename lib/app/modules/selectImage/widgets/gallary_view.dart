import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'imageCroper.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  final ImagePicker _picker = ImagePicker();
  List<File> _imageFiles = [];

  @override
  void initState() {
    _getImageFromGallery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFiles.add(File(pickedFile.path));
      });
      Get.to(ImageCropScreen(image: File(pickedFile.path)));
    }
  }
}

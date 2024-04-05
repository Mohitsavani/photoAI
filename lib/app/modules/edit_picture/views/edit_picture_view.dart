import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_picture_controller.dart';

class EditPictureView extends GetView<EditPictureController> {
  const EditPictureView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditPictureView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditPictureView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/local_string.dart';
import '../../../reusable/global_widget.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(LocalString.profileView),
        centerTitle: true,
      ),
      body: Center(
        child: AppText(
          LocalString.profileIsWorking,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

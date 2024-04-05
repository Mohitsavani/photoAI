import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResultView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ResultView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

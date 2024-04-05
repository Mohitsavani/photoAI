import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/local_string.dart';
import '../../../reusable/global_widget.dart';
import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(LocalString.resultView),
        centerTitle: true,
      ),
      body: const Center(),
    );
  }
}

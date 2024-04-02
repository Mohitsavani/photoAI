import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../reusable/generated_scaffold.dart';
import '../controllers/vault_controller.dart';

class VaultView extends GetView<VaultController> {
  const VaultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return appScaffold();
  }
}

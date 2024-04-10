import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/core/assets.dart';
import 'package:posteriya/app/core/local_string.dart';
import 'package:posteriya/app/core/typography.dart';
import 'package:posteriya/app/reusable/app_button/app_button.dart';

import '../../../core/colors.dart';
import '../../../reusable/global_widget.dart';
import '../../../routes/app_pages.dart';
import '../../aiEffect/bindings/ai_effect_binding.dart';
import '../../aiEffect/views/ai_effect_view.dart';
import '../../home/bindings/home_binding.dart';
import '../../home/views/home_view.dart';
import '../../vault/bindings/vault_binding.dart';
import '../../vault/views/vault_view.dart';

class DashBordItem {
  final String icon;
  final String title;
  DashBordItem({required this.icon, required this.title});
}

class DashboardController extends GetxController {
  var currentIndex = 0.obs;
  late PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  List<DashBordItem> dashBordItemList = [
    DashBordItem(icon: AppIcons.AIEffects, title: LocalString.aieffect),
    DashBordItem(icon: AppIcons.free, title: LocalString.free),
    DashBordItem(icon: AppIcons.vault, title: LocalString.vault)
  ];

  List<Widget> screenWidgets() {
    final currentIndexValue = currentIndex.value;

    return [
      Navigator(
        initialRoute: Routes.AI_EFFECT,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case Routes.AI_EFFECT:
              return GetPageRoute(
                routeName: Routes.AI_EFFECT,
                page: () => AiEffectView(currentIndex: currentIndexValue),
                binding: AiEffectBinding(),
              );
            default:
              return null;
          }
        },
      ),
      Navigator(
        initialRoute: Routes.HOME,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case Routes.HOME:
              return GetPageRoute(
                routeName: Routes.HOME,
                page: () => HomeView(currentIndex: currentIndexValue),
                binding: HomeBinding(),
              );
            default:
              return null;
          }
        },
      ),
      Navigator(
        initialRoute: Routes.VAULT,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case Routes.VAULT:
              return GetPageRoute(
                routeName: Routes.VAULT,
                page: () => const VaultView(),
                binding: VaultBinding(),
              );
            default:
              return null;
          }
        },
      ),
    ];
  }

  Future<void> changePage(int index) async {
    await pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    pageController.jumpToPage(index);
  }

  List<String> titles = ['AIEffect', 'Home', 'Vault'];
  Widget buildBottomSheet(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(23.0),
          child: AppText(
            LocalString.exitWarning,
            style: ubuntu.get15.appColor.space02,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            AppButton(
              width: Get.width * 0.26,
              height: Get.height * 0.05,
              LocalString.no,
              onPressed: () {
                Get.back();
              },
            ),
            AppButton(
              width: Get.width * 0.26,
              height: Get.height * 0.05,
              LocalString.yes,
              onPressed: () {
                Get.back();
                exit(0);
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<bool> onWillPop(BuildContext context) async {
    bool? exitResult = await _showExitBottomSheet(context);
    return exitResult ?? false;
  }

  Future<bool?> _showExitBottomSheet(BuildContext context) async {
    return await showModalBottomSheet(
      backgroundColor: AppColors.trans,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppColors.xfff9f5fc,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: buildBottomSheet(context),
        );
      },
    );
  }
}

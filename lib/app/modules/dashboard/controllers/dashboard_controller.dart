import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../aiEffect/bindings/ai_effect_binding.dart';
import '../../aiEffect/views/ai_effect_view.dart';
import '../../home/bindings/home_binding.dart';
import '../../home/views/home_view.dart';
import '../../vault/bindings/vault_binding.dart';
import '../../vault/views/vault_view.dart';

class DashBordItem{
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


  List<DashBordItem> dashBordItemList =[
    DashBordItem(icon: "assets/icons/Effects.png" ,title: "AI Effects"),
    DashBordItem(icon: "assets/icons/free.png" ,title: "Free"),
    DashBordItem(icon: "assets/icons/vault.png" ,title: "Vault")


  ];

  List<Widget> screenWidgets = [
    Navigator(
      initialRoute: Routes.AI_EFFECT,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.AI_EFFECT:
            return GetPageRoute(
              routeName: Routes.AI_EFFECT,
              page: () => const AiEffectView(),
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
              page: () => const HomeView(),
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

  Future<void> changePage(int index) async {
    await pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    pageController.jumpToPage(index);
  }

  List<String> titles = ['AIEffect', 'Home', 'Vault'];
}

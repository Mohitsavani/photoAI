import 'package:get/get.dart';

import '../modules/aiEffect/bindings/ai_effect_binding.dart';
import '../modules/aiEffect/views/ai_effect_view.dart';
import '../modules/aiEffectTab/bindings/ai_effect_tab_binding.dart';
import '../modules/aiEffectTab/views/ai_effect_tab_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/freetab/bindings/freetab_binding.dart';
import '../modules/freetab/views/freetab_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/selectImage/bindings/select_image_binding.dart';
import '../modules/selectImage/views/select_image_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/vault/bindings/vault_binding.dart';
import '../modules/vault/views/vault_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(currentIndex: 1),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.AI_EFFECT,
      page: () => const AiEffectView(currentIndex: 0),
      binding: AiEffectBinding(),
    ),
    GetPage(
      name: _Paths.VAULT,
      page: () => const VaultView(),
      binding: VaultBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_IMAGE,
      page: () => const SelectImageView(
        currentIndex: 0,
        effectName: '',
      ),
      binding: SelectImageBinding(),
    ),
    GetPage(
      name: _Paths.FREETAB,
      page: () => const FreeTabView(),
      binding: FreetabBinding(),
    ),
    GetPage(
      name: _Paths.AI_EFFECT_TAB,
      page: () => const AiEffectTabView(),
      binding: AiEffectTabBinding(),
    ),
  ];
}

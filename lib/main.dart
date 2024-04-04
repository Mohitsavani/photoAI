import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/modules/dashboard/bindings/dashboard_binding.dart';

import 'app/core/material_theme.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        transitionDuration: const Duration(milliseconds: 300),
        defaultTransition: Transition.rightToLeft,
        initialBinding: DashboardBinding(),
        theme: customTheme,
      ),
    );
  }
}

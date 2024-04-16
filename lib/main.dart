import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/core/material_theme.dart';
import 'app/reusable/connectivity_wrapper.dart';
import 'app/routes/app_pages.dart';
import 'app/uttils/initial/initial_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: GetMaterialApp(
          builder: (context, child) {
            return ConnectivityWidgetWrapper(
              disableInteraction: true,
              offlineWidget: const ConnectionWrapper(),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          title: "Application",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          theme: customTheme,
          initialBinding: InitialBinding(),
        ),
      ),
    );
  }
}

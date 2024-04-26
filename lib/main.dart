import 'dart:async';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app/core/material_theme.dart';
import 'app/reusable/connectivity_wrapper.dart';
import 'app/routes/app_pages.dart';
import 'app/uttils/initial/initial_bindings.dart';
import 'app/uttils/local_store/prefrances.dart';
import 'app/uttils/notification_service/firebase_notification.dart';

Future<void> backgroundHandler(RemoteMessage message) async {}

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await FirebaseNotification.instance.initializeApp();
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    MobileAds.instance.initialize();
    await PreferenceHelper.instance.createSharedPref();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    runApp(const MyApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
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

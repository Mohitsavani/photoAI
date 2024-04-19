import 'dart:convert';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:posteriya/app/uttils/analytic_service/analytics_service.dart';

import '../../model/style_data_model.dart';
import '../../modules/dashboard/views/dashboard_view.dart';
import '../firebase_db/firebase_db.dart';
import '../globle_uttils.dart';
import '../in_app/payment_services.dart';
import '../local_store/prefrances.dart';

class InitialController extends GetxController {
  final Rx<CharacterStyleModel?> appData = CharacterStyleModel().obs;
  // final metaSdk = FlutterMetaSdk();
  @override
  Future<void> onInit() async {
    super.onInit();
    // setOrientations();
    // getMetaAnonymousId();
    // await DbHelper.instance.initDataBase();
    await PreferenceHelper.instance.createSharedPref();
    await FireBaseDBService.instance.initializeApp();
    getAppData().then((value) async {
      return await redirect();
    });
    // razorPayInit();
    AnalyticsService.instance.sendAnalyticsEvent(eventName: 'Posteriya AI');
  }

  // getMetaAnonymousId() async {
  //   String? id = await metaSdk.getAnonymousId();
  //   print("Meta Anonymous ID: $id ");
  // }

  Future<void> getAppData() async {
    if (await ConnectivityWrapper.instance.isConnected) {
      final client = Dio();
      try {
        final response = await client
            .get("https://bobblyai.com/4125Api124/avatar_creation.php");
        if (response.statusCode == 200) {
          if (response.data != null) {
            PreferenceHelper.instance
                .setData(Pref.appData, json.encode(response.data));
            String appdata =
                await PreferenceHelper.instance.getData(Pref.appData);
            appData.value = characterStyleModelFromJson(appdata);

            appPrint(appData.value);
          }
        }
      } catch (error) {
        getLocalData();
      }
    } else {
      getLocalData();
    }
  }

  getLocalData() async {
    String? appdata;
    appdata = await PreferenceHelper.instance.getData(Pref.appData);

    if (appdata == null) {
      // appData.value = CharacterStyleModel.fromJson(categoryData);
    } else {
      appData.value = characterStyleModelFromJson(appdata);
    }
  }

  redirect() async {
    await Future.delayed(const Duration(seconds: 1));
    bool? firstLaunch;
    firstLaunch = await PreferenceHelper.instance.getData(Pref.firstLaunch);

    if (firstLaunch == true || firstLaunch == null) {
      // Get.offAll(const OnBoardingView());
    } else {
      if (FireBaseDBService.instance.isPro.isFalse) {
        // showInApp(fromOnBoarding: true);
      } else {
        Get.offAll(const DashboardView());
      }
    }
  }

//============================================================================//
//                       ** In-app Functions **                               //
//============================================================================//

  getInAppData() {
    InAppPurchaseService.instance.startSubscriptionListen(
      onPending: () {},
      onHandle: (value) => null,
      onPurchased: (purchaseDetails) async {
        await getPurchaseDetails(purchaseDetails);
      },
      onRestored: (restoreDetails) async {
        if (restoreDetails.purchaseID != null) {
          await getRestoredDetails(restoreDetails);
        }
      },
    );
    InAppPurchaseService.instance.inAppInit().then((value) {
      // Get.put(PurchaseController()).productsList(value);
    });
  }

  getPurchaseDetails(PurchaseDetails purchaseDetails) async {
    var data = Get.find<InitialController>().appData.value!.appSettings;
    for (int i = 0; i < (data?.length ?? 0); i++) {
      if (data?[i].id == purchaseDetails.productID) {
        await FireBaseDBService.instance.creditImageCall(
            count: data?[i].credit ?? 1,
            productID: purchaseDetails.productID,
            orderId: '',
            purchaseID: purchaseDetails.purchaseID ?? "");
      }
    }
    await FireBaseDBService.instance.getUserData();
    InAppPurchaseService.instance.isPurchasedLoading(false);
    Get.off(const DashboardView());
  }

  getRestoredDetails(PurchaseDetails restoreDetails) async {
    var data = Get.find<InitialController>().appData.value!.appSettings;
    for (int i = 0; i < (data?.length ?? 0); i++) {
      if (data?[i].id == restoreDetails.productID) {
        await FireBaseDBService.instance.creditImageCall(
            count: data?[i].credit ?? 1,
            productID: restoreDetails.productID,
            orderId: '',
            purchaseID: restoreDetails.purchaseID ?? "");
      }
    }
    await FireBaseDBService.instance.getUserData();
    Get.off(const DashboardView());
  }

//==============================================================================
//                       ** RazorPay Functions **
//==============================================================================

  // razorPayInit() async {
  //   await RazorPayService.instance.initiateRazorPay(
  //       onSuccess: (PaymentSuccessResponse response, String rcpId) {
  //     getPurchasedDetails(response, rcpId);
  //   }, onError: (PaymentFailureResponse response) {
  //     RazorPayError errors = razorPayErrorFromJson(response.message ?? "");
  //     razorpayDialog(
  //       content: errors.error?.description ?? "",
  //     );
  //     RazorPayService.instance.isPurchasedLoading(false);
  //     print(response);
  //   }, onExternalWallet: (ExternalWalletResponse response) {
  //     razorpayDialog(content: "Something went Wrong");
  //     RazorPayService.instance.isPurchasedLoading(false);
  //     print(response);
  //   });
  // }
  //
  // getPurchasedDetails(PaymentSuccessResponse response, String rcpId) async {
  //   var data = Get.find<InitialController>().appData.value!.appSettings;
  //   int? count;
  //   for (int i = 0; i < (data?.length ?? 0); i++) {
  //     if (data?[i].id == rcpId) {
  //       count = data?[i].credit ?? 1;
  //       await FireBaseDBService.instance.creditImageCall(
  //           count: data?[i].credit ?? 1,
  //           orderId: response.orderId ?? "",
  //           productID: rcpId,
  //           purchaseID: response.paymentId ?? "");
  //     }
  //   }
  //   await FireBaseDBService.instance.getUserData();
  //   razorpayDialog(
  //       content: "You've unlocked $count image "
  //           "generation tries. Explore and create to your heart's content!",
  //       successDialog: true);
  //   // Get.off(DashboardView(tab: 0.obs));
  //   RazorPayService.instance.isPurchasedLoading(false);
  // }
  //
  // razorpayDialog({required String content, bool successDialog = false}) {
  //   return Get.dialog(
  //     barrierColor: null,
  //     barrierDismissible: true,
  //     BackdropFilter(
  //       filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
  //       child: Dialog(
  //           backgroundColor: AppColors.white,
  //           shape: const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(15.0))),
  //           child: IntrinsicHeight(
  //             child: Container(
  //               decoration: const BoxDecoration(
  //                   color: AppColors.white,
  //                   borderRadius: BorderRadius.all(Radius.circular(15.0))),
  //               child: Stack(
  //                 clipBehavior: Clip.none,
  //                 children: [
  //                   Container(
  //                     height: 45.h,
  //                     decoration: BoxDecoration(
  //                         color: AppColors.appColor.withOpacity(0.5),
  //                         borderRadius: const BorderRadius.vertical(
  //                             top: Radius.circular(15))),
  //                   ),
  //                   Center(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         Padding(
  //                           padding: EdgeInsets.only(top: 20.h),
  //                           child: Container(
  //                             height: 60.h,
  //                             width: 60.h,
  //                             padding: EdgeInsets.all(2.h),
  //                             decoration: BoxDecoration(
  //                                 color: AppColors.white,
  //                                 shape: BoxShape.circle,
  //                                 border: Border.all(color: AppColors.white)),
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                   color: AppColors.white,
  //                                   shape: BoxShape.circle,
  //                                   border: Border.all(
  //                                       color: successDialog
  //                                           ? const Color(0xff57E91F)
  //                                           : AppColors.red)),
  //                               child: Padding(
  //                                 padding: EdgeInsets.all(15.h),
  //                                 child: Image.asset(
  //                                   successDialog
  //                                       ? AppImage.success
  //                                       : AppImage.closeDialog,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: EdgeInsets.only(
  //                               top: 10.h, right: 10.h, left: 10.h),
  //                           child: Text(
  //                             successDialog
  //                                 ? "Payment Received!"
  //                                 : "Payment Failed!",
  //                             style: poppins.black.get15.w600,
  //                             textAlign: TextAlign.center,
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: EdgeInsets.only(
  //                               top: 10.h, right: 20.h, left: 20.h),
  //                           child: Text(
  //                             content,
  //                             style: poppins.black.get8.w400,
  //                             textAlign: TextAlign.center,
  //                           ),
  //                         ),
  //                         InkWell(
  //                           onTap: successDialog
  //                               ? () {
  //                                   Get.offAll(DashboardView(tab: 0.obs));
  //                                 }
  //                               : () async {
  //                                   String appdata = await PreferenceHelper
  //                                       .instance
  //                                       .getData(Pref.appData);
  //                                   RazorPayService.instance.razorpay
  //                                       .open(json.decode(appdata));
  //                                   Get.back();
  //                                 },
  //                           child: Container(
  //                             height: 30.h,
  //                             margin: EdgeInsets.all(20.h),
  //                             decoration: BoxDecoration(
  //                               color: AppColors.appColor,
  //                               borderRadius: BorderRadius.circular(40),
  //                             ),
  //                             child: Center(
  //                                 child: Text(
  //                               successDialog ? "Go Back" : "Try Again",
  //                               style: poppins.black.get12.w500,
  //                             )),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           )),
  //     ),
  //   );
  // }
}

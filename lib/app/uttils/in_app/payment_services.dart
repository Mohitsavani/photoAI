import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class InAppResponse {
  final RxBool loading;
  final RxString queryProductError;
  final RxBool isStoreAvailable;
  final RxList<ProductDetails> inAppProductsList;

  InAppResponse(
      {bool loading = true,
      String queryProductError = "",
      bool isStoreAvailable = false,
      List<ProductDetails>? inAppProductsList})
      : loading = RxBool(loading),
        queryProductError = RxString(queryProductError),
        isStoreAvailable = RxBool(isStoreAvailable),
        inAppProductsList = RxList(inAppProductsList ?? []);
}

class InAppPurchaseService {
  static final InAppPurchaseService instance = InAppPurchaseService._internal();

  factory InAppPurchaseService() {
    return instance;
  }
  InAppPurchaseService._internal();

////////////////////////////////////////////////////////////////////////////////
//============================================================================//
//                         ** PROPERTIES **                                   //
//============================================================================//
////////////////////////////////////////////////////////////////////////////////

  /// Check the platform for kAutoConsume
  final bool kAutoConsume = Platform.isIOS || true;

  /// Check the status of Store is available or not

  /// Add your products or Subscription IDS hear in the List
  List<String> iNAppProductIds = <String>[
    'com.app.posteriya.ai.generator_first_plan',
    'com.app.posteriya.ai.generator_second_plan',
    'com.app.posteriya.ai.generator_third_plan',
  ];

  /// in-app-purchase Object
  final InAppPurchase inAppPurchase = InAppPurchase.instance;

  /// Subscription Object for get the subscription Stream data
  late StreamSubscription<List<PurchaseDetails>> subscription;

  /// List for the get in-app-products

  ///List For the get in-app-purchas DAta
  RxList<PurchaseDetails> inAppPurchasesList = RxList<PurchaseDetails>();

  /// Get consumable list
  RxList<String> consumablesList = RxList<String>();

  RxBool isPurchasedLoading = false.obs;

////////////////////////////////////////////////////////////////////////////////
//============================================================================//
//                          ** FUNCTIONS **                                   //
//============================================================================//
////////////////////////////////////////////////////////////////////////////////

//==============================================================================
//  ** Get Start Subscription Listen **
//==============================================================================

  startSubscriptionListen({
    required void Function() onPending,
    required Function(IAPError value) onHandle,
    required Function(PurchaseDetails purchaseDetails) onPurchased,
    required Function(PurchaseDetails restoreDetails) onRestored,
  }) {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        inAppPurchase.purchaseStream;
    subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList,
          onPending: onPending,
          onHandle: onHandle,
          onPurchased: onPurchased,
          onRestored: onRestored);
    }, onDone: () {
      subscription.cancel();
    }, onError: (Object error) {
      /// handle error here.
    });
  }

  Future<void> _listenToPurchaseUpdated(
    List<PurchaseDetails> purchaseDetailsList, {
    required void Function() onPending,
    required Function(IAPError value) onHandle,
    required Function(PurchaseDetails purchaseDetails) onPurchased,
    required Function(PurchaseDetails purchaseDetails) onRestored,
  }) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        onPending();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          onHandle(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          onPurchased(purchaseDetails);
        } else if (purchaseDetails.status == PurchaseStatus.restored) {
          onRestored(purchaseDetails);
        }
        if (Platform.isAndroid) {
          final InAppPurchaseAndroidPlatformAddition androidAddition =
              inAppPurchase
                  .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
          await androidAddition.consumePurchase(purchaseDetails);
        }

        if (purchaseDetails.pendingCompletePurchase) {
          await inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

//==============================================================================
//  ** Init Call For Get Product List **
//==============================================================================

  Future<InAppResponse> inAppInit() async {
    /// Get Store status Store is available or not
    final bool isAvailable = await inAppPurchase.isAvailable();

    ///Method for payment queue delegate can be implemented to
    ///provide information
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    /// Get the the response for in-app products data
    final ProductDetailsResponse productDetailResponse =
        await inAppPurchase.queryProductDetails(iNAppProductIds.toSet());
    return handleStoreResponse(productDetailResponse, isAvailable);
  }

  /// Handle The Response with status
  Future<InAppResponse> handleStoreResponse(
      ProductDetailsResponse productDetailResponse, bool isAvailable) async {
    if (productDetailResponse.error != null) {
      return InAppResponse(
          inAppProductsList: productDetailResponse.productDetails,
          isStoreAvailable: isAvailable,
          loading: false,
          queryProductError: productDetailResponse.error!.message);
    }
    if (productDetailResponse.productDetails.isEmpty) {
      return InAppResponse(
          inAppProductsList: productDetailResponse.productDetails,
          isStoreAvailable: isAvailable,
          loading: false,
          queryProductError: "");
    }
    return InAppResponse(
        inAppProductsList: productDetailResponse.productDetails,
        isStoreAvailable: isAvailable,
        loading: false,
        queryProductError: "");
  }

//==============================================================================
//  ** In-App Dispose **
//==============================================================================

  inAppDispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    subscription.cancel();
  }

//==============================================================================
//  ** Purchase Product or Subscription **
//==============================================================================

  purchaseProduct(ProductDetails productDetails) {
    isPurchasedLoading(true);
    late PurchaseParam purchaseParam;

    if (Platform.isAndroid) {
      purchaseParam = GooglePlayPurchaseParam(productDetails: productDetails);
    } else {
      purchaseParam = PurchaseParam(
        productDetails: productDetails,
      );
    }
    inAppPurchase.buyConsumable(
        purchaseParam: purchaseParam, autoConsume: kAutoConsume);
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}

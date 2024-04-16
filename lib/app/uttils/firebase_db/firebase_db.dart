import 'dart:convert';

import 'package:android_id/android_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:posteriya/app/uttils/globle_uttils.dart';

import '../../../firebase_options.dart';
import '../../model/config_data_model.dart';
import '../../model/user_data_model.dart';
import '../local_store/prefrances.dart';

class FireBaseDBService {
  FireBaseDBService._privateConstructor();

  static final FireBaseDBService instance =
      FireBaseDBService._privateConstructor();

  ConfigDataModel configDataModel = ConfigDataModel();
  var androidIdPlugin = const AndroidId();
  RxBool isPro = false.obs;

  UserDataModel userDataModel = UserDataModel(
      createdAt: "",
      updateAt: "",
      apiCount: 0,
      deviceId: "",
      purchaseId: "",
      orderId: "",
      SKU: '');

  initializeApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final String? deviceId = await androidIdPlugin.getId();

    PreferenceHelper.instance.setData(Pref.deviceId, deviceId);
    appPrint('Running on $deviceId');
    var configData = await getConfigData();
    var userData = await getUserData();
    if (deviceId != userData.deviceId) {
      setUserData(
          data: UserDataModel(
              createdAt: DateTime.now().toIso8601String(),
              updateAt: DateTime.now().toIso8601String(),
              apiCount: configData.apiCounter ?? 1,
              deviceId: deviceId ?? "",
              purchaseId: "",
              SKU: '',
              orderId: ''));
    }
  }

  Future<UserDataModel> getUserData() async {
    var deviceId = await PreferenceHelper.instance.getData(Pref.deviceId);
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(deviceId)
        .get();

    var users = data.data();
    var userData = userDataModelFromJson(jsonEncode(users ??
        UserDataModel(
            deviceId: "",
            apiCount: 1,
            createdAt: "",
            updateAt: "",
            purchaseId: "",
            SKU: '',
            orderId: '')));
    setUserIsProOrNot(userData);
    return userData;
  }

  setUserData({required UserDataModel data}) async {
    var deviceId = await PreferenceHelper.instance.getData(Pref.deviceId);
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(deviceId)
        .set(data.toJson());
  }

  updateUserData({required Map<String, dynamic> data}) async {
    var deviceId = await PreferenceHelper.instance.getData(Pref.deviceId);
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(deviceId)
        .update(data);
  }

  Future<ConfigDataModel> getConfigData() async {
    var data = await FirebaseFirestore.instance
        .collection('config_data')
        .doc("moodify")
        .get();

    var configData = data.data();
    var jsonString = json.encode(configData);
    configDataModel = configDataModelFromJson(jsonString);
    PreferenceHelper.instance.setData(Pref.configData, jsonString);
    var counter = await configData?["api_counter"];
    appPrint("object $counter");
    PreferenceHelper.instance.setData(Pref.apiCountTotal, counter);
    return configDataModel;
  }

  creditImageCall(
      {required int count,
      required String purchaseID,
      required String productID,
      required String orderId}) async {
    UserDataModel userDataModel = await getUserData();
    await FireBaseDBService.instance.updateUserData(data: {
      "api_count": (userDataModel.apiCount + count),
      "purchaseId": purchaseID,
      "updateAt": DateTime.now().toIso8601String(),
      "SKU": productID,
      "orderId": orderId
    });
  }

  setUserIsProOrNot(UserDataModel userData) async {
    if (userData.apiCount > 1) {
      isPro(true);
    } else {
      isPro(false);
    }
  }
}

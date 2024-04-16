// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) =>
    UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  String createdAt;
  String updateAt;
  int apiCount;
  String deviceId;
  String purchaseId;
  String SKU;
  String orderId;

  UserDataModel({
    required this.createdAt,
    required this.updateAt,
    required this.apiCount,
    required this.deviceId,
    required this.purchaseId,
    required this.SKU,
    required this.orderId,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        createdAt: json["createdAt"],
        updateAt: json["updateAt"],
        apiCount: json["api_count"],
        deviceId: json["deviceId"],
        purchaseId: json["purchaseId"],
        SKU: json["SKU"],
        orderId: json["orderId"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "updateAt": updateAt,
        "api_count": apiCount,
        "deviceId": deviceId,
        "purchaseId": purchaseId,
        "SKU": SKU,
        "orderId": orderId,
      };
}

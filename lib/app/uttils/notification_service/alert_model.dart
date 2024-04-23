// To parse this JSON data, do
//
//     final notificationData = notificationDataFromJson(jsonString);

import 'dart:convert';

NotificationData notificationDataFromJson(String str) =>
    NotificationData.fromJson(json.decode(str));

String notificationDataToJson(NotificationData data) =>
    json.encode(data.toJson());

class NotificationData {
  NotificationData({
    this.type,
    this.id,
  });

  String? type;
  int? id;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        type: json["type"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
      };
}

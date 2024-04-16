// To parse this JSON data, do
//
//     final configDataModel = configDataModelFromJson(jsonString);

import 'dart:convert';

ConfigDataModel configDataModelFromJson(String str) =>
    ConfigDataModel.fromJson(json.decode(str));

class ConfigDataModel {
  String? apiBaseUrl;
  int? apiCounter;
  String? moodexUrl;
  String? downloadUrl;
  String? privacy;
  String? terms;
  String? inAppTerm;
  String? version;
  int? buildNumber;

  ConfigDataModel({
    this.apiBaseUrl,
    this.apiCounter,
    this.moodexUrl,
    this.privacy,
    this.terms,
    this.downloadUrl,
    this.inAppTerm,
    this.version,
    this.buildNumber,
  });

  factory ConfigDataModel.fromJson(Map<String, dynamic> json) =>
      ConfigDataModel(
          apiBaseUrl: json["api_base_url"],
          inAppTerm: json["inapp_term"],
          apiCounter: json["api_counter"],
          downloadUrl: json["downloadUrl"],
          moodexUrl: json["moodify_url"],
          privacy: json["privacy"],
          terms: json["term"],
          version: json["version"],
          buildNumber: json["build_number"]);
}

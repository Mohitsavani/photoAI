// To parse this JSON data, do
//
//     final characterStyleModel = characterStyleModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

CharacterStyleModel characterStyleModelFromJson(String str) =>
    CharacterStyleModel.fromJson(json.decode(str));

class CharacterStyleModel {
  List<AppSetting>? appSettings;
  Style? style;
  List<Category>? category;
  List<String>? banners;
  List<TextPrompt>? textPrompt;

  CharacterStyleModel({
    this.appSettings,
    this.style,
    this.category,
    this.banners,
    this.textPrompt,
  });

  factory CharacterStyleModel.fromJson(Map<String, dynamic> json) =>
      CharacterStyleModel(
        appSettings: json["app_settings"] == null
            ? []
            : List<AppSetting>.from(
                json["app_settings"]!.map((x) => AppSetting.fromJson(x))),
        style: json["style"] == null ? null : Style.fromJson(json["style"]),
        category: json["category"] == null
            ? []
            : List<Category>.from(
                json["category"]!.map((x) => Category.fromJson(x))),
        banners: json["banners"] == null
            ? []
            : List<String>.from(json["banners"]!.map((x) => x)),
        textPrompt: json["text_prompt"] == null
            ? []
            : List<TextPrompt>.from(
                json["text_prompt"]!.map((x) => TextPrompt.fromJson(x))),
      );
}

class AppSetting {
  String? id;
  int? credit;
  double? amount;
  String? currencySymbol;
  String? currencyCode;

  AppSetting({
    this.id,
    this.credit,
    this.amount,
    this.currencySymbol,
    this.currencyCode,
  });

  factory AppSetting.fromJson(Map<String, dynamic> json) => AppSetting(
        id: json["id"],
        credit: json["credit"],
        amount: json["amount"]?.toDouble(),
        currencySymbol: json["currencySymbol"],
        currencyCode: json["currencyCode"],
      );
}

class Category {
  String? id;
  int? sort;
  String? title;
  bool? multiSelect;
  bool? isPro;
  RxList<CategoryStyleList>? styleList;

  Category({
    this.id,
    this.sort,
    this.title,
    this.multiSelect,
    this.isPro,
    List<CategoryStyleList>? styleList,
  }) : styleList = RxList(styleList ?? []);

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        sort: json["sort"],
        title: json["title"],
        multiSelect: json["multi_select"],
        isPro: json["is_pro"],
        styleList: json["style_list"] == null
            ? []
            : List<CategoryStyleList>.from(
                json["style_list"]!.map((x) => CategoryStyleList.fromJson(x))),
      );
}

List<CategoryStyleList> categoryStyleFromJson(String str) =>
    List<CategoryStyleList>.from(
        json.decode(str).map((x) => CategoryStyleList.fromJson(x)));

class CategoryStyleList {
  String? title;
  bool? isPro;
  RxBool isSelect;

  CategoryStyleList({this.title, this.isPro, bool isSelect = false})
      : isSelect = RxBool(isSelect);

  factory CategoryStyleList.fromJson(Map<String, dynamic> json) =>
      CategoryStyleList(
        title: json["title"],
        isPro: json["is_pro"] == false || json["is_pro"] == true
            ? json["is_pro"]
            : json["is_pro"] == 1
                ? true
                : false,
        isSelect: json["is_select"] == false || json["is_select"] == true
            ? json["is_select"]
            : json["is_select"] == 1
                ? true
                : false,
      );
}

class Style {
  RxString id = RxString("");
  RxString title = RxString("");
  RxList<StyleStyleList> styleList = RxList<StyleStyleList>();

  Style({
    String? id,
    String? title,
    List<StyleStyleList>? styleList,
  }) {
    this.id.value = id ?? "";
    this.title.value = title ?? "";
    this.styleList.value = styleList ?? <StyleStyleList>[];
  }

  factory Style.fromJson(Map<String, dynamic> json) => Style(
        id: json["id"],
        title: json["title"],
        styleList: json["style_list"] == null
            ? []
            : List<StyleStyleList>.from(
                json["style_list"]!.map((x) => StyleStyleList.fromJson(x))),
      );
}

class StyleStyleList {
  String? title;
  String? image;
  String? key;

  StyleStyleList({
    this.title,
    this.image,
    this.key,
  });

  factory StyleStyleList.fromJson(Map<String, dynamic> json) => StyleStyleList(
        title: json["title"],
        image: json["image"],
        key: json["key"],
      );
}

class TextPrompt {
  final String? title;

  RxList<String>? promptList;

  TextPrompt({
    this.title,
    List<String>? promptList,
  }) : promptList = RxList(promptList ?? []);

  factory TextPrompt.fromJson(Map<String, dynamic> json) => TextPrompt(
        title: json["title"],
        promptList: json["prompt_list"] == null
            ? []
            : List<String>.from(json["prompt_list"]!.map((x) => x)),
      );
}

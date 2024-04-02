import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppColors {
  const AppColors._();

  static bool isDarkTheme() {
    return Get.isDarkMode;
  }

  static changeThemeMode() {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      // AppPref().isDark = false;
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      // AppPref().isDark = true;
    }
  }

  static Color blackWhiteColor() {
    return isDarkTheme()
        ? DarkTheme.chipSelectedDark
        : LightTheme.chipSelectedDark;
  }

//==============================================================================
// ** Single Colors **
//==============================================================================

  static const Color trans = Colors.transparent;
  static const Color black = Colors.black;
  static const Color red = Colors.red;
  static const Color grey = Colors.grey;
  static const Color white = Colors.white;
  static const Color appColor = Color(0xff4d3aa5);
  static const Color appBG = Color(0xfff9f5fc);

  // Custom Colors
  static const Color color1 = Color(0xff014871);
  static const Color color2 = Color(0xff4CA7D6);
  static const Color color3 = Color(0xffD7EDE2);
}

class DarkTheme {
  static const chipSelectedDark = Color(0xffFFFFFF);
}

class LightTheme {
  static const chipSelectedDark = Color(0xff000000);
}

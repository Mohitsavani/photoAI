import 'package:flutter/material.dart';

abstract class AppColors {
  const AppColors._();

//==============================================================================
// ** Single Colors **
//==============================================================================

  static const Color trans = Colors.transparent;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color white = Colors.white;

  // Custom Colors
  static const Color xff4CA7D6 = Color(0xff4CA7D6);
  static const Color xffD7EDE2 = Color(0xffD7EDE2);
  static const Color appColor = Color(0xff0c0908);

  // Custom Colors
  static const Color color1 = Color(0xff0c0908);
  static const Color color2 = Color(0xff4CA7D6);
  static const Color xffB6B6B4 = Color(0xffB6B6B4);
  static const Color xfff9f5fc = Color(0xfff9f5fc);
  static const Color color3 = Color(0xffD7EDE2);
}

class DarkTheme {
  static const chipSelectedDark = Color(0xffFFFFFF);
}

class LightTheme {
  static const chipSelectedDark = Color(0xff000000);
}

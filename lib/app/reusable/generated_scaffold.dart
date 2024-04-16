import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/reusable/drawer/views/drawer_view.dart';

import '../core/colors.dart';

//============================================================
// **  Scaffold **
//============================================================

Widget appScaffold({
  Key? key,
  PreferredSizeWidget? appBar,
  Widget? body,
  Widget? floatingActionButton,
  FloatingActionButtonLocation? floatingActionButtonLocation,
  FloatingActionButtonAnimator? floatingActionButtonAnimator,
  List<Widget>? persistentFooterButtons,
  AlignmentDirectional persistentFooterAlignment =
      AlignmentDirectional.centerEnd,
  Widget? drawer,
  void Function(bool)? onDrawerChanged,
  Widget? endDrawer,
  void Function(bool)? onEndDrawerChanged,
  Widget? bottomNavigationBar,
  Color? statusColor,
  Widget? bottomSheet,
  Color? backgroundColor,
  bool? resizeToAvoidBottomInset,
  bool primary = true,
  bool topSafe = true,
  DragStartBehavior drawerDragStartBehavior = DragStartBehavior.start,
  bool extendBody = false,
  bool extendBodyBehindAppBar = false,
  Color? drawerScrimColor,
  double? drawerEdgeDragWidth,
  Brightness? statusBarIconBrightness,
  bool drawerEnableOpenDragGesture = false,
  bool endDrawerEnableOpenDragGesture = false,
  String? restorationId,
}) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: statusBarIconBrightness ?? Brightness.dark,
        statusBarColor: statusColor ?? AppColors.trans,
      ),
      child: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: SafeArea(
          top: topSafe,
          bottom: false,
          child: Scaffold(
            key: key,
            appBar: appBar,
            body: body,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            floatingActionButtonAnimator: floatingActionButtonAnimator,
            persistentFooterButtons: persistentFooterButtons,
            persistentFooterAlignment: persistentFooterAlignment,
            drawer: drawer ?? appDrawer(),
            onDrawerChanged: onDrawerChanged,
            endDrawer: endDrawer,
            onEndDrawerChanged: onEndDrawerChanged,
            bottomNavigationBar: bottomNavigationBar,
            bottomSheet: bottomSheet,
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            primary: primary,
            drawerDragStartBehavior: drawerDragStartBehavior,
            extendBody: extendBody,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            drawerScrimColor: drawerScrimColor,
            drawerEdgeDragWidth: drawerEdgeDragWidth,
            drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
            endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
            restorationId: restorationId,
          ),
        ),
      ));
}

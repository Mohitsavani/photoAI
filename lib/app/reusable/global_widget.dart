import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/core/typography.dart';
import 'package:shimmer/shimmer.dart';

import '../core/colors.dart';

//==============================================================================
// ** App Empty Widget **
//==============================================================================

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

//==============================================================================
// ** App Text Widget **
//==============================================================================

class AppText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabe;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColo;

  const AppText(this.data,
      {super.key,
      this.style,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabe,
      this.textWidthBasis,
      this.textHeightBehavior,
      this.selectionColo,
      this.strutStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      data.tr,
      locale: locale,
      style: style,
      key: key,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      selectionColor: selectionColo,
      semanticsLabel: semanticsLabe,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textDirection: textDirection,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}

//==============================================================================
// ** Global SnackBar **
//==============================================================================

showToast(String message) {
  Fluttertoast.showToast(
    msg: message.tr,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    textColor: AppColors.white,
    fontSize: 10.h,
    backgroundColor: AppColors.black,
  );
}
//==============================================================================
// ** App Simmer Loader **
//==============================================================================

class SimmerLoader extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final Color? baseColor;
  final Color? highlightColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? decorationColor;

  const SimmerLoader({
    Key? key,
    this.height,
    this.width,
    this.radius,
    this.baseColor,
    this.highlightColor,
    this.padding,
    this.margin,
    this.decorationColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColors.grey.withOpacity(0.1),
      highlightColor: highlightColor ?? AppColors.white.withOpacity(0.5),
      child: Container(
        margin: margin,
        width: width ?? Get.width,
        height: Get.height < 700 ? height ?? 150 : height ?? Get.height * 0.205,
        decoration: BoxDecoration(
          color: decorationColor ?? AppColors.white,
          borderRadius: BorderRadius.circular(radius ?? 5),
        ),
      ),
    );
  }
}

class LoadingDots extends StatefulWidget {
  const LoadingDots({super.key});

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text('Loading', style: ubuntu.get10),
        ),
        SizedBox(
          width: 20,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Text('.' * (_controller.value * 4).floor(),
                  maxLines: 1, style: ubuntu.get10);
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final double? height;
  final double? width;
  final double? radius;
  final bool? loader;
  final Color? backGroundColor;

  const AppButton(
    this.title, {
    Key? key,
    required this.onPressed,
    this.height,
    this.radius,
    this.width,
    this.loader = false,
    this.backGroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // Center the button horizontally
      child: Padding(
        padding: EdgeInsets.only(top: 3.h, bottom: 3.h, right: 10.w),
        child: GestureDetector(
          onTap: loader == true ? () {} : onPressed,
          child: Container(
            height: height ?? 36, // Adjust height as needed
            width: width ?? 88, // Adjust width as needed
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.color1.withOpacity(0.3)),
              gradient: LinearGradient(
                colors: [
                  AppColors.color1,
                  AppColors.white,
                ],
              ),
              borderRadius:
                  BorderRadius.circular(radius ?? 20), // Add this line
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(color: AppColors.black), // Adjust text color
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posteriya/app/reusable/generated_scaffold.dart';

import '../../../../core/constant.dart';
import '../../../../reusable/images/default_image.dart';

class ExampleView extends StatefulWidget {
  final int currentIndex;
  final String effectName;
  const ExampleView(
      {super.key, required this.currentIndex, required this.effectName});

  @override
  State<ExampleView> createState() => _ExampleViewState();
}

class _ExampleViewState extends State<ExampleView> {
  @override
  Widget build(BuildContext context) {
    return appScaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: imageUrls.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 6.5.h,
            crossAxisSpacing: 6.5.h,
            childAspectRatio: 9 / 12,
          ),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: NetWorkImage(
                imageUrls[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/modules/selectImage/views/select_image_view.dart';

import '../../../core/typography.dart';
import '../../../reusable/app_button/app_button.dart';
import '../../../reusable/generated_scaffold.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildListItem(context);
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const SelectImageView());
      },
      child: SizedBox(
        height: Get.height * 0.26,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://images.unsplash.com/photo-1524230572899-a752b3835840?q=80&w=1936&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: ubuntu.get15.black.bold,
                    ),
                    Text(
                      "Subtitle",
                      style: ubuntu.black.get12.w500,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                right: 0,
                child: AppButton(
                  'Start',
                  onPressed: () {
                    Get.to(() => const SelectImageView());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posteriya/app/core/colors.dart';
import 'package:posteriya/app/modules/selectImage/views/select_image_view.dart';

import '../../../reusable/generated_scaffold.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key});

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return _buildListItem(context);
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SelectImageView()); // Navigate to SelectImage page
      },
      child: SizedBox(
        height: 250, // Set the height of the card
        child: Card(
          margin: const EdgeInsets.only(
              bottom: 10, left: 20, right: 20, top: 50), // Adjust margins
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20), // Set circular border radius
          ),
          elevation: 3, // Add elevation for a shadow effect
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://images.unsplash.com/photo-1571816119607-57e48af1caa9?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.cover, // Adjust image fit
                ),
              ),
              const Positioned(
                bottom:
                    10, // Adjust the vertical position of the title and subtitle
                left:
                    10, // Adjust the horizontal position of the title and subtitle
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: TextStyle(
                        fontSize: 20, // Adjust title font size
                        fontWeight: FontWeight.bold, // Adjust title font weight
                        color: AppColors.black, // Set title color
                      ),
                    ),
                    SizedBox(height: 5), // Add space between title and subtitle
                    Text(
                      "Subtitle",
                      style: TextStyle(
                        fontSize: 16, // Adjust subtitle font size
                        color: AppColors.black, // Set subtitle color
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 10, // Adjust the vertical position of the button
                right: 10, // Adjust the horizontal position of the button
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => SelectImageView());
                  },
                  child: const Text(
                    'Start',
                    style: TextStyle(color: AppColors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

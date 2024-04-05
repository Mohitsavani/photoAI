import 'package:flutter/material.dart';
import 'package:posteriya/app/reusable/generated_scaffold.dart';

import '../../../core/constant.dart';

class ExampleView extends StatefulWidget {
  const ExampleView({super.key});

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
          itemCount: imageUrls.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Adjust as needed
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.0, // Adjust as needed
          ),
          itemBuilder: (context, index) {
            return Image.network(
              imageUrls[index],
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}

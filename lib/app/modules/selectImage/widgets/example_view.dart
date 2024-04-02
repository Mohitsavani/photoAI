import 'package:flutter/material.dart';
import 'package:posteriya/app/reusable/generated_scaffold.dart';

class ExampleView extends StatefulWidget {
  const ExampleView({super.key});

  @override
  State<ExampleView> createState() => _ExampleViewState();
}

class _ExampleViewState extends State<ExampleView> {
  @override
  Widget build(BuildContext context) {
    return appScaffold();
  }
}

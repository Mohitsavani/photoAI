import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SuggestView extends StatefulWidget {
  const SuggestView({super.key});

  @override
  State<SuggestView> createState() => _SuggestViewState();
}

class _SuggestViewState extends State<SuggestView> {
  List<File> _imageList = [];
  bool _isLoading = true;
  bool noImagesFound = false;
  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    try {
      final Directory cameraFolder = await _getCameraFolder();
      final List<FileSystemEntity> files = cameraFolder.listSync();
      setState(() {
        _imageList = files.whereType<File>().toList();
        _isLoading = false;
        noImagesFound = _imageList.isEmpty;
      });
    } catch (e) {
      print('Error fetching images: $e');
      setState(() {
        _isLoading = false;
        noImagesFound = true;
      });
    }
  }

  Future<Directory> _getCameraFolder() async {
    final Directory? appDocDir = await getExternalStorageDirectory();
    return Directory('${appDocDir?.path}/DCIM/Camera');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : noImagesFound
                  ? Center(
                      child: Text('No images found'),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: _imageList.length,
                      itemBuilder: (context, index) {
                        return Image.file(
                          _imageList[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
        ),
      ],
    );
  }
}

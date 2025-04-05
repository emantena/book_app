import 'dart:io';

import 'package:book_app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryView extends StatefulWidget {
  final XFile? image;
  const GalleryView({super.key, required this.image});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: null),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 215,
              width: 215,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.unselectedColor,
                    radius: 50,
                    backgroundImage: FileImage(File(widget.image!.path)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

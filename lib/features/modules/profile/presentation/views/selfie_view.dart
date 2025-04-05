import 'dart:io';

import 'package:book_app/core/resources/app_colors.dart';
import 'package:book_app/core/resources/app_values.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SelfieView extends StatefulWidget {
  const SelfieView({super.key});

  @override
  State<SelfieView> createState() => _SelfieViewState();
}

class _SelfieViewState extends State<SelfieView> {
  List<CameraDescription> cameras = [];
  CameraController? controller;
  XFile? imageFile;
  bool error = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCameras();
  }

  _loadCameras() async {
    try {
      cameras = await availableCameras();
      _startCamera();
    } on CameraException catch (e) {
      setState(() {
        error = true;
        errorMessage = e.description;
      });
    }
  }

  _startCamera() async {
    if (cameras.isEmpty) {
      setState(() {
        error = true;
        errorMessage = 'Nenhuma camera encontrada';
      });
    } else {
      for (var camera in cameras) {
        if (camera.lensDirection == CameraLensDirection.front) {
          _previewCamera(camera);
        }
      }
    }
  }

  _previewCamera(CameraDescription camera) async {
    controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await controller?.initialize();
      if (!mounted) return;
      setState(() {});
    } on CameraException catch (e) {
      setState(() {
        error = true;
        errorMessage = e.description;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tirar uma selfie',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Colors.grey[900],
        child: Center(
          child: _photoView(),
        ),
      ),
      floatingActionButton: imageFile != null
          ? FloatingActionButton.extended(
              backgroundColor: AppColors.primaryBackground,
              foregroundColor: AppColors.primary,
              onPressed: () {
                // sl<ProfileCubit>().updatePhoto(imageFile!);
                // Navigator.of(context).pop(imageFile);
              },
              label: const Text("Salvar"),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _photoView() {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width - AppSize.s50,
      height: size.height - (size.height / 3),
      child: imageFile == null
          ? _cameraPreview()
          : Image.file(
              File(imageFile!.path),
              fit: BoxFit.contain,
            ),
    );
  }

  Widget _cameraPreview() {
    if (controller == null || !controller!.value.isInitialized) {
      return const Text('Carregando...');
    } else {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CameraPreview(controller!),
          Padding(
            padding: const EdgeInsets.only(bottom: AppPadding.p16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _takePictureButton(),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget _takePictureButton() {
    return Positioned(
      bottom: 0,
      child: RawMaterialButton(
        onPressed: () async {
          final file = await controller!.takePicture();
          if (mounted) setState(() => imageFile = file);
        },
        elevation: 2.0,
        fillColor: AppColors.primaryBackground,
        padding: const EdgeInsets.all(AppPadding.p16),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.camera_alt_outlined,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

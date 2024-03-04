import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/functions/commen.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

// ignore: must_be_immutable
class CameraOrderScreen extends StatefulWidget {
  List<File> images;
  CameraOrderScreen({
    super.key,
    required this.images,
  });

  @override
  State<CameraOrderScreen> createState() => _CameraOrderScreenState();
}

class _CameraOrderScreenState extends State<CameraOrderScreen> {
  late CameraController _cameraController;
  late Future<void> _cameraValue;
  bool isFlashOn = false;
  bool isCameraFront = true;
  @override
  void initState() {
    super.initState();
    _cameraController =
        CameraController(AppConstants.cameras[0], ResolutionPreset.high);
    _cameraValue = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                FutureBuilder(
                  future: _cameraValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: CameraPreview(_cameraController),
                      );
                    } else {
                      return CircularIndicator(
                        color: AppColors.darkBlue,
                      );
                    }
                  },
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: R.sW(context, 30), top: R.sH(context, 50)),
                    child: IconButton(
                      onPressed: toggleFlash,
                      icon: Icon(
                        isFlashOn ? Icons.flash_on : Icons.flash_off,
                        color: AppColors.white,
                        size: R.sW(context, 30),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: R.sW(context, 20),
                        vertical: R.sH(context, 20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await pickImagesFromGallery(context,
                                (List<File> selectedImages) {
                              widget.images.addAll(selectedImages);
                            });
                          },
                          child: Icon(
                            Icons.photo,
                            size: 30,
                            color: AppColors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            takePhoto(context);
                          },
                          child: Container(
                            width: R.sW(context, 80),
                            height: R.sH(context, 80),
                            decoration: BoxDecoration(
                              color: AppColors.darkBlue,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: toggleCameraFront,
                          child: Icon(
                            Icons.flip_camera_ios,
                            size: 30,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
    });
    isFlashOn
        ? _cameraController.setFlashMode(FlashMode.torch)
        : _cameraController.setFlashMode(FlashMode.off);
  }

  void toggleCameraFront() {
    setState(() {
      isCameraFront = !isCameraFront;
    });
    int cameraPos = isCameraFront ? 0 : 1;
    _cameraController = CameraController(
        AppConstants.cameras[cameraPos], ResolutionPreset.high);
    _cameraValue = _cameraController.initialize();
  }

  void takePhoto(BuildContext context) async {
    XFile file = await _cameraController.takePicture();
    if (!mounted) return;

    widget.images.add(File(file.path));
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }
}

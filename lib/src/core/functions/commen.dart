import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar({
  required BuildContext context,
  required String content,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

List<File> selectedImages = [];
final picker = ImagePicker();

typedef OnImagesSelected = Function(List<File> selectedImages);

Future<List<File>?> pickImagesFromGallery(
    BuildContext context, OnImagesSelected onImagesSelected) async {
  final pickedFile = await picker.pickMultiImage(
      imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
  List<XFile> xfilePick = pickedFile;

  if (xfilePick.isNotEmpty) {
    for (var i = 0; i < xfilePick.length; i++) {
      selectedImages.add(File(xfilePick[i].path));
    }
    onImagesSelected(selectedImages);
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
  }
  return selectedImages;
}

Future<CroppedFile?> cropImage(String path) async {
  return ImageCropper().cropImage(
    sourcePath: path,
    aspectRatioPresets: Platform.isAndroid
        ? [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ]
        : [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.ratio16x9
          ],
    aspectRatio: const CropAspectRatio(
      ratioX: 1.0,
      ratioY: 1.0,
    ),
    compressQuality: 100,
    maxWidth: 400,
    maxHeight: 400,
    compressFormat: ImageCompressFormat.jpg,
    cropStyle: CropStyle.rectangle,
    uiSettings: [
      AndroidUiSettings(
          toolbarColor: Colors.teal,
          toolbarTitle: "Profile Image",
          statusBarColor: Colors.teal,
          backgroundColor: Colors.white,
          hideBottomControls: true,
          lockAspectRatio: false,
          initAspectRatio: CropAspectRatioPreset.square,
          toolbarWidgetColor: Colors.white),
    ],
  );
}

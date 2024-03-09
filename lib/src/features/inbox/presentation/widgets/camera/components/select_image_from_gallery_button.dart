import 'package:flutter/material.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/functions/commen.dart';

class SelectImageFromGalleryButton extends StatelessWidget {
  final String receiverId;

  const SelectImageFromGalleryButton({
    super.key,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      //  selectImageFromGallery(context);
      },
      child: const CircleAvatar(
        radius: 30,
        backgroundColor: Colors.black38,
        child: Icon(
          Icons.photo,
          size: 30,
        ),
      ),
    );
  }
/*
  void selectImageFromGallery(BuildContext context) async {
    File? image = await pickImageFromGallery(context);
    //if (!mounted) return;
    if (image != null) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(
        context,
        Routes.sendingImageViewRoute,
        arguments: {
          'path': image.path,
          'uId': receiverId,
        },
      );
    }
  }*/
}

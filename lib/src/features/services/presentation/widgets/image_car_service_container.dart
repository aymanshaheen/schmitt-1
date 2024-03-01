import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class ImageCarServiceContainer extends StatelessWidget {
  const ImageCarServiceContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: R.sH(context, 250),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  AppImage.carWashDetails1,
                  height: R.sH(context, 250),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        AppImage.carWashDetails2,
                        width: R.sW(context, 150),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: R.sH(context, 10)),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        AppImage.carWashDetails3,
                        width: R.sW(context, 150),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

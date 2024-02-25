import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomInkWell extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;

  const CustomInkWell({super.key, 
    required this.onTap,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: R.sH(context, 50),
        width: R.sW(context, 70),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.grey1!),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: SizedBox(
              width: R.sW(context, 30),
              height: R.sH(context, 30),
              child: SvgPicture.asset(imagePath, fit: BoxFit.contain)),
        ),
      ),
    );
  }
}

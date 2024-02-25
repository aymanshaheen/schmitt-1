import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class MoreInfoIcon extends StatelessWidget {
  const MoreInfoIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: R.sH(context, 25),
      width: R.sW(context, 25),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.black, width: R.sW(context, 1.5)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Icon(
          Icons.more_horiz,
          color: AppColors.darkBlue,
          size: R.sW(context, 20),
        ),
      ),
    );
  }
}

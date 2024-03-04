import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class HomeTextTile extends StatelessWidget {
  final String rightText;
  final String leftText;
  final Function() onTab;
  const HomeTextTile(
      {super.key,
      required this.rightText,
      required this.leftText,
      required this.onTab});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText.tr(),
          style: TextStyle(
            color: AppColors.homeBlackColor,
            fontSize: R.F(context, 20),
            fontWeight: FontWeight.w700,
          ),
        ),
        GestureDetector(
          onTap: onTab,
          child: Text(
            rightText.tr(),
            textAlign: TextAlign.right,
            style: TextStyle(
              color: AppColors.homeBlueColor,
              fontSize: R.F(context, 16),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.20,
            ),
          ),
        )
      ],
    );
  }
}

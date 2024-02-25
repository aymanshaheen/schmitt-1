import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

PreferredSizeWidget profileAppBar({
  required String title,
  required BuildContext context,
  required bool isAction,
  Function()? onPressed,
  IconData? trillingIcon,
  bool isTrilling = false,
  Function()? onTrillingPressed,
}) {
  return AppBar(
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: AppColors.black,
      ),
      onPressed: onPressed,
    ),
    centerTitle: false,
    leadingWidth: R.sW(context, 20),
    title: Text(
      title.tr(),
      style: TextStyle(
        color: AppColors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    actions: [
      if (isAction)
        Container(
            margin: EdgeInsets.symmetric(vertical: R.sH(context, 17)),
            child: const MoreInfoIcon()),
      if (isTrilling)
        GestureDetector(
          onTap: onTrillingPressed,
          child: Padding(
            padding: const EdgeInsets.only(right: 17),
            child: Icon(
              trillingIcon,
              color: AppColors.black,
              size: 30,
            ),
          ),
        ),
    ],
    backgroundColor: AppColors.white,
    elevation: 0,
  );
}

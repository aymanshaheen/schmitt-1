import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class ExpandebleMap extends StatelessWidget {
  const ExpandebleMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: R.sH(context, 5),
        ),
        Text(
          'housekeepings'.tr(),
          style: TextStyle(
            color: AppColors.homeBlackColor,
            fontSize: R.F(context, 16),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: R.sH(context, 5),
        ),
        Text(
          "\$50",
          style: TextStyle(
            color: AppColors.darkBlue,
            fontSize: R.F(context, 14),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: R.sH(context, 5),
        ),
        Text(
          "7,000 ${"reviews".tr()}",
          style: TextStyle(
            color: AppColors.grey,
            fontSize: R.F(context, 12),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

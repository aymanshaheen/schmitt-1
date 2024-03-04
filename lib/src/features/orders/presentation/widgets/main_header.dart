import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class MainHeader extends StatelessWidget {
  final String title;
  final Color color;
  const MainHeader({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'housekeepings'.tr(),
              style: TextStyle(
                color: AppColors.homeBlackColor,
                fontSize: R.F(context, 16),
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            CircleAvatar(
              radius: R.sW(context, 25),
              backgroundColor: AppColors.whiteBlue,
              child: SvgPicture.asset(
                AppImage.message,
                fit: BoxFit.cover,
              ),
            )
          ]),
          SizedBox(
            height: R.sH(context, 10),
          ),
          Row(
            children: [
              Text(
                '${'order_number'.tr()} : ',
                style: TextStyle(
                  color: AppColors.homeBlackColor,
                  fontSize: R.F(context, 12),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '54123',
                style: TextStyle(
                  color: AppColors.homeBlackColor,
                  fontSize: R.F(context, 12),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: R.sW(context, 10),
              ),
              Text(
                '${"order_date".tr()} : ',
                style: TextStyle(
                  color: AppColors.homeBlackColor,
                  fontSize: R.F(context, 12),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '12/12/2021',
                style: TextStyle(
                  color: AppColors.homeBlackColor,
                  fontSize: R.F(context, 12),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: R.sH(context, 10),
          ),
          Row(
            children: [
              Text(
                '${'cost'.tr()} : ',
                style: TextStyle(
                  color: AppColors.homeBlackColor,
                  fontSize: R.F(context, 12),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '\$50',
                style: TextStyle(
                  color: AppColors.lightBlue,
                  fontSize: R.F(context, 14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: R.sH(context, 10),
          ),
          Container(
            width: R.sW(context, 80),
            padding: EdgeInsets.symmetric(
              vertical: R.sH(context, 8),
              horizontal: R.sW(context, 8),
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: R.F(context, 12),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';


class BottomCarWashNavigationBar extends StatelessWidget {
  const BottomCarWashNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: R.sW(context, 10), vertical: R.sH(context, 10)),
      height: R.sH(context, 90),
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: R.sW(context, 140),
            height: R.sH(context, 55),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.whiteBlue,
            ),
            child: Center(
              child: Text(
                'message'.tr(),
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontSize: R.F(context, 16),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.carWashServiceDetails );
            },
            child: Container(
              width: R.sW(context, 140),
              height: R.sH(context, 55),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.darkBlue,
              ),
              child: Center(
                child: Text(
                  'book_now'.tr(),
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: R.F(context, 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

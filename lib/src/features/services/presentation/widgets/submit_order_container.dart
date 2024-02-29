import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class CustomContainer extends StatelessWidget {
  final IconData icon;
  final String text1;
  final String text2;
  final void Function() onTap;

  const CustomContainer({
    super.key,
    required this.icon,
    required this.text1,
    required this.text2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: R.sW(context, 20), vertical: R.sH(context, 20)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.darkBlue,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.darkBlue, size: R.F(context, 20)),
          SizedBox(
            width: R.sW(context, 5),
          ),
          Text(
            text1,
            style: TextStyle(
              fontSize: R.F(context, 16),
              fontWeight: FontWeight.w600,
              color: AppColors.darkBlue,
            ),
          ),
          SizedBox(
            width: R.sW(context, 5),
          ),
          Text(
            text2,
            style: TextStyle(
              fontSize: R.F(context, 16),
              fontWeight: FontWeight.w600,
              color: AppColors.darkBlue,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            AppImage.edit,
            color: AppColors.darkBlue,
          ),
          SizedBox(
            width: R.sW(context, 5),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              'edit'.tr(),
              style: TextStyle(
                fontSize: R.F(context, 16),
                fontWeight: FontWeight.w600,
                color: AppColors.darkBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

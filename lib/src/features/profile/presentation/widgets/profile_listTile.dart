import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class ProfileListTile extends StatelessWidget {
  final bool modeSwitch;
  final bool isTrailing;
  final String title;
  final String icon;
  final bool isLogout;
  final bool switchModeValue;
  final Function()? onTap;
  final Function(bool)? onSwitchChanged;
  const ProfileListTile({
    super.key,
    this.isTrailing = true,
    required this.title,
    required this.icon,
    this.isLogout = false,
    this.modeSwitch = false,
    this.onTap,
    this.onSwitchChanged,
    required this.switchModeValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: R.sH(context, 50),
      width: AppConstants.profile!.localedType != "مزود الخدمة"
          ? R.W(context) * 0.95
          : R.W(context) * 0.84,
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          leading: SvgPicture.asset(
            color: isLogout ? AppColors.logoutRedColor : AppColors.black,
            icon,
            width: R.sW(context, 20),
            height: R.sH(context, 20),
          ),
          title: Text(
            title.tr(),
            style: TextStyle(
              color: isLogout
                  ? AppColors.logoutRedColor
                  : AppColors.onBoardingFirstPageOriginalTextColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 0.08,
              letterSpacing: 0.20,
            ),
          ),
          trailing: isTrailing
              ? Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.black,
                  size: R.sW(context, 20),
                )
              : modeSwitch
                  ? Switch(
                      value: switchModeValue,
                      onChanged: onSwitchChanged,
                      activeTrackColor: AppColors.homeBlueColor,
                      activeColor: AppColors.homeDividerColor,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: AppColors.homeDividerColor,
                    )
                  : null,
        ),
      ),
    );
  }
}

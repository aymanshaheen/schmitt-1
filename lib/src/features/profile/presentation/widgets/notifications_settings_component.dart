import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class NotificationsSettingsComponent extends StatelessWidget {
  final bool switchValue;
  final String title;
  final Function(bool value) onChange;
  const NotificationsSettingsComponent(
      {super.key,
      required this.title,
      required this.switchValue,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: R.sW(context, 10),
          right: R.sW(context, 10),
          bottom: R.sH(context, 10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.tr(),
            style: const TextStyle(
              color: Color(0xFF424242),
              fontSize: 18,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600,
              height: 0.08,
              letterSpacing: 0.20,
            ),
          ),
          Switch(
            activeTrackColor: AppColors.homeBlueColor,
            activeColor: AppColors.homeDividerColor,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: AppColors.homeDividerColor,
            value: switchValue,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}

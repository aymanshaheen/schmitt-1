import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:flutter/services.dart';


class ExitBottomSheet extends StatelessWidget {
  const ExitBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: R.sH(context, 150),
      padding: EdgeInsets.symmetric(
        horizontal: R.sW(context, 10),
        vertical: R.sH(context, 20),
      ),
      child: Column(
        children: <Widget>[
          Text(
            'are_you_sure_you_want_to_exit'.tr(),
            style: TextStyle(
                fontSize: R.F(context, 18),
                fontWeight: FontWeight.w600,
                color: AppColors.error),
          ),
          SizedBox(height: R.sH(context, 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(false);
                },
                child: Container(
                  width: R.sW(context, 150),
                  padding: EdgeInsets.symmetric(
                    horizontal: R.sW(context, 20),
                    vertical: R.sH(context, 10),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'no'.tr(),
                      style: TextStyle(
                          fontSize: R.F(context, 16),
                          fontWeight: FontWeight.w600,
                          color: AppColors.white),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(true);
                      SystemNavigator.pop();

                },
                child: Container(
                  width: R.sW(context, 150),
                  padding: EdgeInsets.symmetric(
                    horizontal: R.sW(context, 20),
                    vertical: R.sH(context, 10),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.darkBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'yes_exit'.tr(),
                      style: TextStyle(
                          fontSize: R.F(context, 16),
                          fontWeight: FontWeight.w600,
                          color: AppColors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

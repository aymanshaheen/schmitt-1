import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class HeaderExpanded extends StatelessWidget {
  final String title;
  final Color color;
  final void Function() onTap;
  const HeaderExpanded(
      {super.key,
      required this.title,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: R.sW(context, 80),
              height: R.sH(context, 80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  AppImage.houseKeeping,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: R.sW(context, 10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: R.sW(context, 210),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'order_number'.tr() + ' #6546213',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: R.F(context, 12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(

                        padding: EdgeInsets.symmetric(
                          vertical: R.sH(context, 4),
                          horizontal: R.sW(context, 4),
                        ),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            title,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: R.F(context, 10),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: R.sH(context, 10),
                ),
                SizedBox(
                  width: R.sW(context, 180),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'housekeepings'.tr(),
                        style: TextStyle(
                          color: AppColors.darkBlue,
                          fontSize: R.F(context, 16),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '125 دولار',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.darkBlue,
                            fontSize: R.F(context, 12),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: R.sH(context, 10),
                ),
                SizedBox(
                  width: R.sW(context, 180),
                  child: Row(
                    children: [
                      Icon(Icons.location_on,
                          color: AppColors.grey, size: R.F(context, 16)),
                      Flexible(
                        child: Text(
                          '51, 5th Avenue, New York, USA',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: R.F(context, 12),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            InkWell(
                onTap: onTap,
                child: Icon(Icons.arrow_forward_ios,
                    color: AppColors.black, size: R.F(context, 20))),
          ],
        ),
        SizedBox(
          height: R.sH(context, 10),
        ),
        Divider(
          color: AppColors.grey1,
          thickness: 1,
          indent: R.sW(context, 5),
          endIndent: R.sW(context, 40),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.calendar_month,
                color: AppColors.grey, size: R.F(context, 20)),
            SizedBox(
              width: R.sW(context, 5),
            ),
            Text(
              ' الاثنين 15/2/2024',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: R.F(context, 12),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: R.sW(context, 20),
            ),
            Icon(Icons.access_time,
                color: AppColors.grey, size: R.F(context, 20)),
            SizedBox(
              width: R.sW(context, 5),
            ),
            Text(
              'clock'.tr() + ' 12:00 PM',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: R.F(context, 12),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: R.sW(context, 20),
            ),
            Icon(Icons.location_on_outlined,
                color: AppColors.darkBlue, size: R.F(context, 20)),
          ],
        )
      ],
    );
  }
}

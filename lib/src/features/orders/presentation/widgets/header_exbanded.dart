import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class HeaderExpanded extends StatelessWidget {
  final String title;
  final Color color;
  final Order order;
  final void Function() onTap;
  const HeaderExpanded(
      {super.key,
      required this.title,
      required this.order,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    Map<int, String> weekdaysInArabic = {
      1: 'الاثنين',
      2: 'الثلاثاء',
      3: 'الأربعاء',
      4: 'الخميس',
      5: 'الجمعة',
      6: 'السبت',
      7: 'الأحد',
    };
    Map<int, String> weekdaysInEnglish = {
      1: 'Monday',
      2: 'Tuesday',
      3: 'Wednesday',
      4: 'Thursday',
      5: 'Friday',
      6: 'Saturday',
      7: 'Sunday',
    };
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
                  child: CachedNetworkImage(
                    imageUrl: order.services!.first.image!.url!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularIndicator(
                      color: AppColors.darkBlue,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )),
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
                        'order_number'.tr() + ' #${order.orderNum}',
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
                        order.services!.first.category!.name!,
                        style: TextStyle(
                          color: AppColors.darkBlue,
                          fontSize: R.F(context, 16),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          order.services!.first.price.toString() + ' \$',
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
                          order.address!.address ?? '',
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
              '${Localizations.localeOf(context).languageCode != 'en' ? weekdaysInArabic[DateTime.parse(order.startAt!).weekday] : weekdaysInEnglish[DateTime.parse(order.startAt!).weekday]} ${DateTime.parse(order.startAt!).day}/${DateTime.parse(order.startAt!).month}/${DateTime.parse(order.startAt!).year}',
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

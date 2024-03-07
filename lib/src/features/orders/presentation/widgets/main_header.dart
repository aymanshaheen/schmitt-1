import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class MainHeader extends StatelessWidget {
  final Order order;

  const MainHeader({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              order.services!.first.category!.name!,
              style: TextStyle(
                color: AppColors.homeBlackColor,
                fontSize: R.F(context, 16),
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Container(
              width: R.sW(context, 50),
              height: R.sH(context, 50),
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
                order.orderNum!.toString(),
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
                order.startAt!.substring(0, 10),
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
                '\$${order.price}',
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
              vertical: R.sH(context, 4),
              horizontal: R.sW(context, 4),
            ),
            decoration: BoxDecoration(
              color: order.status == "starting"
                  ? AppColors.yellow
                  : order.status == "completed"
                      ? AppColors.green
                      : AppColors.darkBlue,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                order.status == "starting"
                    ? 'on_going'.tr()
                    : order.status == "completed"
                        ? 'completed'.tr()
                        : 'upcoming'.tr(),
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
    );
  }
}

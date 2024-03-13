import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/functions/date_converter.dart';
import 'package:schmitt/src/core/utils/app_strings.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class ExpandebleMap extends StatelessWidget {
  final Order order;
  const ExpandebleMap({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "date_and_time".tr(),
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "${DateTime.parse(order.startAt!).day}/${DateTime.parse(order.startAt!).month}/${DateTime.parse(order.startAt!).year} | ${ConverterDate.formatTime(DateTime.parse(order.startAt!))}",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        SizedBox(
          height: R.sH(context, 10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "address".tr(),
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              order.address?.address ?? "",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(
          height: R.sH(context, 10),
        ),
        order.address != null ? SizedBox(
          height: R.sH(context, 200),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              "https://maps.googleapis.com/maps/api/staticmap?center=${order.address!.locationLatitude},${order.address!.locationLongitude}&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C${order.address!.locationLatitude},${order.address!.locationLongitude}&key=${AppStrings.googleAPIKey}",
              fit: BoxFit.cover,
            ),
          ),
        ) : const SizedBox.shrink()
      ],
    );
  }
}

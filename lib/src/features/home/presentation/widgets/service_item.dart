import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class ServiceItem extends StatefulWidget {
  final String title;
  const ServiceItem({super.key, required this.title});

  @override
  State<ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: R.sH(context, 5),
        horizontal: R.sW(context, 15),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(R.sW(context, 15)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: R.sW(context, 90),
              height: R.sH(context, 70),
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
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: R.sH(context, 5),
              ),
              Text(
                widget.title,
                style: TextStyle(
                  color: AppColors.homeBlackColor,
                  fontSize: R.F(context, 16),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: R.sH(context, 5),
              ),
              Text(
                "\$50",
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontSize: R.F(context, 14),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: R.sH(context, 5),
              ),
              Text(
                "7,000 ${"reviews".tr()}",
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: R.F(context, 12),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ]),
            const Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  isFavourite = !isFavourite;
                });
              },
              child: Icon(
                !isFavourite
                    ? Icons.bookmark_outline_rounded
                    : Icons.bookmark_rounded,
                color: AppColors.darkBlue,
                size: R.sW(context, 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

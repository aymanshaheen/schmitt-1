import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
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
        children: [
          Row(
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
              Expanded(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.services!.first.category!.name!,
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
                            '${DateTime.parse(order.startAt!).day}/${DateTime.parse(order.startAt!).month}/${DateTime.parse(order.startAt!).year}',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: R.F(context, 14),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: R.sH(context, 5),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: R.sH(context, 5),
                              horizontal: R.sW(context, 10),
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
                      const Spacer(),
                      Container(
                        width: R.sW(context, 50),
                        height: R.sH(context, 50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.grey1),
                        padding: EdgeInsets.all(R.sW(context, 10)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: SvgPicture.asset(
                            AppImage.message,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
          SizedBox(
            height: R.sH(context, 10),
          ),
          Divider(
            color: AppColors.grey1,
            thickness: 1,
          ),
       
        ],
      ),
    );
  }
}

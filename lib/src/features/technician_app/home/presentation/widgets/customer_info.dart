import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class CustomerInfo extends StatefulWidget {
  final Order order;
  const CustomerInfo({super.key,required this.order});

  @override
  State<CustomerInfo> createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: R.sW(context, 20),
          vertical: R.sH(context, 30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: R.sW(context, 120),
              height: R.sH(context, 120),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: CachedNetworkImage(
                    imageUrl: widget.order.services!.first.image!.url!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularIndicator(
                      color: AppColors.darkBlue,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )),
            ),
            SizedBox(
              height: R.sH(context, 50),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'phone'.tr(),
                      style: TextStyle(
                        fontSize: R.F(context, 18),
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                    SizedBox(
                      height: R.sH(context, 5),
                    ),
                    Text(
                      widget.order.customer!.phone!,
                      style: TextStyle(
                        fontSize: R.F(context, 16),
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  child: SvgPicture.asset(
                    AppImage.call,
                    color: AppColors.darkBlue,
                    height: R.sH(context, 30),
                    width: R.sW(context, 30),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: R.sH(context, 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'place'.tr(),
                      style: TextStyle(
                        fontSize: R.F(context, 18),
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                    SizedBox(
                      height: R.sH(context, 5),
                    ),
                    Text(
                      widget.order.address?.address??'',
                      style: TextStyle(
                        fontSize: R.F(context, 16),
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
                InkWell(
                    onTap: () {
                      setState(() {});
                    },
                    child: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.darkBlue,
                      size: R.sH(context, 30),
                    )),
              ],
            ),
            SizedBox(
              height: R.sH(context, 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'chat'.tr(),
                  style: TextStyle(
                    fontSize: R.F(context, 18),
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  child: Icon(
                    Icons.chat_bubble_outline_sharp,
                    color: AppColors.darkBlue,
                    size: R.sH(context, 30),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/dotted_check_box.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class PaymentContainer extends StatelessWidget {
  const PaymentContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: R.sW(context, 20), vertical: R.sH(context, 20)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.darkBlue,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          CustomPaint(
            size: Size(R.sW(context, 16), R.sW(context, 16)),
            painter: DottedCirclePainter(isChecked: true),
          ),
          SizedBox(
            width: R.sW(context, 5),
          ),
          SvgPicture.asset(
            AppImage.card,
          ),
          SizedBox(
            width: R.sW(context, 5),
          ),
          Text(
            "xxxxxxxxxxx1234",
            style: TextStyle(
              fontSize: R.F(context, 16),
              fontWeight: FontWeight.w600,
              color: AppColors.grey1,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            AppImage.edit,
            color: AppColors.darkBlue,
          ),
          SizedBox(
            width: R.sW(context, 5),
          ),
          InkWell(
             onTap: () {
                Navigator.pushNamed(context, Routes.orderService, arguments: 3);
              },
            child: Text(
              'edit'.tr(),
              style: TextStyle(
                fontSize: R.F(context, 16),
                fontWeight: FontWeight.w600,
                color: AppColors.darkBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_cubit.dart';

class RatingService extends StatelessWidget {
  const RatingService({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: <Widget>[
            Icon(
              Icons.star,
              color: AppColors.yellow,
              size: R.sW(context, 25),
            ),
            SizedBox(width: R.sW(context, 5)),
            Text(
              '${ServiceCubit.get(context).getAverageRating()}',
              style: TextStyle(
                color: Colors.black,
                fontSize: R.F(context, 16),
              ),
            ),
            SizedBox(width: R.sW(context, 5)),
            Text(
              '(${ServiceCubit.get(context).reviews!.length.toString()} ${"reviews".tr()})',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: R.F(context, 14),
              ),
            ),
          ],
        ),
        Text(
          'see_all'.tr(),
          textAlign: TextAlign.right,
          style: TextStyle(
            color: AppConstants.service!.category!.id == 4
                ? AppColors.purple
                : AppColors.homeBlueColor,
            fontSize: R.F(context, 16),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.20,
          ),
        )
      ],
    );
  }
}

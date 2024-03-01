import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_cubit.dart';

class RatingServiceItem extends StatelessWidget {
  const RatingServiceItem(
      {required this.title, required this.onTap, super.key});
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: R.sW(context, 5)),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: R.sW(context, 15)),
            height: R.sH(context, 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: AppColors.darkBlue,
                width: R.sW(context, 2),
              ),
              color: ServiceCubit.get(context).tabbedOffer ==
                      ServiceCubit.get(context).offersList.indexOf(title)
                  ? AppColors.darkBlue
                  : AppColors.white,
            ),
            child: Center(
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: ServiceCubit.get(context).tabbedOffer !=
                            ServiceCubit.get(context).offersList.indexOf(title)
                        ? AppColors.darkBlue
                        : AppColors.white,
                    size: R.sW(context, 20),
                  ),
                  SizedBox(
                    width: R.sW(context, 10),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: ServiceCubit.get(context).tabbedOffer !=
                              ServiceCubit.get(context)
                                  .offersList
                                  .indexOf(title)
                          ? AppColors.darkBlue
                          : AppColors.white,
                      fontSize: R.F(context, 16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
            ),
      ),
    );
  }
}

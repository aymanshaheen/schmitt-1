import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/packages/presentation/cubit/package_cubit.dart';
import 'package:schmitt/src/features/packages/presentation/widgets/display_stars.dart';

class DisplayRating extends StatelessWidget {
  const DisplayRating({super.key});

  @override
  Widget build(BuildContext context) {
    Map<int, double> reviewCounts = PackageCubit.get(context).getReviewCounts();
    double totalCount = reviewCounts.values.reduce((a, b) => a + b);
    return BlocBuilder<PackageCubit, PackageStates>(
      builder: (context, state) {
        if (PackageCubit.get(context).reviews!.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          children: [
            SizedBox(
              height: R.sH(context, 10),
            ),
            Center(
              child: Text(
                PackageCubit.get(context)
                    .getAverageRating()
                    .toString()
                    .substring(0, 3),
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: R.F(context, 28),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            StarDisplay(value: PackageCubit.get(context).getAverageRating()),
            SizedBox(
              height: R.sH(context, 10),
            ),
            Center(
              child: Text(
                "(${PackageCubit.get(context).reviews!.length}) " +
                    "there_is_50_user_have_rated_this_package".tr(),
                style: TextStyle(
                  color: AppColors.lightGrey,
                  fontSize: R.F(context, 18),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: R.sH(context, 190),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reviewCounts.length,
                itemBuilder: (context, index) {
                  int rating = reviewCounts.keys.elementAt(index);
                  double count = reviewCounts[rating]!;
                  double percentage = (count / totalCount) * 100;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: R.sW(context, 10),
                        vertical: R.sH(context, 5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: R.sW(context, 43),
                          child: Text(
                            '$rating ' + 'stars'.tr(),
                            style: TextStyle(
                              color: AppColors.lightGrey,
                              fontSize: R.F(context, 14),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              width: R.sW(context, 220),
                              height: R.sH(context, 20),
                              decoration: BoxDecoration(
                                color: AppColors.grey1,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            Container(
                              width: R.sW(context, 220) * (count / totalCount),
                              height: R.sH(context, 20),
                              decoration: BoxDecoration(
                                color: AppColors.black,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: R.sW(context, 45),
                          child: Text(
                            '${percentage.toStringAsFixed(1)}%',
                            style: TextStyle(
                              color: AppColors.lightGrey,
                              fontSize: R.F(context, 14),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

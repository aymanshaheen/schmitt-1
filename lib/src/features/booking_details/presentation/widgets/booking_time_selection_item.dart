import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/booking_details/presentation/cubit/booking_details_cubit.dart';

class BookingTimeSelectionItem extends StatelessWidget {
  const BookingTimeSelectionItem(
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
            width: R.sW(context, 85),
            padding: EdgeInsets.symmetric(horizontal: R.sW(context, 3)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(110),
              border: Border.all(
                color: AppColors.darkBlue,
                width: R.sW(context, 2),
              ),
              color: BookingDetailsCubit.get(context).timeSelected ==
                      BookingDetailsCubit.get(context)
                          .selectionTimeList
                          .indexOf(title)
                  ? AppColors.darkBlue
                  : AppColors.white,
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: BookingDetailsCubit.get(context).timeSelected !=
                          BookingDetailsCubit.get(context)
                              .selectionTimeList
                              .indexOf(title)
                      ? AppColors.darkBlue
                      : AppColors.white,
                  fontSize: R.F(context, 16),
                  fontWeight: FontWeight.w600,
                ),
              ),
            )),
      ),
    );
  }
}

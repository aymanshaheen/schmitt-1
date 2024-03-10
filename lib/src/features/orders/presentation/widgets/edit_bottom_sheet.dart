import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/app_strings.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/orders/presentation/cubit/booking_cubit.dart';
import 'package:schmitt/src/features/orders/presentation/cubit/booking_state.dart';

class EditBottomSheet extends StatelessWidget {
  final Order order;

  const EditBottomSheet({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingStates>(
        listener: (context, state) {
      if (state is CancleOrderSuccess) {
        BookingCubit.get(context).getMyOrders(AppStrings.technicianAssigned);
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      if (state is CancleOrderLoading) {
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: R.sW(context, 10), vertical: R.sH(context, 10)),
            height: R.sH(context, 200),
            child: Center(
                child: CircularIndicator(
              color: AppColors.darkBlue,
            )));
      }
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: R.sW(context, 10), vertical: R.sH(context, 10)),
        height: R.sH(context, 200),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Text(
              'edit_order'.tr(),
              style: TextStyle(
                color: AppColors.error,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: R.sH(context, 20),
            ),
         
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    BookingCubit.get(context).cancleOrder(order.id!.toInt());
                  },
                  child: Container(
                    width: R.sW(context, 140),
                    height: R.sH(context, 55),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.darkBlue,
                    ),
                    child: Center(
                      child: Text(
                        'edit_address'.tr(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: R.F(context, 16),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: R.sW(context, 140),
                    height: R.sH(context, 55),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.whiteBlue,
                    ),
                    child: Center(
                      child: Text(
                        'edit_date'.tr(),
                        style: TextStyle(
                          color: AppColors.darkBlue,
                          fontSize: R.F(context, 16),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}

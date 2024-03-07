import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_state.dart';

class DeleteCarBottomSheet extends StatelessWidget {
  final bool isCar;
  const DeleteCarBottomSheet({super.key, required this.isCar});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceStates>(
        listener: (context, state) {
      if (state is DeleteCarLoaded) {
        isCar
            ? ServiceCubit.get(context).getCars(1)
            : ServiceCubit.get(context).getAdresses();
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      if (state is DeleteCarLoading) {
        return SizedBox(
          height: R.sH(context, 150),
          child: Center(
            child: CircularIndicator(
              color: AppColors.darkBlue,
            ),
          ),
        );
      }
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: R.sW(context, 10), vertical: R.sH(context, 15)),
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
              'delete'.tr(),
              style: TextStyle(
                color: AppColors.error,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: R.sH(context, 30),
            ),
            Text(
              'are_you_sure_you_want_to_delete_this_item'.tr(),
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: R.sH(context, 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    isCar
                        ? ServiceCubit.get(context)
                            .deleteCar(AppConstants.selectEdit!)
                        : ServiceCubit.get(context)
                            .deleteAddress(AppConstants.selectEdit!);
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
                        'yes_delete'.tr(),
                        style: TextStyle(
                          color: AppColors.darkBlue,
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
                      color: AppColors.darkBlue,
                    ),
                    child: Center(
                      child: Text(
                        'cancle'.tr(),
                        style: TextStyle(
                          color: AppColors.white,
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

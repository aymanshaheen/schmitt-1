import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_state.dart';

class ServiceOrder extends StatefulWidget {
  const ServiceOrder({super.key});

  @override
  State<ServiceOrder> createState() => _ServiceOrderState();
}

class _ServiceOrderState extends State<ServiceOrder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceStates>(builder: (context, state) {
      int total = ServiceCubit.get(context).calculateTotalPrice();
      return Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.darkBlue,
              width: 1,
            )),
        child: Padding(
          padding: EdgeInsets.all(R.sW(context, 15)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: R.sW(context, 80),
                height: R.sH(context, 80),
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
                  height: R.sH(context, 15),
                ),
                Text(
                  'housekeepings'.tr(),
                  style: TextStyle(
                    color: AppColors.homeBlackColor,
                    fontSize: R.F(context, 16),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: R.sH(context, 10),
                ),
                Text(
                  "$total" + "dollar".tr(),
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: R.F(context, 14),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ]),
              const Spacer(),
              Column(
                children: [
                  Row(
                    children: [
                      FloatingActionButton(
                        mini: true,
                        elevation: 0,
                        onPressed: () {},
                        child: Icon(Icons.add, color: AppColors.green),
                      ),
                      Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontSize: R.F(context, 16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        mini: true,
                        elevation: 0,
                        onPressed: () {},
                        child: Icon(Icons.remove, color: AppColors.error),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.selectRooms,
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.edit,
                            color: AppColors.darkBlue, size: R.F(context, 20)),
                        SizedBox(
                          width: R.sW(context, 10),
                        ),
                        Text(
                          'edit'.tr(),
                          style: TextStyle(
                            fontSize: R.F(context, 14),
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

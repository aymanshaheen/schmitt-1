import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_state.dart';
import 'package:schmitt/src/features/services/presentation/widgets/add_car_bottom_sheet.dart';
import 'package:schmitt/src/features/services/presentation/widgets/car_item.dart';

import '../../../../core/widgets/responsivity.dart';

class CarWashScreen extends StatefulWidget {
  const CarWashScreen({super.key});

  @override
  State<CarWashScreen> createState() => _CarWashScreenState();
}

class _CarWashScreenState extends State<CarWashScreen> {
  @override
  void initState() {
    ServiceCubit.get(context).getCars(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: R.sW(context, 25),
        title: Text(
          'my_cars'.tr(),
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: [
          Container(
              margin: EdgeInsets.symmetric(vertical: R.sH(context, 17)),
              child: const MoreInfoIcon()),
          SizedBox(
            width: R.sW(context, 15),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: R.sW(context, 20), vertical: R.sH(context, 20)),
          child: BlocConsumer<ServiceCubit, ServiceStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetCarsLoading) {
                return SizedBox(
                  height: R.sH(context, 600),
                  child: Center(
                    child: CircularIndicator(
                      color: AppColors.darkBlue,
                    ),
                  ),
                );
              }
              if (state is! GetCarsLoading &&
                  ServiceCubit.get(context).cars!.isEmpty) {
                return SizedBox(
                  height: R.sH(context, 600),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: R.sH(context, 100),
                        ),
                        SvgPicture.asset(
                          AppImage.car,
                          fit: BoxFit.cover,
                          width: R.sW(context, 100),
                          height: R.sH(context, 100),
                        ),
                        Text(
                          'no_cars'.tr(),
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: R.sH(context, 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: const MyBottomSheet(),
                              ),
                            );
                          },
                          child: FullRounderContainer(
                            title: 'add_car'.tr(),
                            containerColor: AppColors.darkBlue,
                            textColor: AppColors.white,
                            circular: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  ListView.builder(
                    itemCount: ServiceCubit.get(context).cars!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CarItem(
                        services: ServiceCubit.get(context).cars![index],
                      );
                    },
                  ),
                  SizedBox(
                    height: R.sH(context, 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: const MyBottomSheet(),
                        ),
                      );
                    },
                    child: FullRounderContainer(
                      title: 'add_car'.tr(),
                      containerColor: AppColors.darkBlue,
                      textColor: AppColors.white,
                      circular: 20,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/core/widgets/snakbar_builder.dart';
import 'package:schmitt/src/features/services/domain/entities/car.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_state.dart';
import '../../../../core/widgets/responsivity.dart';

class CarWashDetailsScreen extends StatefulWidget {
  const CarWashDetailsScreen({super.key});

  @override
  State<CarWashDetailsScreen> createState() => _CarWashDetailsScreenState();
}

class _CarWashDetailsScreenState extends State<CarWashDetailsScreen> {
  CarDataEntity? selectedCar;
  @override
  void initState() {
    ServiceCubit.get(context).getCars(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ServiceCubit serviceCubit = ServiceCubit.get(context);
          if (state is GetCarsLoading) {
            return Scaffold(
              body: Center(
                child: CircularIndicator(
                  color: AppColors.darkBlue,
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              leadingWidth: R.sW(context, 25),
              elevation: 0,
              title: Text(
                AppConstants.service!.title,
                style: TextStyle(
                  fontSize: R.F(context, 18),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: R.sW(context, 20), vertical: R.sH(context, 10)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'set_the_name_of_car_and_model_you_want_to_wash'.tr(),
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: R.F(context, 16),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: R.sH(context, 10),
                      ),
                      Text(
                        'car_type'.tr(),
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: R.F(context, 18),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: R.sH(context, 10),
                      ),
                      Container(
                        height: R.sH(context, 60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grey1!,
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: R.sW(context, 10),
                              left: R.sW(context, 10)),
                          child: Center(
                            child: DropdownButton(
                              iconSize: 30,
                              underline: const SizedBox(),
                              borderRadius: BorderRadius.circular(10),
                              hint: Text(
                                'car_type'.tr(),
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: R.F(context, 14),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              value: selectedCar,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: R.F(context, 14),
                                fontWeight: FontWeight.w600,
                              ),
                              isExpanded: true,
                              items: serviceCubit.cars!
                                  .map((CarDataEntity car) =>
                                      DropdownMenuItem<CarDataEntity>(
                                        value: car,
                                        child: Text(car.name!),
                                      ))
                                  .toList(),
                              onChanged: (CarDataEntity? newCar) {
                                setState(() {
                                  selectedCar = newCar;
                                  serviceCubit.showCar(newCar!.id!);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: R.sH(context, 20),
                      ),
                      Text(
                        'car_model'.tr(),
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: R.F(context, 18),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: R.sH(context, 10),
                      ),
                      Container(
                        width: R.sW(context, 350),
                        height: R.sH(context, 55),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.grey1,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: R.sW(context, 10),
                            vertical: R.sH(context, 10)),
                        child: BlocBuilder<ServiceCubit, ServiceStates>(
                            builder: (context, state) {
                          if (state is ShowCarLoading) {
                            return Center(
                              child: CircularIndicator(
                                color: AppColors.darkBlue,
                              ),
                            );
                          }
                          return Align(
                            alignment: EasyLocalization.of(context)
                                        ?.locale
                                        .languageCode ==
                                    "ar"
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Text(
                              selectedCar != null
                                  ? serviceCubit.car!.car!.name!
                                  : 'car_model'.tr(),
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: R.F(context, 16),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        height: R.sH(context, 20),
                      ),
                      Text(
                        'car_number'.tr(),
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: R.F(context, 18),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: R.sH(context, 10),
                      ),
                      Container(
                        width: R.sW(context, 350),
                        height: R.sH(context, 55),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.grey1,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: R.sW(context, 10),
                            vertical: R.sH(context, 10)),
                        child: BlocBuilder<ServiceCubit, ServiceStates>(
                            builder: (context, state) {
                          if (state is ShowCarLoading) {
                            return Center(
                              child: CircularIndicator(
                                color: AppColors.darkBlue,
                              ),
                            );
                          }
                          return Align(
                            alignment: EasyLocalization.of(context)
                                        ?.locale
                                        .languageCode ==
                                    "ar"
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Text(
                              selectedCar != null
                                  ? serviceCubit.car!.plate!
                                  : 'car_number'.tr(),
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: R.F(context, 16),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        height: R.sH(context, 20),
                      ),
                    ]),
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: R.sW(context, 20), vertical: R.sH(context, 20)),
              height: R.sH(context, 90),
              color: AppColors.white,
              child: InkWell(
                onTap: () {
                  if (selectedCar == null) {
                    return buildSnakBar(
                        context: context,
                        message: 'please_select_car_first'.tr(),
                        color: AppColors.error);
                  }
                  Navigator.pushNamed(context, Routes.orderService,
                      arguments: 1);
                },
                child: FullRounderContainer(
                  title: 'continue'.tr() +
                      ' - ${selectedCar != null ? 30 : 0} ' +
                      'dollar'.tr(),
                  containerColor: AppColors.darkBlue,
                  textColor: AppColors.white,
                  circular: 30,
                ),
              ),
            ),
          );
        });
  }
}

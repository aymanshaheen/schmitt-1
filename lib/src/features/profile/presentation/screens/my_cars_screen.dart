import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/core/error/response_status.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/no_available_data.dart';
import 'package:schmitt/src/core/widgets/snakbar_builder.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_state.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/add_car_bottom_sheet.dart';
import 'package:schmitt/src/features/services/presentation/widgets/car_item.dart';

import '../../../../core/widgets/responsivity.dart';

class CarWashScreen extends StatefulWidget {
  const CarWashScreen({super.key});

  @override
  State<CarWashScreen> createState() => _CarWashScreenState();
}

class _CarWashScreenState extends State<CarWashScreen> {
  late final ScrollController _scrollController;
  int nextPage = 2;
  bool isLoading = false;
  @override
  void initState() {
    if (ServiceCubit.get(context).cars!.isEmpty) {
      ServiceCubit.get(context).getCars(1);
    }
    _scrollController = ScrollController();
    _scrollController.addListener(() async {
      if (nextPage <= ServiceCubit.get(context).metaCars!.lastPage) {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.6) {
          if (!isLoading) {
            isLoading = true;
            await context.read<ServiceCubit>().getCars(nextPage++);
            isLoading = false;
          }
        }
      }
    });
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
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: R.sW(context, 20), vertical: R.sH(context, 20)),
          child: BlocConsumer<ServiceCubit, ServiceStates>(
            listener: (context, state) {
              if (state is GetAddressesError &&
                      state.message ==
                          DataSource.networkConnectError.getFailure().message ||
                  state is GetAddressesError &&
                      state.message ==
                          DataSource.connectionTimeout.getFailure().message) {
                buildSnakBar(
                    context: context,
                    message: state.message,
                    color: AppColors.error);
              }
            },
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
                return Column(
                  children: [
                    SizedBox(
                      height: R.sH(context, 180),
                    ),
                    SvgPicture.asset(
                      AppImage.car,
                      fit: BoxFit.cover,
                      width: R.sW(context, 200),
                      height: R.sH(context, 200),
                    ),
                    SizedBox(
                      height: R.sH(context, 50),
                    ),
                    Text(
                      'no_cars_added_yet'.tr(),
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: R.sH(context, 150),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: const MyBottomSheet(
                              isEdit: false,
                            ),
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
              } else if (state is GetAddressesError &&
                      state.message ==
                          DataSource.networkConnectError.getFailure().message ||
                  state is GetAddressesError &&
                      state.message ==
                          DataSource.connectionTimeout.getFailure().message) {
                return const NoDataAvailable(
                    text: "check_your_internet_connection_please");
              }
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: const MyBottomSheet(
                            isEdit: false,
                          ),
                        ),
                      );
                    },
                    child: FullRounderContainer(
                      title: 'add_car'.tr(),
                      containerColor: AppColors.darkBlue,
                      textColor: AppColors.white,
                      circular: 20,
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 20),
                  ),
                  ListView.builder(
                    controller: _scrollController,
                    itemCount: ServiceCubit.get(context).cars!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CarItem(
                        services: ServiceCubit.get(context).cars![index],
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

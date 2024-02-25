import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors_dark.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_state.dart';

class SelectRoomsScreen extends StatelessWidget {
  const SelectRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ServiceCubit serviceCubit = ServiceCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              centerTitle: false,
              leadingWidth: R.sW(context, 25),
              elevation: 0,
              title: Text(
                'housekeepings'.tr(),
                style: TextStyle(
                  fontSize: R.F(context, 18),
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                const MoreInfoIcon(),
                SizedBox(
                  width: R.sW(context, 15),
                )
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(R.sH(context, 20)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: R.sW(context, 20),
                        bottom: R.sH(context, 10),
                        left: R.sW(context, 20)),
                    child: Text(
                      'numberto_clean'.tr(),
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: R.F(context, 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: R.sW(context, 30), vertical: R.sH(context, 20)),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: serviceCubit.roomsType.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: R.sH(context, 20)),
                          padding: EdgeInsets.symmetric(
                              horizontal: R.sW(context, 20),
                              vertical: R.sH(context, 10)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    serviceCubit.roomsType[index].tr(),
                                    style: TextStyle(
                                      fontSize: R.F(context, 16),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '\$${serviceCubit.roomsPrice[index].toString()}',
                                    style: TextStyle(
                                        fontSize: R.F(context, 14),
                                        fontWeight: FontWeight.w400,
                                        color: AppColorsDark.darkBlue),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                   FloatingActionButton(
                                    mini: true,
                                    elevation: 0,
                                    onPressed: () {
                                      serviceCubit.incrementRoomCount(index);
                                    },
                                    child:
                                        Icon(Icons.add, color: AppColors.black),
                                  ),
                                  Center(
                                    child: Text(
                                      serviceCubit.roomsCount[index].toString(),
                                      style: TextStyle(
                                        fontSize: R.F(context, 16),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ), FloatingActionButton(
                                    mini: true,
                                    elevation: 0,
                                    onPressed: () {
                                      serviceCubit.decrementRoomCount(index);
                                    },
                                    child: Icon(Icons.remove,
                                        color: AppColors.black),
                                  ),
                                
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: R.sW(context, 20), vertical: R.sH(context, 20)),
              height: R.sH(context, 90),
              color: AppColors.white,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.orderService,arguments: 1);
                },
                child: FullRounderContainer(
                  title: 'continue'.tr() + '- ${serviceCubit.calculateTotalPrice()} ' + 'dollar'.tr(),
                  containerColor: AppColors.darkBlue,
                  textColor: AppColors.white,                circular: 30,

                ),
              ),
            ),
          );
        });
  }
}
